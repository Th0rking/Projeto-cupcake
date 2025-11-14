from flask import Blueprint, request
from controllers.produto_controller import listar_produtos, cadastrar_produto
bp = Blueprint('produto', __name__)

@bp.route('/', methods=['GET'])
def get_produtos():
    return listar_produtos()

@bp.route('/', methods=['POST'])
def post_produtos():
    return cadastrar_produto()
