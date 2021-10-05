drop database if exists exercicio4;
create database exercicio4;
use exercicio4;

/*Parte do DDL*/

create table if not exists paises(
	id_pais int unsigned not null auto_increment,
    nome varchar (100),
    idioma char(5),
    PRIMARY KEY (id_pais)
);

create table if not exists estados(
	id_estado int unsigned not null auto_increment,
    id_pais int unsigned not null,
    nome varchar (100),
    PRIMARY KEY (id_estado),
    FOREIGN KEY (id_pais) REFERENCES paises (id_pais)
);

create table if not exists cidades(
	id_cidade int unsigned not null auto_increment,
    id_estado int unsigned not null,
    nome varchar (100),
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
);

create table if not exists clientes(
	id_cliente int unsigned not null auto_increment,
    id_cidade int unsigned not null,
    razao_social varchar (100),
    nome_fantasia varchar (100),
    cnpj char (14),
    endereco varchar (100),
    cep char (8),
    telefone varchar (14),
    email varchar (100),
    situacao char (1),
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade)
);

create table if not exists vendedores(
	id_vendedor int unsigned not null auto_increment,
    nome varchar (100),
    telefone char (14),
    email varchar (100),
    endereco varchar (100),
    PRIMARY KEY (id_vendedor)
);

create table if not exists venda(
	id_venda int unsigned not null auto_increment,
    id_vendedor int unsigned not null,
    id_cliente int unsigned not null,
    data_venda datetime,
    situacao char(1),
    PRIMARY KEY (id_venda),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

create table if not exists unidade_medida(
	id_unidade_medida int unsigned not null auto_increment,
    sigla char (2),
    descricao varchar (100),
    PRIMARY KEY (id_unidade_medida)
);

create table if not exists grupo_produto(
	id_grupo_produto int unsigned not null auto_increment,
    descricao varchar (100),
    PRIMARY KEY (id_grupo_produto)
);

create table if not exists produtos(
	id_produto int unsigned not null auto_increment,
    id_grupo_produto int unsigned not null,
	descricao varchar (100),
    custo decimal (11, 2),
    saldo_estoque decimal (11, 2),
    situacao char (1),
    PRIMARY KEY (id_produto),
    FOREIGN KEY (id_grupo_produto) REFERENCES grupo_produto(id_grupo_produto)
);

create table if not exists item_venda(
	id_item_venda int unsigned not null auto_increment,
    id_venda int unsigned not null,
	id_produto int unsigned not null,
    id_unidade_medida int unsigned not null,
    preco_unitario decimal (11,2),
    quantidade decimal (11,2),
    total decimal (11,2),
    PRIMARY KEY (id_item_venda),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_unidade_medida) REFERENCES unidade_medida (id_unidade_medida)
);

/*Parte do DML*/

insert into paises (id_pais, nome, idioma)
values (1, 'Brasil', 'PT-BR');
insert into paises (id_pais, nome, idioma)
values (2, 'EUA', 'EN');

insert into estados(id_estado, id_pais, nome)
values (1, 1, 'Santa Catarina');
insert into estados(id_estado, id_pais, nome)
values (2, 1, 'Paraná');
insert into estados(id_estado, id_pais, nome)
values (3, 1, 'Rio Grande do Sul');
insert into estados(id_estado, id_pais, nome)
values (4, 1, 'São Paulo');
insert into estados(id_estado, id_pais, nome)
values (5, 2, 'California');

insert into cidades(id_cidade, id_estado, nome)
values (1, 1, 'Joaçaba');
insert into cidades(id_cidade, id_estado, nome)
values (2, 1, 'Joinville');
insert into cidades(id_cidade, id_estado, nome)
values (3, 1, 'Florianópolis');
insert into cidades(id_cidade, id_estado, nome)
values (4, 2, 'Curitiba');
insert into cidades(id_cidade, id_estado, nome)
values (5, 2, 'Londrina');
insert into cidades(id_cidade, id_estado, nome)
values (6, 3, 'Porto Alegre');
insert into cidades(id_cidade, id_estado, nome)
values (7, 4, 'São Paulo');
insert into cidades(id_cidade, id_estado, nome)
values (8, 5, 'Mountain View');

/*Inserindo dados para serem usados no join*/
insert into vendedores (id_vendedor, nome, telefone, email, endereco) values (1, 'Washington', '99999999999999', 'aaaa@email.com',
'EnderecoVendedor');
insert into clientes (id_cliente, id_cidade, razao_social, nome_fantasia, cnpj, endereco, cep, telefone, email, situacao) values
(1, 1, 'S/A', 'Empresa1', '99999999999998', 'EnderecoCliente', '1111111', '00000000000001', 'bbbb@email.com', 'A'); 
insert into venda (id_venda, id_vendedor, id_cliente, data_venda, situacao) values (1, 1, 1, '2000-01-01', 'F'); 

/*Continuação do DML*/
select id_cliente, cnpj from clientes;
select id_cliente, situacao from clientes
	where situacao='A';
select data_venda from venda
	where data_venda >= '2012-02-01';
select id_produto, custo, saldo_estoque from produtos
	where id_produto=1;
update venda set situacao = 'F'
	where id_venda = true and data_venda <= '2012-04-01'; 
update item_venda set preco_unitario = '3700'
    where id_produto = 1;
delete from clientes
	where id_cliente = true and situacao = 'I';

/*Joins*/
select venda.data_venda, vendedores.nome, clientes.razao_social, clientes.id_cidade, cidades.id_estado, estados.id_pais,
produtos.descricao, item_venda.quantidade, unidade_medida.descricao, item_venda.preco_unitario, item_venda.total
from venda, vendedores, clientes, cidades, estados, produtos, item_venda, unidade_medida
inner join item_venda on venda.data_venda = venda.id_venda
inner join venda on vendedores.nome = vendedores.id_vendedor
inner join vendedores on clientes.razao_social = clientes.id_cliente
		
/*Joins

select venda.data_venda, vendedores.nome, clientes.razao_social from venda
	left outer join vendedores
    left outer join clientes
    on vendedores.id_vendedor = venda.id_venda
    on clientes.razao_social = venda.id_venda;

select venda.data_venda, clientes.razao_social from venda
	left outer join clientes
    on clientes.razao_social = venda.id_venda;
*/