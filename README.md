# Projeto-cupcake
Este projeto consiste em uma aplicação web para a venda de cupcakes. Desenvolvida com backend em Python usando Flask e banco de dados MySQL, a aplicação permite o cadastro de usuários, login, navegação pelos produtos, adição ao carrinho e finalização de compra. O objetivo é aplicar conceitos de Engenharia de Software, MVC, e garantir qualidade com testes automatizados.

Tecnologias
Python 3.10

Flask

MySQL 8.0

HTML, CSS, JavaScript

PyMySQL para conexão com banco

Pytest para testes

Estrutura do Projeto
text
/backend - código Python Flask  
/frontend - arquivos HTML, CSS, JS  
/models - modelos de banco de dados  
/tests - scripts de testes automatizados  
/docs - documentação adicional  
/feedbacks - registros de testes do usuário  
/videos - links para vídeo de demonstração  
Instalação e configuração
Clone o repositório
git clone https://github.com/Th0rking/Projeto-cupcake.git

Instale as dependências
pip install -r requirements.txt

Configure o banco de dados MySQL com as tabelas necessárias (modelo disponível em /models)

Ajuste as configurações de conexão com banco no arquivo de configuração do Flask (ex: config.py)

Execute aplicação localmente:
python backend/app.py

Uso
Acesse http://localhost:5000 no navegador para usar a aplicação. Cadastre-se, faça login, navegue pelos cupcakes, adicione ao carrinho e finalize seu pedido.

Testes
Execute os testes automáticos com:
pytest tests

Relatório de cobertura e resultados estará disponível após execução.

Contribuição
Pull requests são bem-vindos. Para contribuições maiores, abra uma issue primeiro para discutir as mudanças que deseja realizar.

Thiago Sales
[RGM: 19271778]
