drop database if exists exercicio7;
create database exercicio7;
use exercicio7;
/*DDL*/
create table if not exists planos(
	id_planos bigint unsigned not null auto_increment,
    nome varchar (100) not null,
    PRIMARY KEY (id_planos));

create table if not exists clientes(
	id_clientes bigint unsigned not null auto_increment,
    id_planos bigint unsigned,
    nome varchar (100) not null,
    cpf varchar (11) not null,
    nro_plano varchar (100),
    telefone varchar (14) not null,
    email varchar (100),
    PRIMARY KEY (id_clientes),
    FOREIGN KEY (id_planos) REFERENCES planos(id_planos)
);

create table if not exists especialidades(
	id_especialidades bigint unsigned not null auto_increment,
    nome varchar (100) not null,
    PRIMARY KEY (id_especialidades) 
);
create table if not exists medicos(
	id_medicos bigint unsigned not null auto_increment,
    id_especialidades bigint unsigned not null,
    nome varchar (100) not null,
    crm varchar (50) not null,
    cpf varchar (11) not null,
    telefone varchar (14) not null,
    email varchar (100),
    PRIMARY KEY (id_medicos),
    FOREIGN KEY (id_especialidades) REFERENCES especialidades (id_especialidades)
    );

create table if not exists consultas(
	id_consultas bigint unsigned not null auto_increment,
	id_clientes bigint unsigned not null,
    id_medicos bigint unsigned not null,
    agendamento datetime not null,
    valor decimal (10, 2),
    PRIMARY KEY (id_consultas),
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes),
    FOREIGN KEY (id_medicos) REFERENCES medicos (id_medicos)
);

/*DML*/
insert into planos(id_planos, nome)
values (1, 'Unimed'), (2, 'Amil'), (3, 'GNDI'); 

insert into especialidades (id_especialidades, nome)
values (1, 'Ortopedia'), ('2', 'Oftalmologia'), ('3', 'Cardiologia');

insert into medicos (id_medicos, id_especialidades, nome, crm, cpf, telefone, email)
values (1, 1, 'Daniel Silveira', '5367', '09525147350', '409025271', ''),
	   (2, 2, 'Maicon Oliveira', '27091', '51225117901', '25713441', ''),
       (3, 3, 'Olivia Nestor', '11251', '03275114626', '4999991725', '');
       
insert into clientes (id_clientes, id_planos, nome, cpf, nro_plano, telefone, email)
values (1, 1, 'Juliana Renate', '58302094706', null, '413545-1832', 'renatejuliana@email.com'),
       (2, 2, 'Estela Soares', '08260332701', '165746418990018', '482568-1875', 'estelasoares@email.com'),
       (3, 2, 'Nathan Schettert', '42899105809', '188876309660007', '55850-9912', 'schettert27@email.com'),
	   (4, 3, 'Ulisses Picchio', '75342099225', '244092815610005', '47925-1423', 'picchioul0@email.com');
       
insert into consultas (id_consultas, id_clientes, id_medicos, agendamento, valor)
values (1, 1, 1, '2021-09-29', '100.00'),
	   (2, 1, 2, '2021-09-30', '250.00'),
       (3, 2, 1, '2021-09-30', '100.00'),
       (4, 2, 1, '2021-09-30', '100.00'),
       (5, 2, 2, '2021-10-02', '250.00'),
       (6, 3, 3, '2021-10-02', '400.00'),
       (7, 3, 2, '2021-10-03', '250.00'),
       (8, 3, 3, '2021-10-03', '400.00');
       
select medicos.id_medicos = 2, consultas.agendamento from medicos
inner join consultas on consultas.agendamento where consultas.agendamento between
'2021-10-01' and '2021-10-31' = medicos.id_medicos;

select medicos.id_medicos = 3, consultas.id_consultas from medicos
inner join consultas on consultas.id_consultas = medicos.id_medicos; 

select clientes.id_clientes, consultas.id_consultas from clientes
inner join consultas on consultas.id_consultas = clientes.id_clientes where clientes.nro_plano is null;

select consultas.id_clientes, medicos.id_medicos from consultas
inner join medicos on medicos.id_medicos = consultas.id_clientes where id_clientes = 1;