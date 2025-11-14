# Histórias de Usuário - Loja do Cupcake

## Backlog do Produto

### ID01 - Cadastrar Usuário
**Título:** Cadastrar Usuário  
**Requerente:** Cliente Usuário  
**Ação:** Cadastrar conta para ter acesso completo às informações para compra dos produtos, efetuando login e logoff.

**Comentários:** Eu como usuário gostaria de efetuar a compra dos cupcakes, mas para acessar meu carrinho de compras é necessário o cadastro completo no aplicativo.

**Critérios de Aceitação:**
- C#1: Utilizar e-mail válido para confirmação de cadastro
- C#2: Utilizar nº de documento válido (CPF)
- C#3: Utilizar nº de telefone celular válido com DDD
- C#4: Utilizar endereço válido contendo CEP e complemento para entrega
- C#5: Utilizar senha forte para acesso à plataforma

**Regras de Negócio:**
- RN#1: E-mail não pode estar duplicado no sistema
- RN#2: CPF deve ser único no sistema
- RN#3: Senha deve conter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números

**Prioridade:** ALTA  
**Estimativa:** 8 pontos  
**Sprint:** 1

---

### ID02 - Cadastrar Produto
**Título:** Cadastrar Produto  
**Requerente:** Proprietário  
**Ação:** Cadastrar novos produtos no catálogo para disponibilizar aos clientes.

**Comentários:** Eu como proprietário gostaria de adicionar novos cupcakes ao cardápio com foto, descrição, preço e informações nutricionais.

**Critérios de Aceitação:**
- C#1: Campo nome do produto obrigatório
- C#2: Upload de imagem obrigatório
- C#3: Preço deve ser valor positivo
- C#4: Descrição detalhada do produto
- C#5: Quantidade em estoque inicial

**Regras de Negócio:**
- RN#1: Produto não pode ter nome duplicado
- RN#2: Imagem deve ter tamanho máximo de 2MB
- RN#3: Preço não pode ser zero ou negativo

**Prioridade:** ALTA  
**Estimativa:** 5 pontos  
**Sprint:** 1

---

### ID03 - Cadastrar Colaborador
**Título:** Cadastrar Colaborador  
**Requerente:** Proprietário  
**Ação:** Cadastrar colaboradores com funções específicas e controle de atividades.

**Comentários:** Eu como proprietário gostaria de cadastrar funcionários para ajudar no gerenciamento dos pedidos.

**Critérios de Aceitação:**
- C#1: Nome completo obrigatório
- C#2: Definir função (atendente, gerente, cozinheiro)
- C#3: Login e senha para acesso ao sistema
- C#4: Registrar logs de atividades

**Regras de Negócio:**
- RN#1: Apenas proprietário pode cadastrar colaboradores
- RN#2: Colaborador tem acesso limitado conforme função
- RN#3: Todas as ações são registradas em log

**Prioridade:** MÉDIA  
**Estimativa:** 5 pontos  
**Sprint:** 2

---

### ID04 - Gerenciar Carrinho
**Título:** Gerenciar Carrinho de Compras  
**Requerente:** Cliente Usuário  
**Ação:** Adicionar, remover e visualizar produtos no carrinho antes de finalizar a compra.

**Comentários:** Eu como cliente gostaria de adicionar vários cupcakes ao carrinho e revisar antes de comprar.

**Critérios de Aceitação:**
- C#1: Adicionar produto ao carrinho
- C#2: Alterar quantidade de produtos
- C#3: Remover produtos do carrinho
- C#4: Visualizar total do pedido
- C#5: Carrinho persistente durante a sessão

**Regras de Negócio:**
- RN#1: Carrinho é associado ao usuário logado
- RN#2: Preço total atualiza automaticamente
- RN#3: Estoque é verificado antes da finalização

**Prioridade:** ALTA  
**Estimativa:** 8 pontos  
**Sprint:** 1

---

### ID05 - Esteira de Pedidos
**Título:** Controlar Esteira de Pedidos  
**Requerente:** Proprietário / Colaborador  
**Ação:** Visualizar e atualizar status dos pedidos (pendente, em preparo, a caminho, entregue).

**Comentários:** Eu como colaborador gostaria de atualizar o status dos pedidos conforme avançam na produção.

**Critérios de Aceitação:**
- C#1: Visualizar pedidos pendentes
- C#2: Atualizar status do pedido
- C#3: Notificar cliente sobre mudança de status
- C#4: Registrar horário de cada mudança

**Regras de Negócio:**
- RN#1: Status segue ordem lógica (não pode voltar)
- RN#2: Cliente recebe notificação por e-mail
- RN#3: Apenas colaboradores podem alterar status

**Prioridade:** ALTA  
**Estimativa:** 13 pontos  
**Sprint:** 2

---

### ID06 - Gerar Relatórios
**Título:** Gerar Relatórios de Vendas  
**Requerente:** Proprietário  
**Ação:** Visualizar relatórios de vendas por período (dia, semana, mês, ano).

**Comentários:** Eu como proprietário gostaria de ver quantos cupcakes foram vendidos e o faturamento total.

**Critérios de Aceitação:**
- C#1: Filtrar por período (data inicial e final)
- C#2: Mostrar total de vendas em reais
- C#3: Mostrar produtos mais vendidos
- C#4: Exportar relatório em PDF
- C#5: Gráficos visuais de vendas

**Regras de Negócio:**
- RN#1: Apenas proprietário tem acesso aos relatórios
- RN#2: Dados são atualizados em tempo real
- RN#3: Histórico mantido por tempo indefinido

**Prioridade:** MÉDIA  
**Estimativa:** 8 pontos  
**Sprint:** 3

---

### ID07 - Aplicar Cupons
**Título:** Aplicar Cupons de Desconto  
**Requerente:** Cliente Usuário  
**Ação:** Inserir código de cupom para obter desconto no pedido.

**Comentários:** Eu como cliente gostaria de usar cupons promocionais para obter descontos.

**Critérios de Aceitação:**
- C#1: Campo para inserir código do cupom
- C#2: Validar cupom antes de aplicar
- C#3: Mostrar valor do desconto
- C#4: Recalcular total do pedido
- C#5: Cupom pode ter data de validade

**Regras de Negócio:**
- RN#1: Um cupom por pedido
- RN#2: Cupom expira após data limite
- RN#3: Proprietário cria e gerencia cupons
- RN#4: Cupom só pode ser usado uma vez por cliente

**Prioridade:** MÉDIA  
**Estimativa:** 5 pontos  
**Sprint:** 3

---

### ID08 - Montar Cupcake Personalizado
**Título:** Montar Cupcake Personalizado  
**Requerente:** Cliente Usuário  
**Ação:** Escolher massa, sabor, cobertura e adicionais para criar cupcake customizado.

**Comentários:** Eu como cliente gostaria de criar meu próprio cupcake escolhendo cada componente.

**Critérios de Aceitação:**
- C#1: Selecionar tipo de massa (chocolate, baunilha, red velvet)
- C#2: Selecionar sabor do recheio
- C#3: Selecionar cobertura
- C#4: Adicionar extras (granulado, frutas, etc.)
- C#5: Visualizar prévia do cupcake
- C#6: Preço calculado automaticamente

**Regras de Negócio:**
- RN#1: Cada componente tem preço individual
- RN#2: Preço final é soma de todos componentes
- RN#3: Componentes disponíveis conforme estoque

**Prioridade:** ALTA  
**Estimativa:** 13 pontos  
**Sprint:** 2

---

### ID09 - Cancelar Pedido
**Título:** Cancelar Pedido  
**Requerente:** Cliente Usuário  
**Ação:** Cancelar pedido dentro de um limite de tempo após criação.

**Comentários:** Eu como cliente gostaria de poder cancelar meu pedido caso mude de ideia.

**Critérios de Aceitação:**
- C#1: Botão de cancelamento visível
- C#2: Cancelamento permitido apenas em status "Pendente"
- C#3: Confirmação antes de cancelar
- C#4: Notificação de cancelamento
- C#5: Estorno automático se pagamento realizado

**Regras de Negócio:**
- RN#1: Cancelamento permitido até 10 minutos após criação
- RN#2: Pedidos "Em preparo" não podem ser cancelados
- RN#3: Cliente recebe confirmação por e-mail

**Prioridade:** MÉDIA  
**Estimativa:** 5 pontos  
**Sprint:** 3

---

### ID10 - Login e Autenticação
**Título:** Fazer Login no Sistema  
**Requerente:** Cliente / Proprietário / Colaborador  
**Ação:** Autenticar usuário no sistema para acesso às funcionalidades.

**Comentários:** Eu como usuário gostaria de fazer login com e-mail e senha.

**Critérios de Aceitação:**
- C#1: Campo e-mail obrigatório
- C#2: Campo senha obrigatório
- C#3: Validar credenciais
- C#4: Redirecionar conforme perfil
- C#5: Opção "Lembrar-me"
- C#6: Link "Esqueci minha senha"

**Regras de Negócio:**
- RN#1: Após 3 tentativas erradas, bloquear por 15 minutos
- RN#2: Senha não é exibida durante digitação
- RN#3: Token de sessão expira após 24 horas

**Prioridade:** ALTA  
**Estimativa:** 5 pontos  
**Sprint:** 1

---

### ID11 - Visualizar Catálogo
**Título:** Visualizar Catálogo de Produtos  
**Requerente:** Cliente Usuário  
**Ação:** Navegar pelo catálogo de cupcakes disponíveis.

**Comentários:** Eu como cliente gostaria de ver todos os cupcakes disponíveis com fotos e preços.

**Critérios de Aceitação:**
- C#1: Listar todos os produtos ativos
- C#2: Mostrar imagem, nome e preço
- C#3: Filtrar por categoria
- C#4: Buscar por nome
- C#5: Ordenar por preço ou popularidade

**Regras de Negócio:**
- RN#1: Apenas produtos com estoque são exibidos
- RN#2: Produtos desativados não aparecem
- RN#3: Imagens otimizadas para carregamento rápido

**Prioridade:** ALTA  
**Estimativa:** 8 pontos  
**Sprint:** 1

---

### ID12 - Gerenciar Estoque
**Título:** Gerenciar Estoque de Produtos  
**Requerente:** Proprietário  
**Ação:** Atualizar quantidade disponível de cada produto.

**Comentários:** Eu como proprietário gostaria de controlar o estoque para evitar vendas sem disponibilidade.

**Critérios de Aceitação:**
- C#1: Visualizar estoque atual
- C#2: Adicionar entrada de estoque
- C#3: Registrar saída (venda)
- C#4: Alertas de estoque baixo
- C#5: Histórico de movimentações

**Regras de Negócio:**
- RN#1: Estoque não pode ser negativo
- RN#2: Alertar quando estoque < 10 unidades
- RN#3: Venda automática reduz estoque

**Prioridade:** ALTA  
**Estimativa:** 8 pontos  
**Sprint:** 2

---

### ID13 - Acompanhar Pedido
**Título:** Acompanhar Status do Pedido  
**Requerente:** Cliente Usuário  
**Ação:** Visualizar status atual e histórico do pedido.

**Comentários:** Eu como cliente gostaria de saber em que etapa está meu pedido.

**Critérios de Aceitação:**
- C#1: Mostrar status atual do pedido
- C#2: Histórico de mudanças de status
- C#3: Estimativa de tempo de entrega
- C#4: Notificações em tempo real

**Regras de Negócio:**
- RN#1: Cliente vê apenas seus próprios pedidos
- RN#2: Status atualizado em tempo real
- RN#3: Notificação por e-mail a cada mudança

**Prioridade:** ALTA  
**Estimativa:** 5 pontos  
**Sprint:** 2

---

### ID14 - Realizar Pagamento
**Título:** Processar Pagamento do Pedido  
**Requerente:** Cliente Usuário  
**Ação:** Escolher método de pagamento e finalizar compra.

**Comentários:** Eu como cliente gostaria de pagar com cartão, PIX ou dinheiro na entrega.

**Critérios de Aceitação:**
- C#1: Selecionar método (débito, crédito, PIX, dinheiro)
- C#2: Validar dados de pagamento
- C#3: Confirmar transação
- C#4: Gerar comprovante
- C#5: Atualizar status do pedido

**Regras de Negócio:**
- RN#1: PIX gera QR Code
- RN#2: Cartão passa por gateway de pagamento
- RN#3: Dinheiro confirmado na entrega

**Prioridade:** ALTA  
**Estimativa:** 13 pontos  
**Sprint:** 3

---

### ID15 - Enviar Sugestões
**Título:** Enviar Sugestões ao Proprietário  
**Requerente:** Cliente Usuário  
**Ação:** Enviar feedback, sugestões ou reclamações.

**Comentários:** Eu como cliente gostaria de sugerir novos sabores ou melhorias.

**Critérios de Aceitação:**
- C#1: Campo de texto para mensagem
- C#2: Anexar imagem (opcional)
- C#3: Enviar para painel do proprietário
- C#4: Confirmação de envio

**Regras de Negócio:**
- RN#1: Sugestão vinculada ao usuário
- RN#2: Proprietário pode responder
- RN#3: Histórico de sugestões mantido

**Prioridade:** BAIXA  
**Estimativa:** 3 pontos  
**Sprint:** 4

---

## Resumo do Backlog

| ID | Título | Prioridade | Estimativa | Sprint |
|----|--------|------------|------------|--------|
| ID01 | Cadastrar Usuário | ALTA | 8 | 1 |
| ID02 | Cadastrar Produto | ALTA | 5 | 1 |
| ID03 | Cadastrar Colaborador | MÉDIA | 5 | 2 |
| ID04 | Gerenciar Carrinho | ALTA | 8 | 1 |
| ID05 | Esteira de Pedidos | ALTA | 13 | 2 |
| ID06 | Gerar Relatórios | MÉDIA | 8 | 3 |
| ID07 | Aplicar Cupons | MÉDIA | 5 | 3 |
| ID08 | Montar Cupcake Personalizado | ALTA | 13 | 2 |
| ID09 | Cancelar Pedido | MÉDIA | 5 | 3 |
| ID10 | Login e Autenticação | ALTA | 5 | 1 |
| ID11 | Visualizar Catálogo | ALTA | 8 | 1 |
| ID12 | Gerenciar Estoque | ALTA | 8 | 2 |
| ID13 | Acompanhar Pedido | ALTA | 5 | 2 |
| ID14 | Realizar Pagamento | ALTA | 13 | 3 |
| ID15 | Enviar Sugestões | BAIXA | 3 | 4 |

**Total de Pontos:** 112 pontos
