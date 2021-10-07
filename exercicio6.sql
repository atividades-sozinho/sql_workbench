drop database if exists exercicio6;
create database exercicio6;
use exercicio6;
/*DDL*/
create table if not exists paises(
	id_pais bigint unsigned not null auto_increment,
    nome varchar (100) not null,
    sigla char(3) not null,
    PRIMARY KEY (id_pais)
);

create table if not exists estados(
	id_estado bigint unsigned not null auto_increment,
    id_pais bigint unsigned not null,
    nome varchar (100) not null,
    sigla char(3) not null,
    PRIMARY KEY (id_estado),
    FOREIGN KEY (id_pais) REFERENCES paises (id_pais)
);

create table if not exists cidades(
	id_cidade bigint unsigned not null auto_increment,
    id_estado bigint unsigned not null,
    nome varchar (100) not null,
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
);

create table if not exists clientes(
	id_cliente bigint unsigned not null auto_increment,
    id_cidade bigint unsigned not null,
    nome_fantasia varchar (150),
    razao_social varchar (150) not null,
    cnpj char (18) not null,
    telefone char (11),
    email varchar (100) not null,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cidade) REFERENCES cidades (id_cidade)
);

create table if not exists usuarios(
	id_usuario bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    nome varchar (150) not null,
    email varchar (150) not null,
    cpf varchar (11) not null,
    senha varchar (100) not null,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

create table if not exists veiculos(
	id_veiculo bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    placa varchar (9) not null,
    renavan varchar (100) not null,
    chassi varchar (200) not null,
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

create table if not exists motoristas(
	id_motorista bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    nome varchar (100) not null,
    email varchar (100) not null,
	cpf varchar (11) not null,
	nro_cnh varchar (50) not null,
    nivel_habilitacao varchar (2), 
    PRIMARY KEY (id_motorista),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

create table if not exists produtos(
	id_produto bigint unsigned not null auto_increment,
    nome varchar (150) not null,
    PRIMARY KEY (id_produto)
);

create table if not exists viagens(
	id_viagem bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    id_motorista bigint unsigned not null,
    id_cidade_origem bigint unsigned not null,
    id_cidade_destino bigint unsigned not null,
    valor_carga decimal (12,2),
    PRIMARY KEY (id_viagem),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_motorista) REFERENCES motoristas(id_motorista),
    FOREIGN KEY (id_cidade_origem) REFERENCES cidades(id_cidade),
    FOREIGN KEY (id_cidade_destino) REFERENCES cidades(id_cidade)
);

create table if not exists produtos_viagens(
	id_produtos_viagens bigint unsigned not null auto_increment,
    id_produto bigint unsigned not null,
    id_viagem bigint unsigned not null,
    PRIMARY KEY (id_produtos_viagens),
    FOREIGN KEY (id_produto) references produtos(id_produto),
    FOREIGN KEY (id_viagem) references viagens(id_viagem)
);

/*DML*/

insert into paises (id_pais, nome, sigla)
values (1, 'Brasil', 'BRA');

insert into estados (id_estado, id_pais, nome, sigla)
values (1, 1, 'Parana', 'PR'), (2, 1, 'Santa Catarina', 'SC'), (3, 1, 'Rio Grande do Sul', 'RS');

insert into cidades (id_cidade, id_estado, nome)
values (1, 1, 'Londrina'), (2, 1, 'Maringá'), (3, 1, 'Curitiba'), (4, 1, 'Guarapuava'), (5, 1, 'Apucarana'), 
	   (6, 2, 'Joinville'), (7, 2, 'Chapecó'), (8, 2, 'Criciúma'), (9, 2, 'Florianópolis'), (10, 2, 'Blumenau'),
       (11, 3, 'Erechim'), (12, 3, 'Caxias do Sul'), (13, 3, 'Porto Alegre'), (14, 3, 'Pelotas'), (15, 3, 'Ijuí');
       
insert into clientes (id_cliente, id_cidade, nome_fantasia, razao_social, cnpj, telefone, email)
values (1, 1, 'Juliana e Renato Buffet', 'LTDA', '36672688000101', '413545-1832', 'atendimento@jrbuffetltda.com'),
       (2, 6, 'Marcenaria Stella', 'S/A', '18790992000163', '482568-1875', 'qualidade@marcenariastella.com'),
       (3, 12, 'Schettert Informática', 'LTDA', '92183738000150', '55850-9912', 'schettertinformatica.com');

insert into usuarios (id_usuario, id_cliente, nome, email, cpf, senha)
values (1, 1, 'Emanuelly Louise Rosa Jesus', 'louisejesus@associate.com.br', '32693131952', 'F08cHkXdsw'),
       (2, 1, 'Raimundo Erick Drumond', 'raimundrumond@associate.com', '25764690943', 'PKSdtEFMuA'),
       (3, 2, 'Luan André José da Cruz', 'luancruz1@associate.com', '42297480946', 'sOdq64fBjd'),
       (4, 2, 'Fernanda Assunção', 'ferassuncao@associate.com.br', '89752243924', '5XBclP36rk'),
       (5, 3, 'Regina Alícia Moreira', 'reginamoreira@associate.com', '37259026073', 'a7kwpzUn1m'),
       (6, 3, 'Reinaldo Dias', 'reinaldodias@associate.com', '52766566066', 'fMKBd6rIfY');
       
insert into veiculos (id_veiculo, id_cliente, placa, renavan, chassi)
values (1, 1, 'AVG-8343', '76467259534', 'WDBAB23A6DB369209'),
       (2, 1, 'ACJ-4310', '12877548238', '1HD1JRV19DB017380'),
       (3, 1, 'AOM-7042', '01562838587', '1FTHF25H1JNB79097'),
       (4, 2, 'MAW-2282', '81934622414', 'WBAAM3333XFP59732'),
       (5, 2, 'LXU-4475', '31921672551', '1M1AK06Y96N008881'),
       (6, 2, 'MKM-4946', '11790132465', '4T1SK12E1N4028452'),
	   (7, 3, 'IZL-5667', '45561264244', 'TRUTC28N611004782'),
       (8, 3, 'INN-7560', '59193714647', '1GTEK19RXVE536195'),
       (9, 3, 'IEK-4302', '83295318379', '5TEWN72N63Z275910');
       
insert into produtos(id_produto, nome)
values (1, 'Tomate Orgânico'),
	   (2, 'Madeira de Eucalipto'),
       (3, 'Computador Quântico');
       
insert into motoristas (id_motorista, id_cliente, nome, email, cpf, nro_cnh, nivel_habilitacao)
values (1, 1, 'Gael Elias da Silva', 'gaelsilva@email.com', '58302094706', '77195368423', 'E'),
	   (2, 2, 'Marcos Severino Guimarães', 'msevguimaraes@email.com', '08260332701', '18268834915', 'E'),
       (3, 3, 'Augusto Montenegro Éster', 'augmontester@email.com', '42899105809', '78101658955', 'E');

insert into viagens (id_viagem, id_cliente, id_motorista, id_cidade_origem, id_cidade_destino, valor_carga)
values (1, 1, 1, 3, 1, '25000.0'),
       (2, 1, 1, 5, 2, '15000.0'),
       (3, 2, 2, 6, 10, '11000.0'),
       (4, 3, 3, 11, 15, '17000.0'),
       (5, 3, 3, 12, 14, '8000.0');

select id_viagem, id_cidade_origem, id_cidade_destino from viagens where id_cidade_origem or id_cidade_destino = 3; 
select id_produtos_viagens, id_produto from produtos_viagens where id_produto = 2;
select id_produtos from  



