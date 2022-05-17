USE shop;

-- 3.1.a  Без указания списка полей
INSERT INTO warehouse 
VALUES 
    (1, 5, 'продуктовый', 'Йошкар-Ола, улица Советская, 113', 2000),
    (2, 17, 'хозяйственный', 'Йошкар-Ола, улица Дружбы, 37', 1000),
    (3, 243, 'инструментальный', 'Йошкар-Ола, улица Строителей 75', 800),
    (4, 1, 'военный', 'Йошкар-Ола, улица Мира 28', 7000);

-- 3.1.б  С указанием полей списка
INSERT INTO employee (name, age, post, wages, id_warehouse)
VALUES  
    ('Роман', 37, 'охранник', 30000, 3),
    ('Андрей', 25, 'грузчик', 20000, 3),
    ('Дмитрий', 48, 'директор', 45000, 3);

INSERT INTO employee (name, age, post, wages, id_warehouse)
VALUES  
    ('Кирилл', 41, 'охранник', 25000, 2),
    ('Александр', 30, 'грузчик', 15000, 2),
    ('Игорь', 29, 'директор', 35000, 2);

INSERT INTO employee (name, age, post, wages, id_warehouse)
VALUES  
    ('Олег', 28, 'охранник', 35000, 1),
    ('Дмитрий', 23, 'грузчик', 25000, 1),
    ('Глеб', 35, 'директор', 50000, 1);

INSERT INTO invoice (number, extradition, sender, recipient, id_warehouse)
VALUES
    (60, '2015-12-17', 'Баранов Глеб Алексеевич', 'Беляев Григорий Александрович', 1),
    (7, '2012-06-13', 'Кузнецов Герасим Константинович', 'Никитин Вячеслав Русланович   ', 1),
    (90, '2019-01-25', 'Артемьев Матвей Евсеевич', 'Федосеев Николай Романович', 1);

INSERT INTO invoice (number, extradition, sender, recipient, id_warehouse)
VALUES
    (51, '2020-09-01', 'Вишняков Тимур Якунович', 'Макаров Абрам Георгиевич', 2),
    (69, '2018-11-10', 'Шаров Прохор Анатольевич', 'Мышкин Орест Серапионович', 2),
    (14, '2013-12-19', 'Ковалёв Платон Наумович', 'Исаев Константин Григорьевич', 2);

INSERT INTO invoice (number, extradition, sender, recipient, id_warehouse)
VALUES
    (91, '2017-01-08', 'Жуков Емельян Кириллович', 'Петухов Макар Мэлорович', 3),
    (74, '2019-02-23', 'Гришин Марк Демьянович', 'Селезнёв Зиновий Владленович', 3),
    (31, '2021-03-26', 'Лихачёв Самуил Геласьевич', 'Молчанов Остап Романович', 3);

INSERT INTO invoice (number, extradition, sender, recipient, id_warehouse)
VALUES
    (90, '2014-10-13', 'Брагин Тихон Владиславович', 'Казаков Петр Евсеевич', 4),
    (12, '2015-04-10', 'Исаков Ефрем Петрович', 'Савельев Велорий Рудольфович', 4),
    (96, '2016-06-22', 'Калинин Родион Михаилович', 'Горбачёв Ефим Яковлевич', 4);

INSERT INTO product (name, width, height, weight)
VALUES
    ('хлеб', 15, 10, 1),
    ('консервы', 10, 5, 1),
    ('рыба', 8, 5, 3),
    ('сыр', 15, 20, 2),
    ('алкогольный напиток', 10, 30, 5);

INSERT INTO product (name, width, height, weight)
VALUES
    ('швабра', 7, 100, 1),
    ('ведро', 15, 25, 1),
    ('мыло', 8, 5, 3),
    ('веревка', 15, 200, 2),
    ('перчакти', 10, 30, 5);

INSERT INTO product (name, width, height, weight)
VALUES
    ('молоток', 15, 30, 1),
    ('штангенциркуль', 10, 5, 1),
    ('клещи', 8, 5, 3),
    ('угольник', 15, 20, 2),
    ('ключ', 10, 30, 5);

INSERT INTO product (name, width, height, weight)
VALUES
    ('Т-90', 700, 200, 1),
    ('АК-74', 100, 35, 1),
    ('снаряд М-31', 50, 20, 3),
    ('ППШ', 110, 29, 2),
    ('снаряд для Катюши', 46, 26, 5);

INSERT INTO goods_in_invoice (number, price, quantity, id_product, id_invoice)
VALUES
    (1, 30, 700, 1, 1),
    (2, 100, 20, 2, 1),
    (1, 300, 15, 3, 2),
    (2, 500, 5, 4, 2),
    (1, 1500, 20, 5, 3);

INSERT INTO goods_in_invoice (number, price, quantity, id_product, id_invoice)
VALUES
    (1, 200, 50, 6, 4),
    (2, 200, 50, 7, 4),
    (1, 150, 200, 8, 5),
    (2, 50, 70, 9, 5),
    (1, 20, 2000, 10, 6);

INSERT INTO goods_in_invoice (number, price, quantity, id_product, id_invoice)
VALUES
    (1, 100, 120, 11, 7),
    (2, 100, 250, 12, 7),
    (1, 100, 70, 13, 8),
    (2, 100, 89, 14, 8),
    (1, 100, 187, 15, 9);

INSERT INTO goods_in_invoice (number, price, quantity, id_product, id_invoice)
VALUES
    (1, 3000000, 20, 16, 10),
    (2, 50000, 120, 17, 10),
    (1, 10000, 1500, 18, 11),
    (2, 47000, 150, 19, 11),
    (1, 17000, 2000, 20, 12);

-- 3.2.a Удаление всех записей
TRUNCATE TABLE warehouse;
TRUNCATE TABLE employee;
TRUNCATE TABLE invoice;
TRUNCATE TABLE goods_in_invoice;
TRUNCATE TABLE product;

-- 3.2.b Удаление по условию
DELETE FROM product WHERE weight < 3;

-- 3.3.a всех записей
UPDATE warehouse SET area=5000;

-- 3.3.b по условию обнавляя один атрибут
UPDATE employee SET wages=100000 WHERE id_employee=12;

-- 3.3.c по условию обнавляя несколько атрибутов
UPDATE employee SET wages=85000, post='главный директор' WHERE age > 35 AND post='директор';

-- 3.4.a с набором извлекаемых атрибутов
SELECT extradition, recipient FROM invoice;

-- 3.4.b со всеми атрибутами
SELECT * FROM warehouse;
SELECT * FROM employee;
SELECT * FROM invoice;
SELECT * FROM goods_in_invoice;
SELECT * FROM product;

-- 3.4.c с условием по атрибуту
SELECT * FROM employee WHERE wages < 50000;

-- 3.5.a с сотировкой по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM goods_in_invoice ORDER BY quantity ASC LIMIT 6;

-- 3.5.b с сортировкой по убыванию DESC
SELECT * FROM goods_in_invoice ORDER BY quantity DESC;

-- 3.5.c с сортировкой по двум атрибутам + ограничение вывода количества записей 
SELECT * FROM goods_in_invoice ORDER BY quantity, price LIMIT 6;   

-- 3.5.d с сортировкой по первому атрибуту, из списка извлекаемых
SELECT * FROM goods_in_invoice ORDER BY 1;   

-- 3.6.a по дате
SELECT * FROM invoice WHERE extradition='2017-01-08' OR extradition='2015-12-17';

-- 3.6.b дата в диапазоен
SELECT * FROM invoice WHERE extradition BETWEEN '2015-01-01' AND  '2021-12-31' ORDER BY extradition;

-- 3.6.c извлечь из таблицы не всю дату, а только год
SELECT YEAR(extradition) AS year, sender, recipient FROM invoice;

-- 3.7.a посчитать количество записей в таблице
SELECT COUNT(*) FROM product;

-- 3.7.b посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT price) AS number_of_unique_prices FROM goods_in_invoice; 

-- 3.7.f написать запрос COUNT() + GROUP BY
SELECT COUNT(price), price FROM goods_in_invoice GROUP BY price; 

-- 3.7.d найти максимальное значение столбца
SELECT MAX(price) AS max_price FROM goods_in_invoice;

-- 3.7.e найти минимальное значение столбца
SELECT MIN(price) AS min_price FROM goods_in_invoice;

-- 3.8.a Написать 3 запроса с использованием GROUP BY + HAVING
-- узнать сколько товаров имеют одинаковую цену
SELECT price, COUNT(price) as count FROM goods_in_invoice 
	GROUP BY price HAVING count > 1;

-- на каких складах количетсво работников превышает 2-х
SELECT (SELECT type FROM warehouse
		WHERE warehouse.id_warehouse = employee.id_warehouse) AS warehouses,
        COUNT(id_employee) AS employees
FROM employee GROUP BY warehouses HAVING employees > 2;

-- узнать сколько накладных было отпралено в каждом году во 2-м складе
SELECT YEAR(extradition), COUNT(number) AS numbers_invoice, id_warehouse FROM invoice
	GROUP BY YEAR(extradition) HAVING id_warehouse = 2;

-- 3.9.a LEFT JOIN  (2) + WHERE
SELECT type, address, name, age, post FROM warehouse 
LEFT JOIN employee 
    ON warehouse.id_warehouse = employee.id_warehouse 
    WHERE post="директор";

-- 3.9.b RIGHT JOIN (2) + WHERE
SELECT type, address, name, age, post FROM warehouse 
RIGHT JOIN employee 
    ON warehouse.id_warehouse = employee.id_warehouse 
    WHERE post="директор";

-- 3.9.c LEFT JOIN  (3) + WHERE
SELECT extradition, price, quantity, name FROM invoice 
LEFT JOIN goods_in_invoice 
    ON goods_in_invoice.id_invoice = invoice.id_invoice
LEFT JOIN product 
    ON goods_in_invoice.id_product = product.id_product;

-- 3.9.d INNER JOIN (2)
SELECT type, address, name, age, post 
FROM employee 
INNER JOIN warehouse
    USING (id_warehouse);



-- 3.10.a с условием WHERE IN (подзапрос)
SELECT * FROM invoice WHERE id_warehouse IN (
    SELECT id_warehouse FROM warehouse
    WHERE area >= 2000);

-- 3.10.b SELECT atrl1, atrl2 (подзапрос) FROM..
SELECT price, (
	SELECT name FROM product 
    WHERE product.id_product = goods_in_invoice.id_product
) AS product FROM goods_in_invoice;
	
-- 3.10.c SELECT * FROM (подзапрос)
SELECT extradition, sender, recipient FROM (
    SELECT * FROM invoice
    WHERE extradition > '2019-01-01'
) recent_invoices ORDER BY extradition;

-- 3.10.d SELECT * FROM table JOIN (подзапрос) ON..
SELECT * FROM goods_in_invoice JOIN (
    SELECT name, id_product FROM product
    WHERE weight > 1
) heavy_product
    ON heavy_product.id_product = goods_in_invoice.id_product;