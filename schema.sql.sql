-- criação do banco de dados para  o cenário de e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Address varchar(30),
constraint unique_cpf_client unique (CPF)
);


-- Criar tabela produto
create table product(
idProduct int auto_increment primary key,
Pname varchar(10) not null,
classification_kids bool,
category enum('eletronico', 'vestimenta', 'brinquedo', 'alimentos','moveis') not null,
avaliação float default 0,
size varchar(10)
);

-- criar tabela pedido
create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
ordersStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
ordersDescription varbinary(255),
sendValue float default 10,
paymentCash bool default false,
constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

create table payments(
idClient int,
idPayment int auto_increment PRIMARY KEY,
typePayment enum ('Boleto', 'Cartão', 'Dois cartões'),
limitAvailable float,
constraint fk_payments_client foreign key (idClient) references clients(idClient)
);


create table productStorage(
idProdStorage int auto_increment primary key,
storageLocatio varchar(255),
quantity int default 0
);

create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique (cnpj)
);

create table seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255),
CNPJ char(15),
CPF char(9),
Location varchar(255),
contact char(11) not null,
constraint unique_cnpj_supplier unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
idPseller int,
idProduct int,
prodQuantity int default 1,
primary key (idPSeller, idProduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_producy foreign key (idProduct) references product(idProduct)
);

create table productOrder(
idPOproduct int,
idPoorder int,
poQuantity int default 1,
poStatus enum ('Disponivel', 'Sem estoque') default 'Disponivel',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);



drop database if exists ecommerce;
create database ecommerce;
use ecommerce;

-- Criar tabela cliente
create table clients(
    idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) unique,
    CNPJ char(14) unique,
    Address varchar(255),
    constraint chk_cpf_cnpj check ((CPF is not null and CNPJ is null) or (CPF is null and CNPJ is not null))
);



-- Criar tabela produto
create table product(
    idProduct int auto_increment primary key,
    Pname varchar(50) not null,
    classification_kids bool,
    category enum('eletronico', 'vestimenta', 'brinquedo', 'alimentos','moveis') not null,
    avaliacao float default 0,
    size varchar(10)
);

-- Criar tabela pedido
create table orders(
    idOrder int auto_increment primary key,
    idOrderClient int,
    ordersStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    ordersDescription varbinary(255),
    sendValue float default 10,
    paymentCash bool default false,
    trackingCode varchar(20) unique,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- Criar tabela pagamentos
create table payments(
    idPayment int auto_increment primary key,
    idClient int,
    typePayment enum ('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    constraint fk_payments_client foreign key (idClient) references clients(idClient)
);


create table productStorage(
idProdStorage int auto_increment primary key,
storageLocatio varchar(255),
quantity int default 0
);


create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique (cnpj)
);


create table seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255),
CNPJ char(15),
CPF char(9),
Location varchar(255),
contact char(11) not null,
constraint unique_cnpj_supplier unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
idPseller int,
idProduct int,
prodQuantity int default 1,
primary key (idPSeller, idProduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_producy foreign key (idProduct) references product(idProduct)
);



create table productOrder(
idPOproduct int,
idPoorder int,
poQuantity int default 1,
poStatus enum ('Disponivel', 'Sem estoque') default 'Disponivel',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);





create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);


create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
