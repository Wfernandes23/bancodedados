/* Tabela Países */
create table paises(
pa_id int auto_increment primary key,
pa_sigla varchar(4) unique,
pa_nome varchar(100) unique
);

/* Tabela Estados */
create table estados(
es_id int auto_increment primary key,
pa_id int,
es_sigla varchar(4),
es_nome varchar(100),

foreign key (pa_id) references paises(pa_id) on delete cascade,
unique key estado (pa_id, es_sigla, es_nome)
);

/* Tabela Cidades */
create table cidades(
ci_id long auto_increment primary key,
es_id int,
ci_nome varchar(200),

foreign key (es_id) references estados(es_id) on delete cascade,
unique key cidade (es_id, ci_nome)
);

/* Tabela Usuários */
create table usuarios(
us_id long auto_increment primary key,
us_cod varchar(9) unique,
us_nome varchar(50),
us_cpf varchar(11) unique,
us_dtnasc date,
us_email varchar(50) unique,
us_telefone numeric(11),
us_senha varchar(10),
ci_id long,

foreign key (ci_id) references cidades(ci_id) on delete cascade
);

/* Tabela Segurança */
create table seguranca(
se_id long auto_increment primary key,
us_id long,
se_hrsolicitacao timestamp,
se_codseguranca varchar(7),

foreign key (us_id) references usuarios(us_id)
);




 