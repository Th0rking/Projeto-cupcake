from app import db
from datetime import datetime
import bcrypt

class Usuario(db.Model):
    __tablename__ = 'usuarios'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False)
    cpf = db.Column(db.String(14), unique=True, nullable=False)
    telefone = db.Column(db.String(15), nullable=False)
    senha = db.Column(db.String(255), nullable=False)
    tipo_usuario = db.Column(db.Enum('cliente', 'proprietario', 'colaborador'), default='cliente')
    ativo = db.Column(db.Boolean, default=False)
    data_cadastro = db.Column(db.DateTime, default=datetime.utcnow)

    def set_senha(self, senha):
        self.senha = bcrypt.hashpw(senha.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    def verificar_senha(self, senha):
        return bcrypt.checkpw(senha.encode('utf-8'), self.senha.encode('utf-8'))

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
