drop database if exists exercicio4;
create database exercicio4;
use exercicio4;

/*Parte do DDL*/

create table paises(
	id_pais int unsigned not null auto_increment,
    nome varchar (100),
    idioma char(3),
    PRIMARY KEY (id_pais)
);

create table estados(
	id_estado int unsigned not null auto_increment,
    id_pais int unsigned not null,
    nome varchar (100),
    PRIMARY KEY (id_estado),
    FOREIGN KEY (id_pais) REFERENCES paises (id_pais)
);

create table cidades(
	id_cidade int unsigned not null auto_increment,
    id_estado int unsigned not null,
    nome varchar (100),
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
);

create table clientes(
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

create table vendedores(
	id_vendedor int unsigned not null auto_increment,
    nome varchar (100),
    telefone char (14),
    email varchar (100),
    endereco varchar (100),
    PRIMARY KEY (id_vendedor)
);

create table venda(
	id_venda int unsigned not null auto_increment,
    id_vendedor int unsigned not null,
    id_cliente int unsigned not null,
    data_venda datetime,
    situacao char(1),
    PRIMARY KEY (id_venda),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

create table unidade_medida(
	id_unidade_medida int unsigned not null auto_increment,
    sigla char (2),
    descricao varchar (100),
    PRIMARY KEY (id_unidade_media)
);

create table grupo_produto(
	id_grupo_produto int unsigned not null auto_increment,
    descricao varchar (100),
    PRIMARY KEY (id_grupo_produto)
);

create table produtos(
	id_produto int unsigned not null auto_increment,
    id_grupo_produto int unsigned not null,
	descricao varchar (100),
    custo decimal (11, 2),
    saldo_estoque decimal (11, 2),
    situacao char (1),
    PRIMARY KEY (id_produto),
    FOREIGN KEY (id_grupo_produto) REFERENCES grupo_produto(id_grupo_produto)
);

create table item_venda(
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
    FOREIGN KEY (id_unidade_medida) REFERENCES venda(id_unidade_medida),
);