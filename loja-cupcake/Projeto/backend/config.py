import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'minha_chave_secreta')
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'minha_chave_jwt')
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'mysql+mysqlconnector://root:senha@localhost/loja_cupcake')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
