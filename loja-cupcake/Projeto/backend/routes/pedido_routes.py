from flask import Blueprint, request
from controllers.pedido_controller import criar_pedido
bp = Blueprint('pedido', __name__)

@bp.route('/', methods=['POST'])
def post_pedido():
    return criar_pedido()
