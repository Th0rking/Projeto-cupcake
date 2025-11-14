import pytest
from backend.models.usuario import Usuario

def test_criar_usuario():
    user = Usuario(nome='Teste', email='teste@teste.com', cpf='12345678909',
                   telefone='11987654321', senha='senha123')
    assert user.nome == 'Teste'
    assert user.email == 'teste@teste.com'
