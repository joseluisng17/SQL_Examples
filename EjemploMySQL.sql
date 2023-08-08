-- CREACIÓN DE BASE DE DATOS Y TABLAS

-- Crear base de datos
create database nombreDataBase;

-- mostrar base de datos existentes
show databases;

-- selecionar base de datos que se va a usar
use nombreDataBase;

-- Crear tabla dentro de la base de datos
CREATE TABLE nombreTabla (
    id int,
    tipo carchar(255),
    estado varcjar(255), 
    PRIMARY KEY (id) -- indicar cual va a ser la llave primaria de esta tabla, en este caso es la columna id.
)





--INSERT, ALRTER TABLE Y SHOW

-- insertar datos dentro de la tabla 
INSERT INTO nombreTabla (tipo, estado) values ('chanchito', 'feliz');

-- modificar una tabla que ya ha sido creada
ALTER TABLE animales MODIFY COLUMN id int auto_increment; -- decimos que modifique la columna id a que sea auto incrementable

-- FORMA APROPIADA DE COMO CREAR UNA TABLA
CREATE TABLE  animales (
    id int NOT NULL AUTO_INCREMENT, -- le decimos que el id se va auto incrementar y que no puede ser nulo.
    tipo carchar(255) DEFAULT NULL, -- le decimo que esta columna puede ser nula, aunque no es necesario escribirlo, amenos que queramos que sea muy especifico.
    estado varcjar(255) DEFAULT NULL, 
    PRIMARY KEY (id) 
)

-- eliminar tabla
DROP TABLE NombreTabla;




-- SELECT, UPDATE Y DELETE

-- Lista elementos dentro de una tabla
SELECT * FROM nombreTabla;

-- seleccionar solamente un registro 
SELECT * FROM nombreTabla WHERE id = 1;

-- seleccionar registros por otro tipo de valor, puede obtener un registro o más de uno.
SELECT * FROM nombreTabla WHERE estado = 'feliz';

-- listar un registro con más de una condificional
SELECT * FROM nombreTabla WHERE id = 1 AND estado = 'feliz'; -- se tiene que cumpliar ambas condiciones para que te traiga el registro.

SELECT * FROM nombreTabla WHERE estado = 'feliz' OR tipo = 'chanchito'; -- con que se cumpla una condifición te trae el registro o registros que cumplan la condifición.


-- Actualizar un registro
UPDATE nombreTabla set estado = 'feliz' where id = 3;


--Eliminar un registro
DELETE from nombreTabla where id = 3;


DELETE from nombreTabla where estado = 'feliz';
UPDATE nombreTabla set estado = 'triste' where tipo = 'dragon';
-- estas ultimas dos consultas arrojan error 1175. El cual indica que el tipo de delete y update
-- tiene que hacerse mediante la columna id y no mediante otra columna, se puede deshabilitar esa opción.





-- CONDICIONES EN PROFUNDIDAD

CREATE TABLE user(
    id int not null auto_increment,
    name varchar(50) not null,
    edad int not null,
    email varchar(100) not null,
    primary key (id)
);

INSERT INTO user (name, edad, email) values ('Jose', 25, 'jose@gmail.com');
INSERT INTO user (name, edad, email) values ('Layla', 15, 'layla@gmail.com');
INSERT INTO user (name, edad, email) values ('Nicolas', 36, 'nico@gmail.com');
INSERT INTO user (name, edad, email) values ('Chanchito', 7, 'chachito@gmail.com');

SELECT * from user;

-- limitar la cantidad de recursos que se va a retornar
select * from user limit 1; -- en pocas palabras nos traera el primer registro que se encuentra.
                            
-- condificional que nos traera los usuario que tengan una edad mayor a 15.
select * from user where edad > 15; 

select * from user where edad >= 15; -- usuario que la edad sea mayor o igual a 15

-- traer un un registro donde la dedd sea mayor a 20 y el email se igual al indicado.
select * from user where edad > 20 and email = 'nico@gmail.com'; -- ambas condiciones se tienen que cumpliar para que traiga el registro

-- traer un registro donde la edad sea mayor a 20 o el email sea igual al indicado
select * from user where edad > 20 or email = 'layla@gmail.com'; -- solo una condición se debe cumpliar para que traiga un registro


-- negación
select * from user where email != 'layla@gmail.com'; -- traera todo los registros siempre y cuando sean diferentes a layla@gmail.com

-- buscar los registro cuya edad se encuentre entre 15 y 30
select * from user where edad between 15 and 30;

-- buscar dentro del campo email la cadena que dice gmail busca desde el inicio o en el final de todo el campo.
select * from user where email like '%gmail%';

-- busca la palabra gmail al final, es decir la ultima palabra del campo o de la frase debe terminar en gmail para que traiga el registro.
select * from user where email like '%gmail';

-- buscar la palabra layla al inicio, es decir que al inicio de la frase o del campo debe tener la palabra gmail
select * from user where email like 'layla%';


-- traer los resultado y ordenar por edad de forma ascendente, es decir de menor edad a mayor edad.
select * from user order by edad asc;

-- ordenar por forma descendente, es decir de mayor a menor edad.
select * from user order by edad desc;

-- registro de mayor edad, en este caso max es una función por eso los parentesis.
select max(edad) as mayor from user;

select min(edad) as mayor from user;

-- seleccionar solo ciertas columnas.
select id, name from user; -- en este caso solo consultamos la columna id y name de la tabla user.

-- cambiar el nombre de la columna que se esta mostrando, es decir ponerle un alias a la columna.
select id, name as nombre from user; -- la columna name va a parecer ahora como nombre.
select id, name as chanchito from user; -- en este caso a la columna name le ponemos el alias chanchito.





-- UNION DE TABLAS, JOIN

create table products (
    id int not null auto_increment,
    name varchar(50) not null,
    created_by int not null,
    marca varchar(50) not null,
    primary key(id),
    foreign key(created_by) references user(id)
);

-- renombrar una tabla 
rename table products to product;

insert into product (name, created_by, marca) 
values 
    ('ipad', '1', 'apple'),
    ('iphone', '1', 'apple'),
    ('watch', '2', 'apple'),
    ('macbook', '1', 'apple'),
    ('imac', '3', 'apple'),
    ('ipad mini', '2', 'apple');

select * from product;


-- LEFT JOIN
-- Tabla user es left y tabla user es tabla right, en este caso vamos a indicar que nos traiga la tabla usuarios
-- y si es que hay productos relacionados a la consulta usuarios esos productos unirlos a la tabla de la izquierda
-- que es la tabla user, si es que no no trae los datos produc a la tabla user.

-- (la letra u es un alias que le estamos asignando a la tabla user, esto pera no estar escribiendo user si no solo la letra u
-- es decir, en lugar de escribir user.id solo escribiriamos u.id)

-- en ON especificamos que la columna u.id de la tabla user sea igual 
-- a p.created_by de la tabla product nota:(). 
select u.id, u.email, p.name from user u left join product p on u.id = p.created_by; 

-- RIGH JOIN
-- la tabla user es left y la tabla user es la tabla right, en este caso el que va a traer todo los datos va a ser la tabla
-- de la derecha que en este caso es la tabla de productos y en el caso que encuentre datos relacionados en la tabla de usuarios
-- los va a traer y unir a la tabla productos.

select u.id, u.email, p.name from user u right join product p on u.id = p.created_by; 


-- INNET JOINT
-- nos va a traer ambas tablas, pero siempre y cuando esten asociadas, nos va a traer la intersección de las dos tablas.
select u.id, u.email, p.name from user u inner join product p on u.id = p.created_by; 






-- GROUP BY. HAVING, DROPTABLE
-- agrupa los registros

-- agrupamos los registros por la marca y nos va a traer cuantos productos hay de esa marca gracias al count
select count(id), marca from product group by marca; 

-- vamos a hacer referencia al id del producto por eso lo ingresamos en el count, para que nos cuente y muestre cuantos productos hay y el nombre de quien creo ese producto o esos productos.
select count(p.id), u.name from product p left join user u on u.id = p.created_by group by p.created_by;

-- esta consulta nos traer los usuarios que hayan creado 2 o más productos.
select count(p.id), u.name from product p left join user u 
on u.id = p.created_by group by p.created_by
having count(p.id) >= 2;


-- Eliminar una tabla
drop table product;
drop table user;



















