from flask import request, jsonify
from app import db
from models.pedido import Pedido

def criar_pedido():
    data = request.get_json()
    pedido = Pedido(
        usuario_id=data.get('usuario_id'),
        status='pendente',
        endereco_entrega_id=data.get('endereco_entrega_id'),
        valor_subtotal=data.get('valor_subtotal'),
        valor_desconto=data.get('valor_desconto', 0.0),
        valor_total=data.get('valor_total'),
        observacoes=data.get('observacoes'),
    )
    db.session.add(pedido)
    db.session.commit()
    return jsonify(pedido.to_dict()), 201
