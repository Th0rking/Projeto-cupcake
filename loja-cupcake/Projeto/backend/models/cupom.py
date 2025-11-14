from app import db
from datetime import datetime

class Cupom(db.Model):
    __tablename__ = 'cupons_desconto'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(50), unique=True, nullable=False)
    tipo = db.Column(db.Enum('percentual', 'valor_fixo'), nullable=False)
    valor = db.Column(db.Numeric(10,2))
    percentual = db.Column(db.Numeric(5,2))
    data_inicio = db.Column(db.Date, nullable=False)
    data_fim = db.Column(db.Date, nullable=False)
    quantidade_total = db.Column(db.Integer, nullable=False)
    quantidade_usada = db.Column(db.Integer, default=0)
    valor_minimo = db.Column(db.Numeric(10,2), default=0.00)
    ativo = db.Column(db.Boolean, default=True)
    data_cadastro = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'tipo': self.tipo,
            'valor': float(self.valor) if self.valor else None,
            'percentual': float(self.percentual) if self.percentual else None,
            'ativo': self.ativo
        }
