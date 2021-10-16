drop database if exists lista_avaliativa;
create database lista_avaliativa;
use lista_avaliativa;

/*

Semestre - descricao, inicio e fim
Curso - nome, semestre fk
Disciplinas - nome, curso fk  
Turma - descricao, disciplinas fk, matriculas
Alunos - nome, endereço, e-mail, curso fk
Matriculas - turma fk, alunos fk

*/

create table if not exists semestres(
	id_semestres bigint unsigned not null auto_increment,
    descricao varchar (200) not null,
    data_inicio datetime not null,
    data_fim datetime not null,
    PRIMARY KEY (id_semestres)
);

create table if not exists curso(
	id_curso bigint unsigned not null auto_increment,
    nome varchar (75) not null,
    PRIMARY KEY (id_curso)
);

create table if not exists disciplina(
	id_disciplina bigint unsigned not null auto_increment,
    id_curso bigint unsigned not null,
	id_semestres bigint unsigned not null,
    nome varchar (75) not null,
    PRIMARY KEY (id_disciplina),
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso),
	FOREIGN KEY (id_semestres) REFERENCES semestres (id_semestres)
);

create table if not exists turma (
	id_turma bigint unsigned not null auto_increment,
    id_disciplina bigint unsigned not null,
	PRIMARY KEY (id_turma),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina (id_disciplina)
);

create table if not exists aluno (
	id_aluno bigint unsigned not null auto_increment,
    id_curso bigint unsigned not null,
	id_semestres bigint unsigned not null,
    nome varchar (100) not null,
    endereco varchar (200) not null,
    email varchar (200),
    situacao char (15),
    PRIMARY KEY (id_aluno),
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso),
	FOREIGN KEY (id_semestres) REFERENCES semestres (id_semestres)
);

create table if not exists matricula (
	id_matricula bigint unsigned not null auto_increment,
    id_aluno bigint unsigned not null,
    id_turma bigint unsigned not null,
    PRIMARY KEY (id_matricula),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma (id_turma)
);

insert into semestres (descricao, data_inicio, data_fim) values
('2021/A', '2021-02-01', '2021-06-30'),
('2021/B', '2021-07-01', '2021-12-15');

insert into curso (nome) values
('Curso de Filosofia'),
('Curso de Engenharia Civil'),
('Curso de Ciência da Computação');

insert into disciplina (id_disciplina, id_curso, id_semestres, nome) values
(1, 1, 1, 'História da Filosofia'),
(2, 1, 2, 'Ética'),
(5, 2, 1, 'Geometria Analítica'),
(6, 2, 2, 'Cálculo Diferencial'),
(7, 3, 1, 'Lógica Computacional'),
(8, 3, 2, 'Cálculo');

insert into aluno (id_semestres, id_curso, nome, endereco, email, situacao) values
(1, 1, 'Felipe Bernardes', 'Rua Abel Bressan, Bairro Monte Castelo, Tubarão/SC', 'felipebernardes@email.com', 'Matriculado'),
(1, 1, 'Bernardo Neves', 'Rua Antonio Souza, Bairro Serraria, São José/SC', 'bernardoneves@email.com', 'Matriculado'),
(1, 2, 'Benedita Porto', 'Rua Venceslau Brás, Bairro Bela Vista, Chapecó/SC', 'beneditaporto@email.com', 'Matriculado'),
(1, 2, 'Tania Costa', 'Rua Marcos Fernandes, Bairro Barra, Balneário Camboriú/SC', '', 'Matriculado'),
(1, 3, 'Ester Mota', 'Rua Paulo Florentin, Bairro Santa Bárbara, Criciúma/SC', 'estermota@email.com', 'Matriculado'),
(1, 3, 'Alberto Santos', 'Rua Américo de Oliveira, Bairro Caroba, Lages/SC', '', 'Matriculado'),
(2, 1, 'Gabriela Figueiredo', 'Rua Dorival Bachtold, Bairro Ademar Garcia, Joinville/SC', 'gabrielafigueiredo@email.com', 'Matriculado'),
(2, 1, 'Renan Nogueira', 'Rua Senhora da Conceição, Bairro Rio Grande, Palhoça/SC', 'renanogueira@email.com', 'Matriculado'),
(2, 2, 'Bruno Vieira', 'Rua João Turatti, Bairro Bom Pastor, Chapecó/SC', '', 'Matriculado'),
(2, 2, 'Joana Rocha', 'Rua Bagdá, Bairro Barragem, Rio do Sul/SC', 'joanarocha@email.com', 'Matriculado'),
(2, 3, 'Anderson Ferreira', 'Rua Clarice Lispector, Bairro Praia dos Amores, Balneário Camboriú/SC', 'andersonferreira@email.com', 'Matriculado'),
(2, 3, 'Rafaela Strauberg', 'Rua Avelino Marcante, Bairro Ulisses Guimarães, Joinville/SC', '', 'Matriculado');

insert into turma (id_turma, id_disciplina) values
(1, 1), (2, 1), (3, 2), (4, 3), (5, 4), (6, 4), (7, 5), (8, 6), (9, 7), (10, 7), (11, 7);

/*Escreva o script SQL para alterar a situação de todos os alunos que estão sem e-mail cadastrado para "situação pendente".*/

update aluno set situacao = 'Pendente'
	where email = ''; 

/*Escreva o script SQL para listar o nome de cada disciplina oferecida pela universidade e a quantidade de alunos matriculados no semestre 2012‐01.*/

select nome from disciplina
group by nome;
select max(id_aluno) from aluno
where id_semestres = 1;

/*Escreva o script SQL para listar a descrição de todos os semestres e a quantidade de alunos matriculados.*/

select descricao from semestres
group by descricao;
select max(id_aluno) from aluno; 

