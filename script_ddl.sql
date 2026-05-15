CREATE DATABASE ecommerce;
USE ecommerce;

-- CLIENTE
CREATE TABLE cliente (
    id_cliente        INT AUTO_INCREMENT PRIMARY KEY,
    nome              VARCHAR(150) NOT NULL,
    tipo_cliente      CHAR(2) NOT NULL,
    cpf               CHAR(11),
    cnpj              CHAR(14),
    email             VARCHAR(150) NOT NULL UNIQUE,
    data_cadastro     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_tipo_cliente CHECK (tipo_cliente IN ('PF', 'PJ')),
    CONSTRAINT chk_cpf_cnpj CHECK (
        (tipo_cliente = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL) OR
        (tipo_cliente = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
    )
);

-- ENDEREÇO DO CLIENTE
CREATE TABLE endereco_cliente (
    id_endereco   INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente    INT NOT NULL,
    logradouro    VARCHAR(150) NOT NULL,
    numero        VARCHAR(10) NOT NULL,
    complemento   VARCHAR(50),
    bairro        VARCHAR(80) NOT NULL,
    cidade        VARCHAR(80) NOT NULL,
    estado        CHAR(2) NOT NULL,
    cep           CHAR(8) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- CATEGORIA
CREATE TABLE categoria (
    id_categoria  INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(80) NOT NULL,
    descricao     VARCHAR(255)
);

-- PRODUTO
CREATE TABLE produto (
    id_produto    INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria  INT NOT NULL,
    nome          VARCHAR(150) NOT NULL,
    descricao     VARCHAR(500),
    preco         DECIMAL(10,2) NOT NULL,
    estoque       INT NOT NULL DEFAULT 0,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT chk_estoque CHECK (estoque >= 0),
    CONSTRAINT chk_preco CHECK (preco > 0)
);

-- PEDIDO
CREATE TABLE pedido (
    id_pedido           INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente          INT NOT NULL,
    id_endereco_entrega INT NOT NULL,
    data_pedido         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status              VARCHAR(30) NOT NULL,
    valor_total         DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_endereco_entrega) REFERENCES endereco_cliente(id_endereco)
);

-- ITEM DO PEDIDO
CREATE TABLE item_pedido (
    id_item_pedido  INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido       INT NOT NULL,
    id_produto      INT NOT NULL,
    quantidade      INT NOT NULL,
    preco_unitario  DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    CONSTRAINT chk_qtd CHECK (quantidade > 0),
    CONSTRAINT chk_preco_unit CHECK (preco_unitario > 0)
);

-- FORMAS DE PAGAMENTO
CREATE TABLE forma_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao          VARCHAR(50) NOT NULL
);

-- PAGAMENTO
CREATE TABLE pagamento (
    id_pagamento        INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido           INT NOT NULL,
    id_forma_pagamento  INT NOT NULL,
    valor               DECIMAL(10,2) NOT NULL,
    data_pagamento      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status              VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    CONSTRAINT chk_valor_pag CHECK (valor > 0)
);

-- ENTREGA
CREATE TABLE entrega (
    id_entrega       INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido        INT NOT NULL,
    codigo_rastreio  VARCHAR(50),
    status           VARCHAR(30) NOT NULL,
    data_envio       DATETIME,
    data_prevista    DATETIME,
    data_entrega     DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
