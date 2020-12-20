-- Obtiene el campo name, email, gender de la tabla clientes
-- donde el genero es F -> Female
SELECT name, email, gender FROM clients
WHERE gender = 'F';

-- Obtiene el campo name, email, gender de la tabla clientes
-- donde el genero es M -> Male
SELECT name, email, gender FROM clients
WHERE gender = 'M';

-- Obtiene el año de un campo de fecha
SELECT YEAR(birthdate) FROM clients;

-- Obtiene el año de la fecha actual
SELECT YEAR(NOW());

-- Obtiene la diferencia entre la fecha actual y la
-- fecha de nacimiento por lo tanto se obtendrá la edad.
SELECT name, (YEAR(NOW()) - YEAR(birthdate)) FROM clients;

-- LIKE Es una funcion de cercania de terminos
SELECT * FROM clients WHERE name LIKE '%Saave%';

-- Obtiene name, funcion para obtener la edad on el alias de 'age'
-- de la tabla clientes donde tenga el genero F->Female y el nombre
-- contenga ...Lope...
SELECT name, (YEAR(NOW()) - YEAR(birthdate)) AS age, gender FROM clients
WHERE gender = 'F'
	AND name LIKE '%Lope%';
	
SELECT book_id, author_id, title FROM books WHERE author_id between 1 and 5;

-- JOIN unir dos tablas relacionadas
-- Empezaremos por el FROM
SELECT b.book_id, a.name, b.title
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE a.author_id between 1 and 5;

SELECT b.book_id, a.name, a.author_id, b.title
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE a.author_id between 1 and 5;

ALTER TABLE  transactions 
MODIFY COLUMN  `type` enum(
'sell', 'lend', 'return') 
NOT NULL AFTER client_id; 

UPDATE transactions
SET `type` = 'return'
WHERE 
	transaction_id = 5;

INSERT INTO transactions(transaction_id,book_id,client_id,`type`,`finished`) 
VALUES(1,12,34,'sell',1),
(2,54,87,'lend',0),
(3,3,14,'sell',1),
(4,1,54,'sell',1),
(5,12,81,'lend',1),
(6,12,81,'lend',1),
(7,87,29,'sell',1);

-- Muestra los clientes que hayan comprado libros que sean mujeres
-- Obtiene nombre cliente, titulo del libro, nombre del autor y titpo de transsaccion
SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
	ON t.book_id = b.book_id
JOIN clients AS c
	ON t.client_id = c.client_id
JOIN authors AS a
	ON b.author_id = a.author_id
WHERE c.gender = 'F'
	AND t.type = 'sell';
	
-- En la ultima linea usamos IN para elegir un rango de las opicones que queremos
SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
	ON t.book_id = b.book_id
JOIN clients AS c
	ON t.client_id = c.client_id
JOIN authors AS a
	ON b.author_id = a.author_id
WHERE c.gender = 'M'
	AND t.type IN ('sell', 'lend');


--ESTOS DOS JOINS HACEN EXACTAMENTE LO MISMO
-- JOIN IMPLICITO
SELECT b.title, a.name
FROM authors AS a, books AS b
WHERE a.author_id = b.author_id
LIMIT 10;

-- JOIN EXPLICITO
SELECT b.title, a.name
FROM books AS b
INNER JOIN authors AS a
	ON a.author_id = b.author_id
LIMIT 10;

-- Obtengo id del autor, nombre del autor, nacionalidad del autor, titulo del libro
-- LEFT JOIN implicito usando BETWEEN Y ORDER BY DESC
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.name DESC;

-- Obtengo id del autor, nombre del autor, nacionalidad del autor, titulo del libro
-- LEFT JOIN EXPLICITO usando BETWEEN Y ORDER BY DEFAULT
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
LEFT JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id;

-- COUNT NOS SIRVE PARA CONTAR
-- NOS OBLIGA A USAR GROUP BY
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors AS a
LEFT JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id;

--
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
LEFT JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.name = 'Sam Altman';

--
SELECT nationality, COUNT(book_id) AS c_libros
FROM books as b
JOIN authors as a
ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY c_libros DESC;

--
SELECT DISTINCT a.nationality, COUNT(b.title) as c_books
FROM authors AS a
INNER JOIN books as b
ON a.author_id = b.author_id
GROUP BY b.book_id;

--
SELECT nationality,
	COUNT(book_id) AS libros,
	AVG(price) AS prom,
	STDDEV(price) AS desviacion
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY prom DESC;

-- REPORTE FINAL que muestra las transacciones
-- con nombre del cliente y una concatenacion del autor
-- Concat perimite concatenar strings 
-- La funcion TO_DAYS() recibe como parametro o un timestamp o un datetime o incluso una fecha a secas
-- Lo que da es el numero de dias que han pasado desde el 1 de enero del año 0 de nuestra epoca hasta el dia de hoy
SELECT c.name, t.type, b.title,
	CONCAT(a.name, " ", "(", a.nationality, ")") AS author,
	TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS ago
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON b.author_id = a.author_id
  
 
-- DELETE
DELETE FROM tabla
WHERE
	[conditions]
LIMIT 1; -- Depende de lo que tengamos pensado eliminar
  
-- UPDATE
UPDATE tabla
SET
	[columna = valor, ...]
WHERE
	[consiciones]
LIMIT 1; -- Depende de lo que tengamos pensado eliminar


-- Actualizar clientes actives con UPDATE Y SET
UPDATE clients
SET
	active = 0
WHERE
	client_id = 77
limit 1;

-- Actualizar varios clientes activos al misom tiempo
-- Con el client_id o con un wildcard en el nombre
UPDATE clients
SET
	active = 0
WHERE
	client_id in (1, 6, 8, 27, 90)
	OR name LIKE '%Lopez%';
	
-- obtener client_id, name, active para validar el query de arriba
SELECT client_id, name, active
FROM clients
WHERE
	client_id in (1, 6, 8, 27, 90)
	OR name LIKE '%Lopez%';

-- Vaciar una tabla con un solo comando
SELECT * FROM transactions;
TRUNCATE transactions;