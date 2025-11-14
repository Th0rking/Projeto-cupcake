import pytest
from backend.models.pedido import Pedido

def test_criar_pedido():
    pedido = Pedido(usuario_id=1, status='pendente', valor_subtotal=50.0,
                    valor_desconto=5.0, valor_total=45.0)
    assert pedido.status == 'pendente'
    assert pedido.valor_total == 45.0
