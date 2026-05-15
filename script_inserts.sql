-- CLIENTES
INSERT INTO cliente (nome, tipo_cliente, cpf, cnpj, email)
VALUES
('Ana Souza', 'PF', '12345678901', NULL, 'ana@example.com'),
('Loja Tech LTDA', 'PJ', NULL, '12345678000199', 'contato@lojatech.com'),
('Bruno Lima', 'PF', '98765432100', NULL, 'bruno@example.com');

-- ENDEREÇOS
INSERT INTO endereco_cliente (id_cliente, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES
(1, 'Rua das Flores', '100', NULL, 'Centro', 'Porto Alegre', 'RS', '90000000'),
(1, 'Av. Ipiranga', '2000', 'Ap 301', 'Azenha', 'Porto Alegre', 'RS', '90100000'),
(2, 'Rua das Empresas', '500', 'Sala 10', 'Centro', 'São Paulo', 'SP', '01000000'),
(3, 'Rua da Praia', '50', NULL, 'Centro', 'Florianópolis', 'SC', '88000000');

-- CATEGORIAS
INSERT INTO categoria (nome, descricao)
VALUES
('Eletrônicos', 'Dispositivos eletrônicos'),
('Livros', 'Livros físicos e digitais'),
('Acessórios', 'Acessórios diversos');

-- PRODUTOS
INSERT INTO produto (id_categoria, nome, descricao, preco, estoque)
VALUES
(1, 'Notebook Gamer', 'Notebook com placa de vídeo dedicada', 5500.00, 10),
(1, 'Smartphone X', 'Celular topo de linha', 3500.00, 20),
(2, 'Livro SQL na Prática', 'Livro sobre bancos de dados', 120.00, 50),
(3, 'Mouse Gamer', 'Mouse com alta precisão', 150.00, 100);

-- FORMAS DE PAGAMENTO
INSERT INTO forma_pagamento (descricao)
VALUES ('Cartão de Crédito'), ('Boleto'), ('Pix');

-- PEDIDOS
INSERT INTO pedido (id_cliente, id_endereco_entrega, status, valor_total)
VALUES
(1, 1, 'PAGO', 0),
(1, 2, 'ABERTO', 0),
(3, 4, 'PAGO', 0);

-- ITENS DO PEDIDO
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES
(1, 1, 1, 5500.00),
(1, 4, 2, 150.00),
(2, 3, 1, 120.00),
(3, 2, 1, 3500.00);

-- Atualizar valor total dos pedidos
UPDATE pedido p
JOIN (
    SELECT id_pedido, SUM(quantidade * preco_unitario) AS total
    FROM item_pedido
    GROUP BY id_pedido
) it ON p.id_pedido = it.id_pedido
SET p.valor_total = it.total;

-- PAGAMENTOS
INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, status)
VALUES
(1, 1, 4000.00, 'CONFIRMADO'),
(1, 3, 1800.00, 'CONFIRMADO'),
(3, 2, 3500.00, 'CONFIRMADO');

-- ENTREGAS
INSERT INTO entrega (id_pedido, codigo_rastreio, status, data_envio, data_prevista, data_entrega)
VALUES
(1, 'BR123456789BR', 'ENTREGUE', NOW() - INTERVAL 5 DAY, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY),
(3, 'BR987654321BR', 'EM_TRANSITO', NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 3 DAY, NULL);
