/* Banco de dados */
create database if not exists db_tripctrl;
use db_tripctrl;

/* Tabela Países -- FIXA*/
create table if not exists paises(
pa_id int auto_increment primary key,
pa_sigla varchar(4) unique,
pa_nome varchar(100) unique
);

/* Tabela Estados -- FIXA*/
create table if not exists estados(
es_id int auto_increment primary key,
pa_id int, /* FK */
es_sigla varchar(4),
es_nome varchar(100),

foreign key (pa_id) references paises(pa_id) on delete cascade,
unique key estado (pa_id, es_sigla, es_nome) /* pais, estatdo sigla e estado nome não pode repetir */
);

/* Tabela Cidades -- FIXA*/
create table if not exists cidades(
ci_id int auto_increment primary key,
es_id int, /* FK */
ci_nome varchar(200),

foreign key (es_id) references estados(es_id) on delete cascade,
unique key cidade (es_id, ci_nome) /* estado, cidade não pode repetir */
);

/* Tabela Usuários -- ABERTA*/
create table if not exists usuarios(
us_id int auto_increment primary key,
us_cod varchar(9) unique, /* Criar uma função para gerar um código unico para o usuario */
us_nome varchar(50), /* Criar uma função para validar nome. Pelo menos 5 caracter */
us_dtnasc date, /* Criar uma função para validar a data de nascimento. Somente usuários maiores de 13 anos */
us_email varchar(50) unique, /* Criar uma função para validar o e-mail */
us_telefone numeric(11),
us_senha varchar(10), /* Criar uma função para validar a senha com minimo de 7 caracter e máximo de 10, uma letra maiúscula, uma letra minúscula, um número. Sem caracteres especiais */
ci_id int, /* FK */

foreign key (ci_id) references cidades(ci_id) on delete cascade
);

/* Tabela Segurança -- FIXA*/
create table if not exists seguranca(
se_id int auto_increment primary key,
us_id int, /* FK */ /* Criar função para pegar o id do usuário logado */
se_hrsolicitacao timestamp,
se_codseguranca varchar(7), /* Criar uma função para gerar um código quando solicitado para validação do usuario */

foreign key (us_id) references usuarios(us_id) on delete cascade
);

/* Tabela Categoria -- FIXA*/
create table if not exists categoria(
ca_id int auto_increment primary key,
ca_nome varchar(20) unique,
ca_debito boolean,
ca_credito boolean
);

/* Tabela SubCategoria) -- FIXA*/
create table if not exists subcategoria(
sc_id int auto_increment primary key,
ca_id int, /* FK */
sc_nome varchar(20) unique,

foreign key(ca_id) references categoria(ca_id) on delete cascade
);

/* Tabela Transporte -- FIXA*/
create table if not exists transporte(
tr_id int auto_increment primary key,
tr_nome varchar(50) unique
);

/* Tabela Hospedagem -- FIXA*/
create table if not exists hospedagem(
ho_id int auto_increment primary key,
ho_nome varchar(50) unique
);

/* Tabela Viagens -- ABERTA*/
create table if not exists dadosviagem(
dv_id int auto_increment primary key,
us_id int, /* FK */ /* Criar função para pegar o id do usuário logado */
dv_dtinicio date, /* Criar uma função para validar data. Não pode ser menor que 'hoje' */
dv_dtfim date, 
ci_id int, /* FK */
tr_id int, /* FK */
ho_id int, /* FK */
dv_hotel varchar(50),

foreign key (us_id) references usuarios(us_id) on delete cascade,
foreign key (ci_id) references cidades(ci_id) on delete cascade,
foreign key (tr_id) references transporte(tr_id) on delete cascade,
foreign key (ho_id) references hospedagem(ho_id) on delete cascade,
unique inicio(us_id, dv_dtinicio)
);

/* Tabela Crédito -- ABERTA*/
create table if not exists credito(
cr_id int auto_increment primary key,
us_id int, /* FK */ /* Criar função para pegar o id do usuário logado */
dv_id int, /* FK */
ca_id int, /* FK */
sc_id int, /* FK */
cr_descricao varchar(5000),
cr_valor decimal(6,2), /*Criar uma função para validar, não pode ser menor que zero */

foreign key (us_id) references usuarios(us_id) on delete cascade,
foreign key (sc_id) references subcategoria(sc_id) on delete cascade,
foreign key (dv_id) references dadosviagem(dv_id) on delete cascade,
foreign key(ca_id) references categoria(ca_id) on delete cascade
);

/* Tabela Débito -- ABERTA */
create table if not exists debito(
de_id int auto_increment primary key,
us_id int, /* FK */ /* Criar função para pegar o id do usuário logado */
dv_id int, /* FK */
ca_id int, /* FK */
sc_id int, /* FK */
de_descricao varchar(5000),
de_valor decimal(6,2), /*Criar uma função para validar, não pode ser menor que zero */

foreign key (us_id) references usuarios(us_id) on delete cascade,
foreign key (sc_id) references subcategoria(sc_id) on delete cascade,
foreign key (dv_id) references dadosviagem(dv_id) on delete cascade,
foreign key(ca_id) references categoria(ca_id) on delete cascade
);

/* Tabela Totais -- FIXA */
create table if not exists total(
us_id int, /* FK */ /* Criar função para pegar o id do usuário logado */
dv_id int, /* FK */
to_credito decimal(6,2), /*Criar função para buscar o total na tabela créditos */
to_debito decimal(6,2), /*Criar função para buscar o total na tabela débitos */
to_total decimal(6,2), /* Criar função para calcular o total geral cr - db */

foreign key (us_id) references usuarios(us_id) on delete cascade,
foreign key (dv_id) references dadosviagem(dv_id) on delete cascade,
primary key to_id(us_id, dv_id)
);







