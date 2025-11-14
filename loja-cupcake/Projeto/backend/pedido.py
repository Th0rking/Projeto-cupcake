from app import db
from datetime import datetime

class Pedido(db.Model):
    __tablename__ = 'pedidos'

    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    status = db.Column(db.Enum('pendente', 'confirmado', 'em_preparo', 'a_caminho', 'entregue', 'cancelado'), default='pendente')
    endereco_entrega_id = db.Column(db.Integer, nullable=False)
    cupom_id = db.Column(db.Integer, nullable=True)
    valor_subtotal = db.Column(db.Numeric(10, 2), nullable=False)
    valor_desconto = db.Column(db.Numeric(10, 2), default=0.00)
    valor_total = db.Column(db.Numeric(10, 2), nullable=False)
    observacoes = db.Column(db.Text)
    data_criacao = db.Column(db.DateTime, default=datetime.utcnow)
    data_atualizacao = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'usuario_id': self.usuario_id,
            'status': self.status,
            'valor_total': float(self.valor_total),
            # demais campos...
        }
