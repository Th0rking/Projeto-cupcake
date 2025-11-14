from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from flask_migrate import Migrate
from werkzeug.security import generate_password_hash, check_password_hash
from sqlalchemy import Enum
import enum

app = Flask(__name__)
app.config['SECRET_KEY'] = 'sua_chave_secreta_aqui'  # Altere para algo seguro
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:NovaSenhaSegura@localhost:3306/loja_cupcake'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)

login_manager = LoginManager(app)
login_manager.login_view = 'login'

class StatusPedido(enum.Enum):
    pendente = 'pendente'
    confirmado = 'confirmado'
    em_preparo = 'em_preparo'
    a_caminho = 'a_caminho'
    entregue = 'entregue'
    cancelado = 'cancelado'

class Usuario(UserMixin, db.Model):
    __tablename__ = 'usuarios'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False)
    cpf = db.Column(db.String(14), unique=True, nullable=False)
    telefone = db.Column(db.String(15), nullable=False)
    senha_hash = db.Column(db.String(255), nullable=False)
    tipo_usuario = db.Column(Enum('cliente', 'proprietario', 'colaborador'), nullable=True)
    ativo = db.Column(db.Boolean, default=True)

    def set_senha(self, senha):
        self.senha_hash = generate_password_hash(senha)

    def check_senha(self, senha):
        return check_password_hash(self.senha_hash, senha)

    def to_dict(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'email': self.email,
            'cpf': self.cpf,
            'telefone': self.telefone,
            'tipo_usuario': self.tipo_usuario,
            'ativo': self.ativo
        }

@login_manager.user_loader
def load_user(user_id):
    return Usuario.query.get(int(user_id))

@app.route('/')
def home():
    return "Loja Cupcake funcionando!"

@app.route('/register', methods=['POST'])
def register():
    dados = request.json
    if Usuario.query.filter_by(email=dados['email']).first():
        return jsonify({'erro': 'Email já cadastrado'}), 400

    usuario = Usuario(
        nome=dados['nome'],
        email=dados['email'],
        cpf=dados['cpf'],
        telefone=dados['telefone'],
        tipo_usuario=dados.get('tipo_usuario'),
        ativo=True
    )
    usuario.set_senha(dados['senha'])
    db.session.add(usuario)
    db.session.commit()
    return jsonify(usuario.to_dict()), 201

@app.route('/login', methods=['POST'])
def login():
    dados = request.json
    user = Usuario.query.filter_by(email=dados['email']).first()
    if user and user.check_senha(dados['senha']):
        login_user(user)
        return jsonify({'mensagem': 'Login realizado com sucesso'})
    return jsonify({'erro': 'Email ou senha inválidos'}), 401

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return jsonify({'mensagem': 'Logout realizado!'})

@app.route('/perfil')
@login_required
def perfil():
    return jsonify(current_user.to_dict())

class Produto(db.Model):
    __tablename__ = 'produtos'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    preco = db.Column(db.Float, nullable=False)

    def to_dict(self):
        return {'id': self.id, 'nome': self.nome, 'preco': self.preco}

@app.route('/produtos', methods=['GET'])
@login_required
def listar_produtos():
    produtos = Produto.query.all()
    return jsonify([p.to_dict() for p in produtos])

@app.route('/produtos', methods=['POST'])
@login_required
def criar_produto():
    dados = request.json
    novo = Produto(nome=dados['nome'], preco=dados['preco'])
    db.session.add(novo)
    db.session.commit()
    return jsonify(novo.to_dict()), 201

@app.route('/produtos/<int:id>', methods=['PUT'])
@login_required
def atualizar_produto(id):
    produto = Produto.query.get_or_404(id)
    dados = request.json
    produto.nome = dados.get('nome', produto.nome)
    produto.preco = dados.get('preco', produto.preco)
    db.session.commit()
    return jsonify(produto.to_dict())

@app.route('/produtos/<int:id>', methods=['DELETE'])
@login_required
def deletar_produto(id):
    produto = Produto.query.get_or_404(id)
    db.session.delete(produto)
    db.session.commit()
    return jsonify({'mensagem': 'Produto deletado com sucesso!'})

class Pedido(db.Model):
    __tablename__ = 'pedidos'

    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    status = db.Column(Enum(StatusPedido), nullable=True)
    valor_subtotal = db.Column(db.Float, nullable=False)
    valor_desconto = db.Column(db.Float, nullable=True)
    valor_total = db.Column(db.Float, nullable=False)
    observacoes = db.Column(db.Text, nullable=True)

    def to_dict(self):
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'status': self.status.value if self.status else None,
            'valor_subtotal': self.valor_subtotal,
            'valor_desconto': self.valor_desconto,
            'valor_total': self.valor_total,
            'observacoes': self.observacoes
        }

@app.route('/pedidos', methods=['GET'])
@login_required
def listar_pedidos():
    pedidos = Pedido.query.all()
    return jsonify([p.to_dict() for p in pedidos])

@app.route('/pedidos', methods=['POST'])
@login_required
def criar_pedido():
    dados = request.json
    novo = Pedido(
        usuario_id=dados['usuario_id'],
        status=StatusPedido[dados['status']] if 'status' in dados else None,
        valor_subtotal=dados['valor_subtotal'],
        valor_desconto=dados.get('valor_desconto'),
        valor_total=dados['valor_total'],
        observacoes=dados.get('observacoes')
    )
    db.session.add(novo)
    db.session.commit()
    return jsonify(novo.to_dict()), 201

if __name__ == '__main__':
    app.run(debug=True)
