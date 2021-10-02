use exercicio3;
drop table if exists agencias;
drop table if exists funcionarios;

create table agencias(
	id_agencias bigint unsigned unique not null primary key auto_increment,
    nome varchar (100) not null,
    endereco varchar (100) not null
);

select * from agencias;/*O asterisco é um caractere especial que busca as colunas da tabela*/

insert into agencias (id_agencias, nome, endereco) values (001, 'agencia', 'endereco');

create table funcionarios(
	id_funcionarios int unsigned unique not null primary key auto_increment,
	id_agencias bigint unsigned unique not null,
	nome varchar (100) not null,
    cpf char (11) not null,
    endereco varchar (100) not null,
    salario decimal (8,2) not null,
    foreign key (id_agencias) references id_agencias (agencias)
);

create table clientes(
	id int unsigned unique not null primary key,
    id_agencia int unsigned unique not null,
    nome varchar (100) not null,
    cpf char (11) not null,
    endereco varchar (100) not null, 
    telefone char (10) not null,
    data_adesao date not null,
    foreign key (id_agencia) references agencias (id)
);

create table conta(
	id int unsigned unique not null primary key,
    id_cliente int unsigned unique not null,
    tipo char (1) not null,
    data_abertura date not null,
    saldo decimal (11,2) not null,
    limite decimal (8,2) not null,
    foreign key (id_cliente) references clientes (id)
);

create table operacao(
	id int unsigned unique not null primary key,
    id_conta int unsigned unique not null,
    tipo char (1) not null,
    data_operacao datetime not null,
    valor decimal (11,2) not null,
    foreign key (id_agencia) references conta(id)
);