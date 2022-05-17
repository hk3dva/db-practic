USE library;

-- 3.1.a  Без указания списка полей
INSERT INTO author
VALUES
    (1000, 'Alexander', 'Pushkin'); 
    
INSERT INTO author
VALUES
    ('Alexander', 'Pushkin', 1001);

INSERT INTO author
VALUES
    (1002, NULL, 'Pushkin'); 
    
INSERT INTO author
VALUES 
    (NULL, 'Alexander', NULL);
    
-- 3.1.б  С указанием полей списка
INSERT INTO author (first_name, last_name) 
VALUES
    ('Alexander', 'Pushkin'); 
    
INSERT INTO author (last_name, first_name) 
VALUES
    ('Pushkin', 'Alexander'); 
 
INSERT INTO author (first_name, last_name) 
VALUES 
    ('Alexander', 'Pushkin'),
    ('Alexander', 'Pushkin II');

-- 3.1.c  С чтением значения из другой таблицы

-- 3.2.a Удаление всех записей
TRUNCATE TABLE author;
TRUNCATE TABLE book;
TRUNCATE TABLE copy;
TRUNCATE TABLE reader;
TRUNCATE TABLE author;

-- 3.2.b Удаление по условию
DELETE FROM author WHERE last_name LIKE 'Pushkin%';

-- 3.3.a Update всех записей
UPDATE author SET first_name = 'Alexander ';

-- 3.3.b по условию обнавляя один атрибут
INSERT INTO author (first_name, last_name) 
VALUES
    ('Alexander', 'Pushkin');
UPDATE author SET first_name = 'Alexander I' WHERE last_name = 'Pushkin';

-- 3.3.c по условию обнавляя несколько атрибутов
UPDATE reader SET first_name = 'NewFirstName', last_name='NewLastName' WHERE reader_num=23644;

-- 3.4.a с набором извлекаемых атрибутов
SELECT first_name, last_name FROM author;

-- 3.4.b со всеми атрибутами
SELECT * FROM book;
SELECT * FROM author;
SELECT * FROM category;
SELECT * FROM category_has_book;
SELECT * FROM copy;
SELECT * FROM issuance;
SELECT * FROM reader;

-- 3.4.c с условием по атрибуту
SELECT * FROM book WHERE id_book < 10;

-- 3.5.a с сотировкой по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM book ORDER BY publication_year ASC LIMIT 10;

-- 3.5.b с сортировкой по убыванию DESC
SELECT * FROM book ORDER BY publication_year DESC LIMIT 10;

-- 3.5.c с сортировкой по двум атрибутам + ограничение вывода количества записей 
SELECT * FROM book ORDER BY publication_year, page_num LIMIT 10;   

-- 3.5.d с сортировкой по первому атрибуту, из списка извлекаемых
SELECT * FROM book ORDER BY 1;   

-- 3.6.a по дате
SELECT * FROM book WHERE publication_year=1980 OR publication_year=2001;

-- 3.6.b дата в диапазоен
SELECT * FROM book WHERE publication_year BETWEEN 2001 AND 2011 ORDER BY publication_year;

-- 3.6.c извлечь из таблицы не всю дату, а только год
SELECT YEAR(admission_date) AS admission_date FROM copy;

-- 3.7.a посчитать количество записей в таблице
SELECT COUNT(*) FROM book;

-- 3.7.b посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT publication_year) AS unikal_year FROM book; 

-- 3.7.c вывести уникальные значения столбца
SELECT DISTINCT page_num AS unikal_page_num FROM book; 

-- 3.7.f написать запрос COUNT() + GROUP BY
SELECT COUNT(DISTINCT publication_year), page_num FROM book GROUP BY page_num; 

-- 3.7.d найти максимальное значение столбца
SELECT MAX(page_num) AS max_page FROM book;

-- 3.7.e найти минимальное значение столбца
SELECT MIN(page_num) AS min_page FROM book;

-- 3.8.a Написать 3 запроса с использованием GROUP BY + HAVING
-- года в которых было написанно больше чем 4 книги 
SELECT publication_year, COUNT(*) AS count FROM book
GROUP BY publication_year
	HAVING COUNT(*) > 4;
	
-- id книг больше 10 но меньше 15
SELECT id_book AS book FROM book
	HAVING id_book > 10 AND id_book < 15; 
    
-- год в период с 1901 по 1903 в который было выпушенно больше 5 книг
SELECT publication_year, COUNT(page_num) FROM book
WHERE  publication_year IN (1901, 1902, 1903)
GROUP BY publication_year
	HAVING COUNT(*) > 5;

-- 3.9.a LEFT JOIN  (2) + WHERE
SELECT b.name, b.id_book, c.id_book, c.admission_date FROM book b
LEFT JOIN copy c
    ON b.id_book = c.id_book 
    WHERE YEAR(c.admission_date) > 2000;

-- 3.9.b RIGHT JOIN (2) + WHERE
SELECT b.name, b.id_book, c.id_book, c.admission_date FROM book b
RIGHT JOIN copy c
    ON b.id_book = c.id_book 
    WHERE YEAR(c.admission_date) > 2000
    ORDER BY c.id_book;

-- 3.9.c LEFT JOIN  (3) + WHERE
SELECT r.reader_num, i.deadline_date, c.number FROM reader r
LEFT JOIN issuance i
    ON r.id_reader = i.id_reader
LEFT JOIN copy c
    ON c.id_copy = i.id_copy
    WHERE YEAR(deadline_date) < 2005;

-- 3.9.d INNER JOIN (2)
SELECT r.first_name, r.last_name, i.deadline_date 
FROM reader r
INNER JOIN issuance i
	ON r.id_reader = i.id_reader

-- 3.10.a с условием WHERE IN (подзапрос)
SELECT * FROM book
WHERE book.id_book IN (SELECT DISTINCT id_book FROM copy WHERE id_book < 10);

-- 3.10.b SELECT atrl1, atrl2 (подзапрос) FROM..
SELECT b.name, (SELECT MAX(c.id_copy) FROM copy c) 
	AS copyNum FROM book b;

-- 3.10.c SELECT * FROM (подзапрос)
SELECT id_reader FROM (
    SELECT * FROM issuance
    WHERE YEAR(deadline_date) < 2010 
) overdue

-- 3.10.d SELECT * FROM table JOIN (подзапрос) ON..
SELECT * FROM copy JOIN (
    SELECT name, id_book FROM book
    WHERE book.id_book < 10
) books
    ON books.id_book = copy.id_copy;
    
    
    
    