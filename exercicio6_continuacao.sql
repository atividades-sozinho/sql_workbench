drop database if exists exercicio6_continuacao;
create database exercicio6_continuacao;
use exercicio6_continuacao;

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
	id_cliente int unsigned not null unique auto_increment,
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

/*dados da primeira venda*/
insert into vendedores (id_vendedor, nome, telefone, email, endereco) values (1, 'Washington', '99999999999999', 'aaaa@email.com',
'EnderecoVendedor');
insert into clientes (id_cliente, id_cidade, razao_social, nome_fantasia, cnpj, endereco, cep, telefone, email, situacao) values
(1, 1, 'S/A', 'Empresa1', '99999999999998', 'EnderecoCliente', '1111111', '00000000000001', 'bbbb@email.com', 'A'); 
insert into venda (id_venda, id_vendedor, id_cliente, data_venda, situacao) values (1, 1, 1, '2000-01-01', 'F'); 
insert into unidade_medida (id_unidade_medida, sigla, descricao) values (1, 'kg', 'Unidade de medida do item de venda');
insert into grupo_produto (id_grupo_produto, descricao) values (1, 'Primeiro produto do grupo');
insert into produtos (id_produto, id_grupo_produto, descricao, custo, saldo_estoque, situacao) values (1, 1, 'Produto inicial', '75', '25000', 'D');
insert into item_venda (id_item_venda, id_venda, id_produto, id_unidade_medida, preco_unitario, quantidade, total) values (1, 1, 1, 1, 75.0, 2, 150);

/*Joins*/
select
	venda.data_venda,
    vendedores.nome,
    clientes.razao_social,
    cidades.nome,
    estados.nome,
    paises.nome,
    produtos.descricao,
    item_venda.quantidade,
    unidade_medida.descricao,
    item_venda.preco_unitario,
    item_venda.total
from venda
inner join vendedores on vendedores.id_vendedor = venda.id_vendedor
inner join clientes on clientes.id_cliente = venda.id_cliente
inner join cidades on cidades.id_cidade = clientes.id_cidade
inner join estados on cidades.id_estado = cidades.id_estado
inner join paises on paises.id_pais = estados.id_pais
inner join item_venda on item_venda.id_venda = venda.id_venda
inner join produtos on produtos.id_produto = item_venda.id_produto
inner join unidade_medida on unidade_medida.id_unidade_medida = item_venda.id_unidade_medida
;
/*●Nome do vendedor e quantidade de vendas
●Descrição do produto, quantidade total vendida e preço médio de venda, em ordem alfabética
●Nome do país, nome do estado, nome da cidade e quantidade de vendas para cada cidade
●Razão social do cliente e valor total vendido para os casos com valor total vendido maior que 5000*/

select * from venda;
select id_vendedor, count (id_venda) from venda
group by id_vendedor.nome;

select *, item_venda.quantidade from produtos
inner join item_venda on item_venda.quantidade = produtos.id_produto;


