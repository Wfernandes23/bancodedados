/* Tabela Usuários */
create table cadastroUsuarios(
us_id int auto_increment primary key,
us_nome varchar(50) not null,
us_cpf varchar(11) unique not null,
us_dtnasc date not null,
us_email varchar(50) unique not null,
us_telefone numeric(11),
us_codseg varchar(7) unique
);




 