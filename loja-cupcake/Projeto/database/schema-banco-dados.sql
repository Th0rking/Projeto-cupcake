-- ============================================
-- SCHEMA DO BANCO DE DADOS - LOJA DO CUPCAKE
-- Projeto Integrador Transdisciplinar
-- Aluno: Thiago Sales Tavares dos Santos
-- RGM: 29714460
-- ============================================

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS loja_cupcake 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE loja_cupcake;

-- ============================================
-- TABELA: usuarios
-- Descrição: Armazena dados de clientes, proprietários e colaboradores
-- ============================================
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('cliente', 'proprietario', 'colaborador') NOT NULL DEFAULT 'cliente',
    ativo BOOLEAN DEFAULT FALSE,
    token_confirmacao VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_cpf (cpf),
    INDEX idx_tipo_usuario (tipo_usuario)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: enderecos
-- Descrição: Endereços de entrega dos usuários
-- ============================================
CREATE TABLE enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    principal BOOLEAN DEFAULT FALSE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_cep (cep)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: produtos
-- Descrição: Catálogo de cupcakes e produtos
-- ============================================
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    imagem_url VARCHAR(500),
    categoria ENUM('classico', 'premium', 'vegano', 'sem_gluten', 'personalizado') NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_categoria (categoria),
    INDEX idx_ativo (ativo),
    CONSTRAINT chk_preco_positivo CHECK (preco > 0),
    CONSTRAINT chk_estoque_nao_negativo CHECK (estoque >= 0)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: componentes_personalizacao
-- Descrição: Componentes para cupcakes personalizados
-- ============================================
CREATE TABLE componentes_personalizacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('massa', 'recheio', 'cobertura', 'extra') NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_adicional DECIMAL(10, 2) DEFAULT 0.00,
    disponivel BOOLEAN DEFAULT TRUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tipo (tipo),
    INDEX idx_disponivel (disponivel)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: carrinhos
-- Descrição: Carrinhos de compras dos usuários
-- ============================================
CREATE TABLE carrinhos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: itens_carrinho
-- Descrição: Itens dentro dos carrinhos
-- ============================================
CREATE TABLE itens_carrinho (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carrinho_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    personalizacao JSON,
    data_adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (carrinho_id) REFERENCES carrinhos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE RESTRICT,
    INDEX idx_carrinho_id (carrinho_id),
    INDEX idx_produto_id (produto_id),
    CONSTRAINT chk_quantidade_positiva CHECK (quantidade > 0)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: cupons_desconto
-- Descrição: Cupons promocionais
-- ============================================
CREATE TABLE cupons_desconto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    tipo ENUM('percentual', 'valor_fixo') NOT NULL,
    valor DECIMAL(10, 2),
    percentual DECIMAL(5, 2),
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    quantidade_total INT NOT NULL,
    quantidade_usada INT DEFAULT 0,
    valor_minimo DECIMAL(10, 2) DEFAULT 0.00,
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_codigo (codigo),
    INDEX idx_ativo (ativo),
    INDEX idx_data_validade (data_inicio, data_fim),
    CONSTRAINT chk_quantidade_usada CHECK (quantidade_usada <= quantidade_total)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: pedidos
-- Descrição: Pedidos realizados pelos clientes
-- ============================================
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    status ENUM('pendente', 'confirmado', 'em_preparo', 'a_caminho', 'entregue', 'cancelado') NOT NULL DEFAULT 'pendente',
    endereco_entrega_id INT NOT NULL,
    cupom_id INT,
    valor_subtotal DECIMAL(10, 2) NOT NULL,
    valor_desconto DECIMAL(10, 2) DEFAULT 0.00,
    valor_total DECIMAL(10, 2) NOT NULL,
    observacoes TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    data_cancelamento TIMESTAMP NULL,
    motivo_cancelamento TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (endereco_entrega_id) REFERENCES enderecos(id) ON DELETE RESTRICT,
    FOREIGN KEY (cupom_id) REFERENCES cupons_desconto(id) ON DELETE SET NULL,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_status (status),
    INDEX idx_data_criacao (data_criacao),
    CONSTRAINT chk_valor_total_positivo CHECK (valor_total >= 0)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: itens_pedido
-- Descrição: Itens de cada pedido
-- ============================================
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    personalizacao JSON,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE RESTRICT,
    INDEX idx_pedido_id (pedido_id),
    INDEX idx_produto_id (produto_id)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: pagamentos
-- Descrição: Pagamentos dos pedidos
-- ============================================
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    metodo ENUM('debito', 'credito', 'pix', 'dinheiro') NOT NULL,
    status ENUM('pendente', 'processando', 'aprovado', 'recusado', 'estornado') NOT NULL DEFAULT 'pendente',
    valor DECIMAL(10, 2) NOT NULL,
    transacao_id VARCHAR(255),
    comprovante TEXT,
    qrcode_pix TEXT,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_confirmacao TIMESTAMP NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    INDEX idx_pedido_id (pedido_id),
    INDEX idx_status (status),
    INDEX idx_metodo (metodo)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: colaboradores
-- Descrição: Informações específicas dos colaboradores
-- ============================================
CREATE TABLE colaboradores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    funcao ENUM('atendente', 'gerente', 'cozinheiro', 'entregador') NOT NULL,
    data_admissao DATE NOT NULL,
    salario DECIMAL(10, 2),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_funcao (funcao),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: logs_atividades
-- Descrição: Registro de atividades dos colaboradores
-- ============================================
CREATE TABLE logs_atividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    colaborador_id INT NOT NULL,
    acao VARCHAR(255) NOT NULL,
    detalhes TEXT,
    ip_address VARCHAR(45),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (colaborador_id) REFERENCES colaboradores(id) ON DELETE CASCADE,
    INDEX idx_colaborador_id (colaborador_id),
    INDEX idx_data_hora (data_hora)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: historico_status_pedidos
-- Descrição: Histórico de mudanças de status dos pedidos
-- ============================================
CREATE TABLE historico_status_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    status_anterior ENUM('pendente', 'confirmado', 'em_preparo', 'a_caminho', 'entregue', 'cancelado'),
    status_novo ENUM('pendente', 'confirmado', 'em_preparo', 'a_caminho', 'entregue', 'cancelado') NOT NULL,
    alterado_por INT,
    observacao TEXT,
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (alterado_por) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_pedido_id (pedido_id),
    INDEX idx_data_alteracao (data_alteracao)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: sugestoes_clientes
-- Descrição: Sugestões e feedbacks dos clientes
-- ============================================
CREATE TABLE sugestoes_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    mensagem TEXT NOT NULL,
    imagem_url VARCHAR(500),
    respondida BOOLEAN DEFAULT FALSE,
    resposta TEXT,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_resposta TIMESTAMP NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_respondida (respondida)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: avaliacoes_produtos
-- Descrição: Avaliações dos produtos pelos clientes
-- ============================================
CREATE TABLE avaliacoes_produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    usuario_id INT NOT NULL,
    pedido_id INT NOT NULL,
    nota INT NOT NULL,
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    INDEX idx_produto_id (produto_id),
    INDEX idx_usuario_id (usuario_id),
    CONSTRAINT chk_nota_valida CHECK (nota BETWEEN 1 AND 5),
    UNIQUE KEY unique_avaliacao (produto_id, usuario_id, pedido_id)
) ENGINE=InnoDB;

-- ============================================
-- TABELA: movimentacao_estoque
-- Descrição: Controle de entradas e saídas de estoque
-- ============================================
CREATE TABLE movimentacao_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    tipo_movimentacao ENUM('entrada', 'saida', 'ajuste') NOT NULL,
    quantidade INT NOT NULL,
    motivo VARCHAR(255),
    usuario_id INT,
    data_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_produto_id (produto_id),
    INDEX idx_tipo_movimentacao (tipo_movimentacao),
    INDEX idx_data_movimentacao (data_movimentacao)
) ENGINE=InnoDB;

-- ============================================
-- VIEWS PARA RELATÓRIOS
-- ============================================

-- View: Vendas por período
CREATE VIEW vw_vendas_periodo AS
SELECT 
    DATE(p.data_criacao) as data_venda,
    COUNT(p.id) as total_pedidos,
    SUM(p.valor_total) as valor_total_vendas,
    AVG(p.valor_total) as ticket_medio
FROM pedidos p
WHERE p.status IN ('entregue', 'a_caminho', 'em_preparo', 'confirmado')
GROUP BY DATE(p.data_criacao);

-- View: Produtos mais vendidos
CREATE VIEW vw_produtos_mais_vendidos AS
SELECT 
    pr.id,
    pr.nome,
    pr.categoria,
    COUNT(ip.id) as quantidade_vendida,
    SUM(ip.subtotal) as valor_total_vendas
FROM produtos pr
INNER JOIN itens_pedido ip ON pr.id = ip.produto_id
INNER JOIN pedidos p ON ip.pedido_id = p.id
WHERE p.status IN ('entregue', 'a_caminho', 'em_preparo', 'confirmado')
GROUP BY pr.id, pr.nome, pr.categoria
ORDER BY quantidade_vendida DESC;

-- View: Clientes mais ativos
CREATE VIEW vw_clientes_ativos AS
SELECT 
    u.id,
    u.nome,
    u.email,
    COUNT(p.id) as total_pedidos,
    SUM(p.valor_total) as valor_total_gasto,
    MAX(p.data_criacao) as ultima_compra
FROM usuarios u
INNER JOIN pedidos p ON u.id = p.usuario_id
WHERE p.status IN ('entregue', 'a_caminho', 'em_preparo', 'confirmado')
GROUP BY u.id, u.nome, u.email
ORDER BY total_pedidos DESC;

-- ============================================
-- TRIGGERS
-- ============================================

-- Trigger: Atualizar estoque após venda
DELIMITER //
CREATE TRIGGER trg_atualizar_estoque_apos_venda
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE produtos 
    SET estoque = estoque - NEW.quantidade 
    WHERE id = NEW.produto_id;
    
    INSERT INTO movimentacao_estoque (produto_id, tipo_movimentacao, quantidade, motivo)
    VALUES (NEW.produto_id, 'saida', NEW.quantidade, CONCAT('Venda - Pedido #', NEW.pedido_id));
END//
DELIMITER ;

-- Trigger: Registrar histórico de status
DELIMITER //
CREATE TRIGGER trg_registrar_historico_status
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO historico_status_pedidos (pedido_id, status_anterior, status_novo)
        VALUES (NEW.id, OLD.status, NEW.status);
    END IF;
END//
DELIMITER ;

-- Trigger: Incrementar uso de cupom
DELIMITER //
CREATE TRIGGER trg_incrementar_uso_cupom
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.cupom_id IS NOT NULL THEN
        UPDATE cupons_desconto 
        SET quantidade_usada = quantidade_usada + 1 
        WHERE id = NEW.cupom_id;
    END IF;
END//
DELIMITER ;

-- ============================================
-- PROCEDURES ARMAZENADAS
-- ============================================

-- Procedure: Cancelar pedido
DELIMITER //
CREATE PROCEDURE sp_cancelar_pedido(
    IN p_pedido_id INT,
    IN p_motivo TEXT
)
BEGIN
    DECLARE v_pode_cancelar BOOLEAN DEFAULT FALSE;
    DECLARE v_data_criacao TIMESTAMP;
    
    -- Verifica se o pedido pode ser cancelado (até 10 minutos após criação)
    SELECT 
        TIMESTAMPDIFF(MINUTE, data_criacao, NOW()) <= 10 AND status = 'pendente',
        data_criacao
    INTO v_pode_cancelar, v_data_criacao
    FROM pedidos 
    WHERE id = p_pedido_id;
    
    IF v_pode_cancelar THEN
        -- Atualiza status do pedido
        UPDATE pedidos 
        SET status = 'cancelado',
            data_cancelamento = NOW(),
            motivo_cancelamento = p_motivo
        WHERE id = p_pedido_id;
        
        -- Devolve estoque
        UPDATE produtos p
        INNER JOIN itens_pedido ip ON p.id = ip.produto_id
        SET p.estoque = p.estoque + ip.quantidade
        WHERE ip.pedido_id = p_pedido_id;
        
        SELECT 'Pedido cancelado com sucesso' as mensagem;
    ELSE
        SELECT 'Não é possível cancelar este pedido' as mensagem;
    END IF;
END//
DELIMITER ;

-- Procedure: Relatório de vendas
DELIMITER //
CREATE PROCEDURE sp_relatorio_vendas(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT 
        DATE(p.data_criacao) as data_venda,
        COUNT(p.id) as total_pedidos,
        SUM(p.valor_total) as valor_total,
        AVG(p.valor_total) as ticket_medio,
        SUM(CASE WHEN p.status = 'cancelado' THEN 1 ELSE 0 END) as pedidos_cancelados
    FROM pedidos p
    WHERE DATE(p.data_criacao) BETWEEN p_data_inicio AND p_data_fim
    GROUP BY DATE(p.data_criacao)
    ORDER BY data_venda;
END//
DELIMITER ;

-- ============================================
-- FIM DO SCHEMA
-- ============================================
