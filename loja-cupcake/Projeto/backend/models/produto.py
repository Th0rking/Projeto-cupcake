from app import db
from datetime import datetime

class Produto(db.Model):
    __tablename__ = 'produtos'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(255), nullable=False)
    descricao = db.Column(db.Text)
    preco = db.Column(db.Numeric(10, 2), nullable=False)
    imagem_url = db.Column(db.String(500))
    categoria = db.Column(db.Enum('classico', 'premium', 'vegano', 'sem_gluten', 'personalizado'), nullable=False)
    estoque = db.Column(db.Integer, default=0)
    ativo = db.Column(db.Boolean, default=True)
    data_cadastro = db.Column(db.DateTime, default=datetime.utcnow)
    data_atualizacao = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'preco': float(self.preco),
            'imagem_url': self.imagem_url,
            'categoria': self.categoria,
            'estoque': self.estoque,
            'ativo': self.ativo
        }
