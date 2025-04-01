-- Inserção de dados
use ecommerce;
show tables;
insert into Clients (Fname, Minit, Lname, CPF, Address)
              values('Matheus', 'O','Pimentel', 987654321,'rua andradas 289, Centro - Santa Maria'),
                    ('Ricardo','F', 'Santos', 456789913, 'avenida ipiranga 1009, centro - Santa Maria'),
                    ('Julia','S','França',789123456, 'rua martins 861, consoladora - Santa Maria'),
                    ('Roberta','G','Assis',98745631, 'avenida getulio 19, centro - Santa MAria'),
                    ('Isabela','M', 'Cruz',654789123, 'rua hortencia 28, camobi - Santa Maria');
                    
                    
insert into product (Pname, classification_kids, category, avaliacao, size) values
                            ('Fone de ouvido',false,'eletrònico','4',null),
                            ('Barbiie elsa', true, 'brinquedo','3',null),
                            ('Body Carters',true,'vestimenta','5',null),
                            ('Microfone Vedo - youtuber',false,'Eletronico','4',null),
                            ('Sofá retrátil',false,'Móveis','3','3x57x80'),
                            ('Farinha de arroz',false,'Alimentos','2',null),
                            ('Fire Stick Amazaon',false,'Eletrònico','3',null);
                            
                            
                            
select * from clients;
select * from product;

delete from orders where idOrderClient in (1,2,3,4);
insert into orders (idOrderClient, ordersStatus, ordersDescription, sendValue, paymentCash) values
                          (1, default,'compra via aplicativo',null,1),
                          (2,default,'compra via aplicativo',50,0),
                          (3,'confirmado',null,null,1),
                          (4,default,'compra via web site',50,0);
                          
					
                    
select * from orders;


insert into productOrder (idPOproduct, idPoorder, poQuantity, poStatus) values
                          (1,5,2,null),
                          (2,5,1,null),
                          (3,6,1,null);

insert into productStorage (storageLocatio, quantity) values 
                              ('Rio Grande do Sul',1000),
                              ('Rio Grande do Sul',500),
                              ('São Paulo',100),
                              ('São Paulo',10),
                              ('Brasilia',60);
                              
							
 select * from  storagelocation;                         
insert into storageLocation (idLproduct, idLstorage, location) values
                               (1,2,'RJ'),
                               (2,6,'GO');
                               
			
insert into supplier (SocialName, CNPJ, contact) values
                      ('Almeida e Filhos', 123456789123456, '21985474'), 
                      ('Eletronicos Silva', 854519649143457, '21985484'),
                      ('Eletronicos Valma', 934567893934695, '21975474');
                               
                               
                               
insert into productsupplier (idPsSupplier, idPsProduct, quantity) values
                             (1,1,500),
                             (1,2,400),
                             (2,4,633),
                             (3,3,5),
                             (2,5,10);
                             
                             
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
                    ('Tech Eletronics', null, 123456789456321, null, 'Rio de Janeiro', 2199462870),
                    ('Butique Durgas',null, null, 123456783, 'Rio de Janeiro', 219567895),
                    ('Kids World',null, 456789123654485,null, 'São paulo', 1198657484);
                               
                               
                               
				
	insert into productSeller (idPseller, idproduct, prodQuantity) values
                                  (1,6,80),
                                  (2,7,10);
                                  
                                  
                                  
                                  
                                  
-- Queries solicitadas                                  
                                  
-- Quantos pedidos foram feitos por cada cliente?
select c.idClient, c.Fname, c.Lname, count(o.idOrder) as totalPedidos 
from clients c 
left join orders o on c.idClient = o.idOrderClient 
group by c.idClient;



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
                               
						