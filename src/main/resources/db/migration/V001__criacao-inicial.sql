CREATE SEQUENCE product_id;

create table product(
id bigint not null DEFAULT nextval('product_id'),
name varchar(100) not null,
primary key (id)
);