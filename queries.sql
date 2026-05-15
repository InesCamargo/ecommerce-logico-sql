-- 1. Recuperação simples
SELECT id_produto, nome, preco FROM produto;

-- 2. WHERE
SELECT * FROM pedido WHERE status = 'PAGO';

-- 3. Expressão derivada
SELECT
    id_item_pedido,
    quantidade,
    preco_unitario,
    (quantidade * preco_unitario) AS valor_item
FROM item_pedido;

-- 4. ORDER BY
SELECT nome, preco FROM produto ORDER BY preco DESC;

-- 5. HAVING
SELECT
    c.nome,
    SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente
HAVING SUM(p.valor_total) > 5000;

-- 6. JOIN complexo
SELECT
    p.id_pedido,
    c.nome AS cliente,
    pr.nome AS produto,
    ip.quantidade,
    (ip.quantidade * ip.preco_unitario) AS valor_item
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
JOIN item_pedido ip ON ip.id_pedido = p.id_pedido
JOIN produto pr ON pr.id_produto = ip.id_produto
ORDER BY p.id_pedido;
