CREATE DATABASE IF NOT EXISTS ecommerce;
use ecommerce;

-- Criação da tabela Customers
CREATE TABLE IF NOT EXISTS Customers (
   customer_id INT PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100)
);

-- Criação da tabela Orders
CREATE TABLE IF NOT EXISTS Orders (
   order_id INT PRIMARY KEY,
   customer_id INT,
   order_date DATE,
   FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Criação da tabela Products
CREATE TABLE IF NOT EXISTS Products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   price DECIMAL(10, 2)
);

-- Criação da tabela Order_Items
CREATE TABLE IF NOT EXISTS Order_Items (
   order_item_id INT PRIMARY KEY,
   order_id INT,
   product_id INT,
   quantity INT,
   FOREIGN KEY (order_id) REFERENCES Orders(order_id),
   FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Inserção de dados na tabela Customers
INSERT INTO Customers (customer_id, first_name, last_name, email) VALUES
(1, 'Ana', 'Silva', 'ana.silva@example.com'),
(2, 'Bruno', 'Santos', 'bruno.santos@example.com'),
(3, 'Carlos', 'Pereira', 'carlos.pereira@example.com'),
(4, 'Daniela', 'Oliveira', 'daniela.oliveira@example.com');

-- Inserção de dados na tabela Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-07-01'),
(2, 2, '2023-07-02'),
(3, 1, '2023-07-03'),
(4, 3, '2023-07-04');

-- Inserção de dados na tabela Products
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Notebook', 2500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 100.00),
(4, 'Monitor', 600.00);

-- Inserção de dados na tabela Order_Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 2, 1),
(4, 2, 3, 1),
(5, 3, 1, 2),
(6, 4, 4, 1);

--  retorne o ID do pedido, a data do pedido, o nome completo do cliente e o email para todos os pedidos.
SELECT 
orders.order_id,
orders.order_date,
customers.first_name,
customers.last_name,
customers.email
FROM orders
inner join customers
ON customers.customer_id = orders.customer_id;

-- Escreva uma consulta SQL que retorne o nome do produto e a quantidade pedida para todos os produtos pedidos por um cliente com um customer_id específico (por exemplo, customer_id = 1). Essa consulta deve combinar as tabelas Order_Items, Orders e Products.

SELECT
products.product_name,
order_items.quantity
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
INNER JOIN orders
on order_items.order_id = orders.order_id
WHERE orders.customer_id = 1;

-- Escreva uma consulta SQL que calcule o total gasto por cada cliente. O resultado deve incluir o nome completo do cliente e o total gasto. Essa consulta deve usar JOINs para combinar as tabelas Customers, Orders, Order_Items e Products, e deve usar uma função de agregação para calcular o total.

SELECT
products.price,
customers.first_name,
customers.last_name
FROM products
inner join order_items
ON products.product_id = order_items.product_id
inner join orders
ON order_items.order_id = orders.order_id
inner join customers
ON orders.customer_id = customers.customer_id;

-- Escreva uma consulta SQL que retorne os nomes dos clientes que nunca fizeram um pedido. Para isso, use um LEFT JOIN entre as tabelas Customers e Orders e filtre os resultados para encontrar clientes sem pedidos.

SELECT
customers.first_name,
orders.order_date
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;

