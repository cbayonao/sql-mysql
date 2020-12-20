SELECT DISTINCT nationality FROM authors;
SELECT COUNT(book_id) FROM books;
SELECT COUNT(book_id), SUM() FROM books;


-- La Ciudad de autores con los precios mas caros en libros
SELECT DISTINCT a.nationality AS nationalities, SUM(b.price) AS sum_Bprice
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE nationality IS NOT NULL
GROUP BY nationalities
ORDER BY sum_Bprice DESC LIMIT 1;

-- Obtener el precio por el numero de copias
-- Podemos hacer operaciones en las columnas del select 
SELECT SUM(price*copies) FROM books
WHERE sellable = 1;

-- Condiciones
SELECT COUNT(book_id), SUM(IF(year < 1950, 1, 0)) AS `<1950` FROM books;

SELECT COUNT(book_id) FROM books
WHERE year < 1950;

-- Cuenta de todos los libros, cuenta libros menores al año 1950
-- Cuenta de todos los libros mayores a 1950
SELECT COUNT(book_id),
	SUM(IF(year < 1950, 1, 0)) AS `Menor a 1950`,
	SUM(IF(year < 1950, 0, 1)) AS `Mayor a 1950`
FROM books;


-- 2
SELECT COUNT(book_id),
	SUM(IF(year < 1950, 1, 0)) AS `Menor a 1950`,
	SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS `< 1990`,
	SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS `< 2000`,
	SUM(IF(year >= 2000, 1, 0)) AS `>= 2000`
FROM books;


SELECT nationality, COUNT(book_id),
	SUM(IF(year < 1950, 1, 0)) AS `Menor a 1950`,
	SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS `< 1990`,
	SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS `< 2000`,
	SUM(IF(year >= 2000, 1, 0)) AS `< HOY`
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE
	a.nationality IS NOT NULL
GROUP BY nationality;
