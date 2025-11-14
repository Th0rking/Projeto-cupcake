# Projeto Loja do Cupcake

## Informações do Projeto
- **Nome:** Thiago Sales Tavares dos Santos
- **RGM:** 29714460
- **Disciplina:** Projeto Integrador Transdisciplinar em Engenharia de Software II
- **Data:** Outubro/2025

## Descrição do Projeto

Sistema web para gerenciamento de uma loja de cupcakes, permitindo que clientes personalizem e comprem cupcakes, enquanto proprietários gerenciam produtos, colaboradores e relatórios de vendas.

##  Ojetivos

- Facilitar o processo de compra de cupcakes online
- Permitir personalização de produtos
- Gerenciar estoque e colaboradores
- Gerar relatórios de vendas
- Aplicar cupons de desconto

##  Arquitetura

### Padrão MVC (Model-View-Controller)

```
loja-cupcake/
├── docs/                       # Documentação
│   ├── historias-usuario.md
│   ├── casos-uso-expandidos.md
│   ├── diagramas/
│   │   ├── caso-uso.puml
│   │   ├── classes.puml
│   │   ├── sequencia.puml
│   │   └── atividades.puml
│   └── wireframes/
├── frontend/                   # Interface do usuário
│   ├── index.html
│   ├── login.html
│   ├── cadastro.html
│   ├── menu.html
│   ├── carrinho.html
│   ├── montagem.html
│   ├── admin.html
│   ├── css/
│   │   └── styles.css
│   └── js/
│       ├── main.js
│       ├── auth.js
│       ├── carrinho.js
│       └── admin.js
├── backend/                    # Servidor e lógica de negócio
│   ├── app.py                 # Aplicação Flask
│   ├── config.py              # Configurações
│   ├── models/                # Models (Banco de dados)
│   │   ├── usuario.py
│   │   ├── produto.py
│   │   ├── pedido.py
│   │   ├── carrinho.py
│   │   └── cupom.py
│   ├── controllers/           # Controllers (Lógica)
│   │   ├── auth_controller.py
│   │   ├── produto_controller.py
│   │   ├── pedido_controller.py
│   │   └── relatorio_controller.py
│   ├── views/                 # Views (Rotas API)
│   │   ├── auth_routes.py
│   │   ├── produto_routes.py
│   │   └── pedido_routes.py
│   └── utils/
│       ├── validators.py
│       └── email_service.py
├── database/                   # Banco de dados
│   ├── schema.sql
│   ├── seed.sql
│   └── migrations/
├── tests/                      # Testes
│   ├── unit/
│   │   ├── test_validators.py
│   │   ├── test_usuario.py
│   │   └── test_pedido.py
│   ├── integration/
│   │   ├── test_api.py
│   │   └── test_database.py
│   └── functional/
│       └── test_selenium.py
├── requirements.txt            # Dependências Python
├── package.json               # Dependências Node.js
├── .gitignore
└── README.md
```

