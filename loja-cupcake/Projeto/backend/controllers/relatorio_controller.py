from flask import jsonify
from app import db

def relatorio_vendas():
    # Exemplo simples - retornar total de vendas
    resultado = db.session.execute("""
        SELECT DATE(data_criacao) AS data, SUM(valor_total) as total_vendas 
        FROM pedidos 
        GROUP BY DATE(data_criacao);
    """).fetchall()
    return jsonify([dict(row) for row in resultado])
