CREATE TABLE IF NOT EXISTS clients (
	client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	birthdate DATETIME,
	gender ENUM('M', 'F', 'ND') NOT NULL,
	active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS authors (
	author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	nationality VARCHAR(3)
);

CREATE TABLE IF NOT EXISTS books (
  book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  author INTEGER UNSIGNED,
  title VARCHAR(128) NOT NULL,
  year INTEGER UNSIGNED NOT NULL DEFAULT 1900,
  `language` VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
  cover_url VARCHAR(500),
  price DOUBLE(6,2) NOT NULL DEFAULT 10.0,
  sellable TINYINT(1) DEFAULT 1,
  copies INTEGER NOT NULL DEFAULT 1,
  description TEXT 
);

CREATE TABLE IF NOT EXISTS operations (
	operation_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	book_id INTEGER UNSIGNED,
	client_id INTEGER UNSIGNED,
	`type` ENUM('S', 'B', 'R') NOT NULL COMMENT 'S->Sellable, B->Borrowed, R->Returned',
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	finished TINYINT(1) NOT NULL
);


INSERT INTO authors(author_id, name, nationality)
VALUES(NULL,'Juan Rulfo', 'MEX');

INSERT INTO authors(name, nationality)
VALUES('Gabriel García Márquez', 'COL');

INSERT INTO authors
VALUES('', 'Andres Caicedo', 'COL');

INSERT INTO authors(name, nationality)
VALUES('Julio Cortazar', 'ARG'),
	('Isabel Allende', 'CHI'),
	('Octavio Paz', 'MEX');
	
INSERT INTO authors(author_id, name)
VALUES(16, 'Pablo Neruda');


INSERT INTO `clients`(client_id, name, email, birthdate, gender, active) VALUES
(1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1);


INSERT INTO `clients`(name, email, birthdate, gender, active) VALUES
('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1);

INSERT INTO `clients`(name, email, birthdate, gender, active) VALUES
('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
-- NO USAR IGNORE ALL
ON DUPLICATE KEY IGNORE ALL;

INSERT INTO `clients`(name, email, birthdate, gender, active)
VALUES
('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
-- CUANDO ENCUENTRES UNA LLAVE DUPLICADA ACTUALIZA EL VALOR A LO QUE SE ENVIA EN ESTA SENTENCIA
ON DUPLICATE KEY UPDATE SET active = VALUES(active)


-- El laberinto de la soledad, Octavio Paz, 1952
-- Vuelta al Laberinto de la soledad, 1960
INSERT INTO books(title, author)
VALUES('El laberinto de la Soledad', 6);


INSERT INTO books(title, author, `year`)
-- Subquery permite hacer un select dentro de otro query, Para 
-- traer el valor del subquery como parametro del query principal
VALUES('El laberinto de la Soledad',
	(SELECT author_id FROM authors
	WHERE name = 'Octavio Paz'
	LIMIT 1), 1960
);

UPDATE books
SET year = 1952
WHERE 
	book_id = 1;

UPDATE books
SET title = 'Vuelta al laberinto de la soledad'
WHERE 
	book_id = 2;