-- crear una base de datos

CREATE DATABASE libreria_cf;

-- para listar las base de datos
 SHOW DATABASES;

--elminar una base de datos (pero no habra vuelta atras)
DROP DATABASE libreria_cf;

-- para usar la base de datos y todas las sentencia sql que vamos a utilizar se realizen en la base de datos seleccionada
USE libreria_cf;

--eliminar una base de datos en caso de que exista
DROP DATABASE IF EXISTS libreria_cf;

-- crear una base de datos en casi de que no exista
CREATE DATABASE IF NOT EXISTS libreria_cf;





-- CREAR TABLAS 

/*  ¿que tiepo de entidades?  autores
    nombre: autores
 */

 nombre
 genero
 fecha de nacimiento
 país de origen

 -- Generar nuestra tabla
 CREATE TABLE autores(
    --columna y el tipo de dato 
    autor_id INT,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    genero CHAR(1), -- M o F
    fecha_nacimiento DATE, -- formato año-mes-día
    pais_origen VARCHAR(40)

 );


-- AGREGAR VALORES MAS ESPECIFICOS AL CREAR UNA TABLA O AGREGAR RESTRICCIONES

-- indicar que una columna no lleve valores nulos
 CREATE TABLE autores(
   

    autor_id INT PRIMARY key AUTO_INCREMENT, -- con primary key le decimos que va ser un campo unico(no se puede repetir) y no puede ir nulo.  
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    -- entonces al poner not null todos los campos son obligatorios

    -- paraindicar que el campo sea unico y no se repida o se duplique
    correo VARCHAR(50) UNIQUE,
    fecha_creacion DATETIME DEFAULT current_timestamp -- estamos indicando el capo fecha que por default se cree la fecha en que se crea un autor.

 );

 autor_id UNSIGNED -- se prebiene la inserción de numeros negativos

 genero ENUM('m', 'f') -- con enum le decimos que solo puede almacenar una o 'm' o 'f' nota: no es senbible a mayusculas o a minusculas.


-- como agregar una llave foranea
CREATE TABLE libros (
    libro_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    autor_id INT not null, -- aquí se almacenaria el id del autor de la tabla autores
    titulo varchar(50) not null,
    descripcion varchar(250),
    paginas INTEGER UNSIGNED,
    fecha_publicacion date not null,
    fecha_creacion DATETIME DEFAULT current_timestamp, 
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id) -- le decimos que la llave foranea va a ser la columna autor_id que hace referencia a la tabla autores a su columna autor_id.
);

--Alter table sirve para modificar, agregar una columna o eliminar una columna

-- Como agregar una nueva columna a una tabla
ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL;
ALTER TABLE libros ADD stock INT UNSIGNED NOT NULL DEFAULT 10; -- con el default estamos agregando un valor por default a todos los registros.

-- modificar una tabla que ya ha sido creada
ALTER TABLE libros MODIFY COLUMN libro_id int auto_increment; -- decimos que modifique la columna id a que sea auto incrementable

-- como eliminar un columna de una tabla
ALTER TABLE libros DROP COLUMN stock;

-- eliminar una tabla
DROP TABLE NombreTabla;





 -- SENTENCIAS BASICAS

 -- para ver las tablas 
 SHOW TABLES;

 -- para ver en cual base de datos estas trabajando
 SELECT DATABASES();

 --visualisar la columnas y el tipo de dato que almacena la columna
 SHOW COLUMNS FROM autores;
    
    Ó

 DESC autores;

 -- para insertar registros a una tabla
 INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
 VALUES (1, 'test autor', 'test apellido', 'M', '2018-01-30', 'México');

-- Todos los registros de una tabla
select * from autores;

-- hacer insersiones multiples
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
 VALUES (2, 'autor2', 'apellido2', 'M', '2018-01-30', 'México'),
        (2, 'autor3', 'apellido3', 'M', '2018-01-30', 'México'),
        (2, 'autor4', 'apellido4', 'M', '2018-01-30', 'México');


-- SELECCIONAR TODAS LAS COLUMNAS DE UNA TABLA
SELECT * FROM libros;

-- Seleccionar solo algunas columas en especifico de una tabla
SELECT autor_id, titulo FROM libros;

-- seleccionar un registro de una tabla por medio de un nombre utilizando un filtro where
SELECT * FROM libros WHERE titulo = 'carrie';

-- hacer una doble condicional para hacer doble filtro de busqueda
SELECT * FROM libros WHERE titulo = 'carie' AND ventas = 0;


-- otra consulta con condicional OR cuando se usa el condicional OR con que se cumpla una condición hace la busqueda.
SELECT * FROM libros WHERE titulo = 'carie' OR autor_id = 1 OR ventas = 10;

-- obtener una fecha de un rango a otro
SELECT titulo FROM libros WHERE fecha_publicacion BETWEEN '1995-01-01' AND '2015-01-31';

-- buscar por una lista que definamos
SELECT * FROM libros WHERE titulo IN ('Ojos de fuego', 'Cujo', 'El hobbit', 'La torre oscura 7');

-- si queremos colocar un alias a las columnas
SELECT autor_id AS autor, titulo AS nombre FROM libros; -- y ahora los nombres de las columnas los podemos obtener con el nombre "autor" y "nombre"


-- ACTUALIZAR DATOS
UPDATE libros SET descripcion = 'Nueva descripción', ventas = 100;

--actualizar un registro en especifico utilizamos where
UPDATE libros SET descripcion = 'Nueva descripción', ventas = 100 WHERE titulo = 'El hobbit';


-- BORRAR UN DATO
DELETE FROM libros WHERE autor_id = 1;





-- SENTENCIAS AVANZADAS 

--hacer una buscqueda de la tabla libros donde el titulo sea igual a un subestring, en este caso subestring puede venir de una variable.
-- obtenemos como resultado todo los titulos que coincidan con el subString 

SELECT * FROM libros WHERE titulo LIKE 'harry potter%';-- si queremos que comience la busqueda con las primeras palabras de la frase
                                                        -- colo camos el % al final

SELECT * FROM libros WHERE titulo LIKE '%anillo'; -- si queremos que haga la busqueda al final de la frase, ponemos el % al inicio 


SELECT * FROM libros WHERE titulo LIKE '%la%'; -- % al principio y al final hace que busque al principio, en medio o al final.

-- Ordenar registros

-- odenamos por titulo, el ordenamiento se hace de forma ascendente comenzando por la A a la Z 
SELECT titulo FROM  libros ORDER BY titulo;

--odenamos de forma descendente
SELECT titulo FROM libros ORDER BY titulo DESC;

--consulta los 10 primeros titulos de la tabla
SELECT titulo FROM libros LIMIT 10;

-- una consulta de que registro se va a comenzar y cuando registros mostarte
SELECT titulo FROM libros LIMIT 5, 5; -- desde el registro 5 y que obtenga 5 registros







-- FUNCIONES EN SQL


-- hacer un conteo de cuantos autores hay en total
SELECT COUNT(*) FROM autores;

-- ponemos un alias para poder manejar la columna de resultado
SELECT COUNT(*) AS total FROM autores;

-- hacer una concatenación con los valores de dos columnas diferentes
SELECT CONCAT(nombre, " ", apellido) FROM autores; -- igual concatenamos un espacio " " para que no salga el nombre pegado.

-- podemos poner un alias, esto para tener el valor en una sola variable o como si fuera en una sola columna
SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores; 

-- obtener todos los autores cuyos nombres sus letras sean mayor de 7
SELECT * FROM autores WHERE LENGTH(nombre) > 7;

-- hacer que toda la columna nombre sea mayuscula y la columna apellido sea minuscula
SELECT UPPER(nombre), LOWER(nombre) FROM autores;

-- hacer una busqueda con una condicional donde busque con las primeras 12 letras sean igual a = "Harry Potter"
SELECT * FROM libros WHERE LEFT(titulo, 12) = 'Harry Potter';
R = Harry Potter y la piedra filosofal
R = Harry Potter y el pricionero de ascaban
etc.

-- ahora hacer una busqueda pero ahora con las ultimas 6 letras sean igual a = "anillo"
SELECT * FROM libros WHERE RIGHT(titulo, 6) = 'anillo';

R = La comunidad del anillo.

-- FUNCIONES CON FECHA
select now(); --nos da la fecha actual

-- sacar el segundo, el minuto, la hora, mes o el año
SELECT SECOND(@now), MINUTE(@now), HOUR(@now), MONTH(@now), YEAR(@now);

-- sacar el dia de la semana, día del mes, y dia del año
SELECT DAYOFFWEEK(@now), DAYOFMONTH(@now), DAYOFYEAR(@now);

-- selecionar las columnas de la tabla libro donde la fecha de creación sea igual a el día de hoy nota(CURDATE te da la fecha de hoy).
SELECT * FROM libros WHERE DATE(fecha_creacion) = CURDATE();

-- Agregar o restar tiempo a una fecha
SELECT @now + INTERVAL 30 DAY;

-- hacer condicionales 
SELECT IF(10 > 90, "El número si es mayor", "El número no es mayor");

-- función para agregar días a una fecha
DELIMITER //   -- con eso decimos que el doble slash delimitara la sentencia sentencia y ya no el punto y coma

CREATE FUNCTION agregar_dias(fecha DATE, dias INT)
RETURNS DATE
BEGIN
    RETURN  fecha + INTERVAL dias DAY;
END//

DELIMITER ; -- con eso volvemos a decir que el punto y coma delimita la sentencia


-- como mandar a llamar una función

DELIMITER // 

CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
    SET @paginas = (SELECT( RAND() * 100 ) * 4));
    RETURN @PAGINAS;
END//

DELIMITER ;

UPDATE libros SET paginas = obtener_paginas();






-- JOINS

-- una consulta basica para obtener todos los libros
SELECT titulo FROM libros;

-- ahora a unir los libros con sus respectivos autores, inner join une las dos tablas siempre y cuando haya una relación.
-- depues de ON especificamos que la columna autor_id de la tabla libros nota:(autor_id es la llave foranea de la tabla libros) sea igual 
-- a autor_id de la tabla autores nota:(autor_id es la llave primaria de la tabla autores). 
SELECT titulo FROM libros INNER JOIN autores ON libros.autor_id = autores.autor_id;

-- Tabla a es autores y tabla b es libros
-- cuando es left join la tabla autores es la principal y tabla libros es la secundaría, etonces, la tabla libros se una a la tabla autores
-- muestra todos los registros de tabla autores y luego une los respectivos registros de tabla libros donde tiene relación con tabla autores
SELECT * FROM autores left JOIN libros  ON libros.autor_id = autores.id; 

-- tabla libros es la principal y autores secundaría, entonces tabla autores se une a la derecha a tabla libros
--muestra la tabla libros y todos sus registros y une la tabla autores y sus respectivas relaciones de libros a autores.
SELECT * FROM autores right JOIN libros  ON libros.autor_id = autores.id; 

-- si se quiere mostrar primero la información de libros y luego la de autores solo se cambia el orden de las tablas
-- primero ponemos la tabla libros y luego autores
SELECT * FROM libros right JOIN autores  ON libros.autor_id = autores.id; 


-- hacemos una consulta donde cocatenamos el nombre del autor que se obtiene por autor_id
SELECT titulo, CONCAT(nombre, " ", apellido) AS nombre_autor 
FROM libros INNER JOIN autores ON libros.autor_id = autores.id;

-- misma consulta anterior solo que esta vez consultamos otro campo nota:(tenemos que especificar de que tabla queremos sacar la columna)
SELECT titulo, CONCAT(nombre, " ", apellido), libros.fecha_creacion AS nombre_autor 
FROM libros INNER JOIN autores ON libros.autor_id = autores.id;

-- siempre que estemos trabajando con join tenemos que espeficicar el origen del campo
SELECT libros.titulo, CONCAT(autores.nombre, " ", autores.apellido), libros.fecha_creacion AS nombre_autor 
FROM libros INNER JOIN autores ON libros.autor_id = autores.id;

-- misma consulta anterior utilizando un alias para escrituras más cortas
SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido), li.fecha_creacion AS nombre_autor 
FROM libros AS li INNER JOIN autores AS au ON li.autor_id = au.id;


-- Cuanto el campo en ambas tablas tienen el mismo nombre se puede usar USING
SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido), li.fecha_creacion AS nombre_autor 
FROM libros AS li INNER JOIN autores AS au USING(autor_id);

-- aunque es más combeniente usar ON cuando ocupas hacer mas condicionales
SELECT li.titulo, CONCAT(au.nombre, " ", au.apellido), li.fecha_creacion AS nombre_autor 
FROM libros AS li INNER JOIN autores AS au ON li.autor_id = au.autor_id AND autores.seudonimo IS NOT NULL;





-- Relación de muchos a muchos, Relación de libros a usuarios, un usuario puede tener muchos libros y muchos libros pueden tener muchos usuarios.
-- la relación de tabla es para prestamos de libros, un usuario puede tener muchos libros prestados y un libro se le puede prestar a muchos usuarios.


usuario
libros

-- Creamos tabla de usuarios que no había sido creada anteriormente.
CREATE TABLE usuarios(
    id INT PRIMARY key AUTO_INCREMENT,
    nombre varchar(25),
    apellido varchar(25),
    correo varchar (50),
    numero_libros int
);

-- Intersamos valores para crear usuarios.
INSERT INTO usuarios (nombre, apellido, correo, numero_libros)
 VALUES ('jose', 'najar', 'jose@gmail.com', 10),
        ('luis', 'gonzalez', 'luis@gmail.com', 5),
        ('bilbo', 'bagin', 'bilbo@gmail.com', 10),
        ('peter', 'parker', 'parker@gmail.com', 5);


-- Creamos la tabla intermeda o tabla pivote, cuando hay una relación de muchos a muchos se necesita crear una tabla intermedia 
-- entre las dos tablas que queremos hacer relación, en este caso sera la siguiente tabla y con el siguiente nombre.
CREATE TABLE libros_usuarios(
    libro_id INT NOT NULL, -- esta columna hara relación con la columna id de la tabla libro
    usuario_id INT NOT NULL, -- esta columna hara relación con la columna id de la tabla usuario

    FOREIGN KEY (libro_id) REFERENCES libros(id), -- hacer la relación, indicando que es llave foranea y referencia a cual id llave primaria y de que tabla
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id), -- igual mente hacemos relación inficando que va a ser llave foranea y a cual columna hace ferencia y de que tabla.
    
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP -- agregamos una columna para la creación de fecha de cuando se fue la fecha que se presto el libro
                                                      -- indicamos que se cree la fecha por default tomando la fecha del computador
                                                      -- por lo tanto no es necesario pasar valor a esta columna.
)

-- insertamos valores en la tabla intermedia o la tabla pivote, que es la tabla que mantiene la relación de muchos a muchso entre usuarios y libros
-- para poder insertar valores solo agregamos el id de libro existente y id de usuario existente 
insert into libros_usuarios (libros_id, usuarios_id) 
values (3, 1);

-- insertamos mas valores a la tabla intermedia, para esto solo agregamos el id de libro existente y id de usuario existente
insert into libros_usuarios (libros_id, usuarios_id) 
values (1, 2), (5, 3), (6, 1), (8, 4), (3, 2), (3, 3), (3, 4), (1, 1), (3, 1), (4, 1);


-- left join

usuarios = tabla a -- tabla izquierda
libros_usuarios = tabla b -- tabla derecha


-- traemos información de la tabla usuarios y unimos la tabla libros_usuarios. La tabla principal es la de la izquierda es decir tabla Usuarios 
-- y se le une libros_usuarios a la izquierda
SELECT CONCAT(nombre, " ", apellido), libros_usuarios.libro_id FROM usuarios 
LEFT JOIN libros_usuarios ON usuarios.id = libros_usuarios.usuario_id;

-- Right join 

usuarios = tabla b -- tabla izquierda
libros_usuarios = tabla a --tabla derecha

-- traemos la información de la tabla libros_usuarios y se une la tabla usuarios. La tabla principal es la derecha es decir tabla libros_usuarios 
-- y se le une la tabla usuarios a la derecha
SELECT CONCAT(nombre, " ", apellido), libros_usuarios.libro_id FROM usuarios 
RIGHT JOIN libros_usuarios ON usuarios.id = libros_usuarios.usuario_id;


-- Anteriormente solo uniamos la relación de la tabla usuarios con la tabla libros_usuarios
-- acontinuacuón vamos a unir la relación de usuarios, libros_usuarios y también la tabla libros para que nos muestre la información de
-- dichas tres tablas y sus valores siempre y cuando exista relación.


-- Inner join

-- Seleccionamos todo de la tabla libro_usuarios y la unimos con la relación que tenga con la tabla usuarios espeficicando donde el valor del id de la tabla usuario
-- sea igual al valor de usuario_id de la tabla libro_usuarios, unimos también la tabla libros donde los id's de la tabla libros sean iguales a los libros_id's de la tabla libros_usuario
-- nos va traer todo de libros_usuario y los valores de la tabla usuario y los valores de la tabla libros, siempre y cuanod exista relación.
SELECT * FROM libros_usuarios
inner JOIN usuarios ON usuarios.id = libros_usuarios.usuarios_id inner join libros on libros.id = libros_usuarios.libros_id;


-- Es la misma consulta que la anterior solo que esta vez solo nos va traer los valores especificados antes del FROM
SELECT libros_usuarios.fecha_creacion, usuarios.nombre, libros.titulo, libros.fecha_publicacion FROM libros_usuarios
inner JOIN usuarios ON usuarios.id = libros_usuarios.usuarios_id inner join libros on libros.id = libros_usuarios.libros_id;

-- Es la misma consulta que la anteriro solo que aquói agregamos también la tabla autores y su relación con la tabla libros. 
SELECT libros_usuarios.fecha_creacion as fecha_prestamo, usuarios.nombre, libros.titulo, libros.fecha_publicacion, autores.nombre as autor, autores.apellido
FROM libros_usuarios inner JOIN usuarios ON usuarios.id = libros_usuarios.usuarios_id inner join libros on libros.id = libros_usuarios.libros_id 
inner join autores on autores.id = libros.autor_id;