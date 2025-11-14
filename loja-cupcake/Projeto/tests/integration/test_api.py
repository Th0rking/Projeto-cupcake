import pytest
from app import create_app, db
from flask import json

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    client = app.test_client()

    with app.app_context():
        db.create_all()
        yield client
        db.drop_all()

def test_cadastro_usuario(client):
    resposta = client.post('/api/auth/cadastro', json={
        'nome': 'Teste',
        'email': 'teste@exemplo.com',
        'cpf': '12345678909',
        'telefone': '11987654321',
        'senha': 'SenhaForte123'
    })
    assert resposta.status_code == 201
    dados = json.loads(resposta.data)
    assert 'token' in dados
