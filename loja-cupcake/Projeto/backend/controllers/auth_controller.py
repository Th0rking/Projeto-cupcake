from flask import request, jsonify
from app import db
from models.usuario import Usuario
from utils.validators import validar_email, validar_cpf, validar_telefone
from flask_jwt_extended import create_access_token
from datetime import timedelta

def cadastrar_usuario():
    data = request.get_json()
    email = data.get('email')
    cpf = data.get('cpf')
    telefone = data.get('telefone')
    
    if not validar_email(email):
        return jsonify({'msg': 'Email inválido'}), 400
    if not validar_cpf(cpf):
        return jsonify({'msg': 'CPF inválido'}), 400
    if not validar_telefone(telefone):
        return jsonify({'msg': 'Telefone inválido'}), 400

    if Usuario.query.filter_by(email=email).first():
        return jsonify({'msg': 'Email já utilizado'}), 409
    if Usuario.query.filter_by(cpf=cpf).first():
        return jsonify({'msg': 'CPF já utilizado'}), 409
    
    usu = Usuario(
        nome=data.get('nome'),
        email=email,
        cpf=cpf,
        telefone=telefone
    )
    usu.set_senha(data.get('senha'))
    db.session.add(usu)
    db.session.commit()
    
    token = create_access_token(identity=usu.id, expires_delta=timedelta(hours=24))
    return jsonify({'msg':'Usuário cadastrado com sucesso', 'token': token}), 201
