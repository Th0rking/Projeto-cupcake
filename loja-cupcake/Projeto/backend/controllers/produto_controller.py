from flask import request, jsonify
from app import db
from models.produto import Produto

def listar_produtos():
    produtos = Produto.query.filter_by(ativo=True).all()
    return jsonify([p.to_dict() for p in produtos])

def cadastrar_produto():
    data = request.get_json()
    produto = Produto(
        nome=data.get('nome'),
        descricao=data.get('descricao'),
        preco=data.get('preco'),
        imagem_url=data.get('imagem_url'),
        categoria=data.get('categoria'),
        estoque=data.get('estoque'),
        ativo=True
    )
    db.session.add(produto)
    db.session.commit()
    return jsonify(produto.to_dict()), 201
