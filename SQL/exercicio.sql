
CREATE DATABASE controle_estoque;  -- Criando o banco de dados
USE controle_estoque;

CREATE TABLE produtos(				-- Criando uma tabela
	produto_id INT UNIQUE PRIMARY KEY,
    nome_produto VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE fornecedor(
	fornecedor_id INT UNIQUE PRIMARY KEY,
    nome_fornecedor VARCHAR (255) NOT NULL,
    cnpj  CHAR(14)
);


CREATE TABLE estoque(		
	estoque_id INT UNIQUE PRIMARY KEY,
    produto_id INT,
    fornecedor_id INT,
    quantidade INT NOT NULL,
    data_entrada DATE NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(fornecedor_id)
);


INSERT INTO fornecedor (fornecedor_id, nome_fornecedor, cnpj) VALUES    -- Inserindo os dados 
(1, 'Tech Components Ltda', '12345678000101'),
(2, 'EletroParts S.A.', '23456789000102'),
(3, 'Global Gadgets Inc', '34567890000103'),
(4, 'Digital Solutions', '45678901000104'),
(5, 'Premium Electronics', '56789012000105'),
(6, 'Future Tech', '67890123000106'),
(7, 'Innovative Devices', '78901234000107'),
(8, 'Smart World', '89012345000108'),
(9, 'Connectivity Corp', '90123456000109'),
(10, 'Quality Electronics', '01234567000110');


INSERT INTO produtos (produto_id, nome_produto, preco) VALUES
(1, 'Notebook Gamer', 4599.99),
(2, 'Smartphone Premium', 3299.00),
(3, 'Tablet 10"', 1299.50),
(4, 'Monitor 27" 4K', 1899.00),
(5, 'Teclado Mecânico', 349.90),
(6, 'Mouse sem Fio', 159.00),
(7, 'SSD 1TB NVMe', 599.99),
(8, 'Headphone Bluetooth', 429.50),
(9, 'Webcam Full HD', 279.00),
(10, 'Caixa de Som Portátil', 199.90);


INSERT INTO estoque (estoque_id, produto_id, fornecedor_id, quantidade, data_entrada) VALUES
(111, 1, 1, 15, '2023-01-10'),
(112, 2, 2, 30, '2023-01-12'),
(113, 3, 3, 25, '2023-01-15'),
(114, 4, 4, 12, '2023-01-18'),
(115, 5, 5, 50, '2023-01-20'),
(116, 6, 6, 45, '2023-01-22'),
(117, 7, 7, 35, '2023-01-25'),
(118, 8, 8, 20, '2023-01-28'),
(119, 9, 9, 18, '2023-02-01'),
(120, 10, 10, 40, '2023-02-05');


SELECT * FROM fornecedor;   -- Visualizando a tabela fornecedor 

SELECT    					-- Visualização os Produtos que as tabelas estão relacionadas
	p.nome_produto,
    p.preco,
    e.quantidade,
    e.data_entrada,
    f.nome_fornecedor
FROM produtos p 
INNER JOIN estoque e ON p.produto_id = e.produto_id
INNER JOIN fornecedor f ON e.fornecedor_id = f.fornecedor_id;


SELECT    					-- Visualização os Produtos que o preço é maior que 1800 e a quantidade em estoque seja maior que 12.
	p.nome_produto,
    p.preco,
    e.quantidade,
    e.data_entrada,
    f.nome_fornecedor
FROM produtos p 
INNER JOIN estoque e ON p.produto_id = e.produto_id
INNER JOIN fornecedor f ON e.fornecedor_id = f.fornecedor_id
WHERE p.preco > 1800.00 and e.quantidade > 12;


SELECT 								-- Total de produtos por fornecedor
	f.nome_fornecedor,
    COUNT(f.fornecedor_id) as total_produto,
    SUM(e.quantidade) as estoque_total,
    AVG(p.preco) as preco_medio    
FROM fornecedor f 
LEFT JOIN estoque e  ON f.fornecedor_id = e.fornecedor_id
LEFT JOIN produtos p ON e.produto_id = p.produto_id
GROUP BY f.nome_fornecedor
HAVING COUNT(e.produto_id) > 0;

-- Adicionar nova coluna
ALTER TABLE produtos 
ADD COLUMN descricao VARCHAR(255);

-- Modificar tipo de coluna

ALTER TABLE produtos 		
MODIFY COLUMN preco DECIMAL(12,2);

-- Renomear coluna
ALTER TABLE produtos 
RENAME COLUMN preco TO preco_venda; 

-- Adicionar chave estrangeira
ALTER TABLE estoque
ADD CONSTRAINT fk_produto
FOREIGN KEY (produto_id) REFERENCES produtos(produto_id);

-- Remover coluna
ALTER TABLE produtos
DROP COLUMN descricao;




