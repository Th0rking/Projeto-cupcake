import pytest
from backend.utils.validators import validar_cpf, validar_email, validar_telefone

def test_cpf_valido():
    assert validar_cpf('12345678909') == True

def test_cpf_invalido():
    assert validar_cpf('11111111111') == False

def test_email_valido():
    assert validar_email('teste@exemplo.com') == True

def test_email_invalido():
    assert validar_email('teste@') == False

def test_telefone_valido():
    assert validar_telefone('11987654321') == True

def test_telefone_invalido():
    assert validar_telefone('123') == False
