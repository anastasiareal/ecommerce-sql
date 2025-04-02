# Projeto de Banco de Dados SQL para E-commerce

## Descrição
Este projeto implementa um banco de dados relacional para um sistema de e-commerce, modelando entidades como clientes, produtos, pedidos, pagamentos, entregas, fornecedores, vendedores e estoques. O objetivo é demonstrar habilidades em SQL, incluindo criação de esquemas e consultas para análise de dados.

## Objetivo
Atender aos requisitos de:
- Diferenciar clientes Pessoa Física (PF) e Pessoa Jurídica (PJ), com exclusividade entre CPF e CNPJ.
- Suportar múltiplas formas de pagamento por cliente.
- Incluir informações de entrega com status e código de rastreio.
- Responder a perguntas como "Quantos pedidos cada cliente fez?" e "Qual a relação entre produtos e fornecedores?".

## Esquema Lógico
O banco de dados foi ajustado para incluir:
- **clients**: Clientes com `idClient`, `Fname`, `Minit`, `Lname`, `ClientType` (PF/PJ), `CPF` ou `CNPJ`, e `Address`.
- **product**: Produtos com `idProduct`, `Pname`, `classification_kids`, `category`, `avaliação`, e `size`.
- **orders**: Pedidos com `idOrder`, `idOrderClient`, `ordersStatus`, `sendValue`, `paymentCash`, `trackingCode`, e `deliveryStatus`.
- **payments**: Pagamentos com `idClient`, `idPayment`, `typePayment`, e `limitAvailable`.
- **supplier**, **seller**, **productStorage**, **productSeller**, **productOrder**, **storageLocation**, **productSupplier**: Tabelas para gerenciar fornecedores, vendedores e estoques.

### Refinamentos
- Adicionado `ClientType` (PF/PJ) com restrição para garantir exclusividade entre CPF e CNPJ.
- Mantida a tabela `payments` para múltiplos métodos de pagamento.
- Adicionados `trackingCode` e `deliveryStatus` em `orders` para rastreamento de entregas.

## Estrutura do Repositório
- **`schema.sql`**: Script de criação do banco de dados com tabelas e ajustes.
- **`queries.sql`**: Consultas SQL demonstrando operações como SELECT, WHERE, ORDER BY, HAVING e junções.
- **`README.md`**: Este arquivo com a descrição do projeto.

## Como Usar
1. Execute o script `schema.sql` em um SGBD como MySQL para criar o banco de dados.
2. Popule as tabelas com dados de teste (não incluídos).
3. Execute as consultas em `queries.sql` para analisar os dados.

## Exemplos de Consultas
- **Quantos pedidos cada cliente fez?**
  ```sql
  SELECT c.idClient, CONCAT(c.Fname, ' ', c.Lname) AS clientName, COUNT(o.idOrder) AS orderCount
  FROM clients c
  JOIN orders o ON c.idClient = o.idOrderClient
  GROUP BY c.idClient, clientName;

-- Algum vendedor também é fornecedor?

select s.idSeller, s.SocialName 
from seller s 
inner join supplier sup on s.CNPJ = sup.CNPJ;

-- Relação de produtos fornecedores e estoques

select p.idProduct, p.Pname, ps.quantity, s.SocialName 
from productSupplier ps 
inner join product p on ps.idPsProduct = p.idProduct 
inner join supplier s on ps.idPsSupplier = s.idSupplier;

-- Relação de nomes dos fornecedores e nomes dos produtos

select s.SocialName, p.Pname 
from supplier s 
inner join productSupplier ps on s.idSupplier = ps.idPsSupplier 
inner join product p on ps.idPsProduct = p.idProduct;

-- Pedidos com status e código de rastreio

select idOrder, ordersStatus, trackingCode 
from orders;

