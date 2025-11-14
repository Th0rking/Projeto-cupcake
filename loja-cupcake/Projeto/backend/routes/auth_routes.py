from flask import Blueprint, request
from controllers.auth_controller import cadastrar_usuario
bp = Blueprint('auth', __name__)

@bp.route('/cadastro', methods=['POST'])
def cadastro():
    return cadastrar_usuario()
