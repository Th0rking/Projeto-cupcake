# Dicionário de Dados - Loja do Cupcake
**Projeto:** Sistema de Gestão e Vendas de Cupcakes  
**Aluno:** Thiago Sales Tavares dos Santos  
**RGM:** 29714460  
**Data:** Novembro/2025

---

## 📊 TABELA: usuarios
**Descrição:** Armazena informações de todos os usuários do sistema (clientes, proprietários e colaboradores)

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único do usuário |
| nome | VARCHAR | 255 | NÃO | - | Nome completo do usuário |
| email | VARCHAR | 255 | NÃO | UNIQUE | E-mail para login (único no sistema) |
| cpf | VARCHAR | 14 | NÃO | UNIQUE | CPF formatado (XXX.XXX.XXX-XX) |
| telefone | VARCHAR | 15 | NÃO | - | Telefone com DDD (XX) XXXXX-XXXX |
| senha | VARCHAR | 255 | NÃO | - | Senha criptografada com bcrypt |
| tipo_usuario | ENUM | - | NÃO | - | Tipo: cliente, proprietario, colaborador |
| ativo | BOOLEAN | - | NÃO | - | Conta ativa (TRUE após confirmação de e-mail) |
| token_confirmacao | VARCHAR | 255 | SIM | - | Token para confirmação de e-mail |
| data_cadastro | TIMESTAMP | - | NÃO | - | Data e hora do cadastro |
| data_atualizacao | TIMESTAMP | - | NÃO | - | Data da última atualização |

**Índices:**
- idx_email (email)
- idx_cpf (cpf)
- idx_tipo_usuario (tipo_usuario)

---

## 📊 TABELA: enderecos
**Descrição:** Endereços de entrega cadastrados pelos usuários

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único do endereço |
| usuario_id | INT | - | NÃO | FK | Referência ao usuário proprietário |
| cep | VARCHAR | 9 | NÃO | - | CEP no formato XXXXX-XXX |
| logradouro | VARCHAR | 255 | NÃO | - | Nome da rua/avenida |
| numero | VARCHAR | 20 | NÃO | - | Número do imóvel |
| complemento | VARCHAR | 255 | SIM | - | Apartamento, bloco, etc. |
| bairro | VARCHAR | 100 | NÃO | - | Nome do bairro |
| cidade | VARCHAR | 100 | NÃO | - | Nome da cidade |
| estado | CHAR | 2 | NÃO | - | Sigla do estado (SP, RJ, etc.) |
| principal | BOOLEAN | - | NÃO | - | Endereço principal para entrega |
| data_cadastro | TIMESTAMP | - | NÃO | - | Data do cadastro do endereço |

**Relacionamentos:**
- FK: usuario_id 17 usuarios(id) ON DELETE CASCADE

---
## 📊 TABELA: carrinhos
**Descrição:** Carrinhos de compras ativos dos usuários

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único do carrinho |
| usuario_id | INT | - | NÃO | FK | Referência ao usuário |
| data_criacao | TIMESTAMP | - | NÃO | - | Data de criação |
| data_atualizacao | TIMESTAMP | - | NÃO | - | Última atualização |
| ativo | BOOLEAN | - | NÃO | - | Carrinho ativo |

---

## 📊 TABELA: itens_carrinho
**Descrição:** Itens individuais dentro dos carrinhos

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único do item |
| carrinho_id | INT | - | NÃO | FK | Referência ao carrinho |
| produto_id | INT | - | NÃO | FK | Referência ao produto |
| quantidade | INT | - | NÃO | - | Quantidade do produto |
| preco_unitario | DECIMAL | 10,2 | NÃO | - | Preço unitário no momento |
| personalizacao | JSON | - | SIM | - | Dados da personalização |
| data_adicao | TIMESTAMP | - | NÃO | - | Data de adição ao carrinho |

---

## 📊 TABELA: cupons_desconto
**Descrição:** Cupons promocionais para desconto

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único do cupom |
| codigo | VARCHAR | 50 | NÃO | UNIQUE | Código do cupom (ex: PRIMEIRA10) |
| tipo | ENUM | - | NÃO | - | percentual ou valor_fixo |
| valor | DECIMAL | 10,2 | SIM | - | Valor fixo de desconto |
| percentual | DECIMAL | 5,2 | SIM | - | Percentual de desconto |
| data_inicio | DATE | - | NÃO | - | Data de início da validade |
| data_fim | DATE | - | NÃO | - | Data de término da validade |
| quantidade_total | INT | - | NÃO | - | Quantidade de usos permitidos |
| quantidade_usada | INT | - | NÃO | - | Quantidade já utilizada |
| valor_minimo | DECIMAL | 10,2 | NÃO | - | Valor mínimo do pedido |
| ativo | BOOLEAN | - | NÃO | - | Cupom ativo |
| data_cadastro | TIMESTAMP | - | NÃO | - | Data de criação do cupom |

---

## 📊 TABELA: pedidos
**Descrição:** Pedidos realizados pelos clientes

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Número único do pedido |
| usuario_id | INT | - | NÃO | FK | Cliente que realizou o pedido |
| status | ENUM | - | NÃO | - | pendente, confirmado, em_preparo, a_caminho, entregue, cancelado |
| endereco_entrega_id | INT | - | NÃO | FK | Endereço de entrega |
| cupom_id | INT | - | SIM | FK | Cupom aplicado (opcional) |
| valor_subtotal | DECIMAL | 10,2 | NÃO | - | Valor antes do desconto |
| valor_desconto | DECIMAL | 10,2 | NÃO | - | Valor do desconto aplicado |
| valor_total | DECIMAL | 10,2 | NÃO | - | Valor final a pagar |
| observacoes | TEXT | - | SIM | - | Observações do cliente |
| data_criacao | TIMESTAMP | - | NÃO | - | Data do pedido |
| data_atualizacao | TIMESTAMP | - | NÃO | - | Última atualização |
| data_cancelamento | TIMESTAMP | - | SIM | - | Data do cancelamento |
| motivo_cancelamento | TEXT | - | SIM | - | Motivo do cancelamento |

---

## 📊 TABELA: itens_pedido
**Descrição:** Itens de cada pedido realizado

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| pedido_id | INT | - | NÃO | FK | Referência ao pedido |
| produto_id | INT | - | NÃO | FK | Produto comprado |
| quantidade | INT | - | NÃO | - | Quantidade comprada |
| preco_unitario | DECIMAL | 10,2 | NÃO | - | Preço no momento da compra |
| personalizacao | JSON | - | SIM | - | Personalização do produto |
| subtotal | DECIMAL | 10,2 | NÃO | - | quantidade × preco_unitario |

---

## 📊 TABELA: pagamentos
**Descrição:** Informações de pagamento dos pedidos

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| pedido_id | INT | - | NÃO | FK | Referência ao pedido |
| metodo | ENUM | - | NÃO | - | debito, credito, pix, dinheiro |
| status | ENUM | - | NÃO | - | pendente, processando, aprovado, recusado, estornado |
| valor | DECIMAL | 10,2 | NÃO | - | Valor do pagamento |
| transacao_id | VARCHAR | 255 | SIM | - | ID da transação do gateway |
| comprovante | TEXT | - | SIM | - | Comprovante de pagamento |
| qrcode_pix | TEXT | - | SIM | - | QR Code para pagamento PIX |
| data_pagamento | TIMESTAMP | - | NÃO | - | Data do pagamento |
| data_confirmacao | TIMESTAMP | - | SIM | - | Data da confirmação |

---

## 📊 TABELA: colaboradores
**Descrição:** Informações específicas dos colaboradores

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| usuario_id | INT | - | NÃO | FK | Referência ao usuário |
| funcao | ENUM | - | NÃO | - | atendente, gerente, cozinheiro, entregador |
| data_admissao | DATE | - | NÃO | - | Data de contratação |
| salario | DECIMAL | 10,2 | SIM | - | Salário do colaborador |
| ativo | BOOLEAN | - | NÃO | - | Colaborador ativo |

---

## 📊 TABELA: logs_atividades
**Descrição:** Registro de todas as atividades dos colaboradores

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| colaborador_id | INT | - | NÃO | FK | Colaborador que executou |
| acao | VARCHAR | 255 | NÃO | - | Descrição da ação |
| detalhes | TEXT | - | SIM | - | Detalhes adicionais |
| ip_address | VARCHAR | 45 | SIM | - | IP de origem |
| data_hora | TIMESTAMP | - | NÃO | - | Data e hora da ação |

---

## 📊 TABELA: historico_status_pedidos
**Descrição:** Histórico completo de mudanças de status dos pedidos

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| pedido_id | INT | - | NÃO | FK | Pedido referenciado |
| status_anterior | ENUM | - | SIM | - | Status antes da mudança |
| status_novo | ENUM | - | NÃO | - | Novo status |
| alterado_por | INT | - | SIM | FK | Usuário que alterou |
| observacao | TEXT | - | SIM | - | Observação da mudança |
| data_alteracao | TIMESTAMP | - | NÃO | - | Data da alteração |

---

## 📊 TABELA: sugestoes_clientes
**Descrição:** Sugestões e feedbacks enviados pelos clientes

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| usuario_id | INT | - | NÃO | FK | Cliente que enviou |
| mensagem | TEXT | - | NÃO | - | Texto da sugestão |
| imagem_url | VARCHAR | 500 | SIM | - | Imagem anexada (opcional) |
| respondida | BOOLEAN | - | NÃO | - | Sugestão respondida |
| resposta | TEXT | - | SIM | - | Resposta do proprietário |
| data_envio | TIMESTAMP | - | NÃO | - | Data do envio |
| data_resposta | TIMESTAMP | - | SIM | - | Data da resposta |

---

## 📊 TABELA: avaliacoes_produtos
**Descrição:** Avaliações dos produtos feitas pelos clientes

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| produto_id | INT | - | NÃO | FK | Produto avaliado |
| usuario_id | INT | - | NÃO | FK | Cliente que avaliou |
| pedido_id | INT | - | NÃO | FK | Pedido relacionado |
| nota | INT | - | NÃO | - | Nota de 1 a 5 |
| comentario | TEXT | - | SIM | - | Comentário opcional |
| data_avaliacao | TIMESTAMP | - | NÃO | - | Data da avaliação |

---

## 📊 TABELA: movimentacao_estoque
**Descrição:** Controle de entradas e saídas de estoque

| Campo | Tipo | Tamanho | Nulo | Chave | Descrição |
|-------|------|---------|------|-------|-----------|
| id | INT | - | NÃO | PK | Identificador único |
| produto_id | INT | - | NÃO | FK | Produto movimentado |
| tipo_movimentacao | ENUM | - | NÃO | - | entrada, saida, ajuste |
| quantidade | INT | - | NÃO | - | Quantidade movimentada |
| motivo | VARCHAR | 255 | SIM | - | Motivo da movimentação |
| usuario_id | INT | - | SIM | FK | Usuário responsável |
| data_movimentacao | TIMESTAMP | - | NÃO | - | Data da movimentação |

---


