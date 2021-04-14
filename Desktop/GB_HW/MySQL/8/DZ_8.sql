-- Практическое задание №8.

-- "Транзакции, переменные, представления"

-- Подгрузим существующие файлы для реализации задачи 

CREATE DATABASE shop;

USE shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
  total DECIMAL (11,2) COMMENT 'Счет',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Счета пользователей и интернет магазина';

INSERT INTO accounts (user_id, total) VALUES
  (4, 5000.00),
  (3, 0.00),
  (2, 200.00),
  (NULL, 25000.00);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';


INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

/* Задание №1.
	Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

-- Сделаем повторную таблицу в новой бд

DROP DATABASE IF EXISTS sample;

CREATE DATABASE sample;

USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM users; -- вид нашей таблицы (пока пуста)

-- Выполним транзакцию с переносом записи 

START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;

COMMIT; -- сохраняем изменения

SELECT * FROM users; -- проверка вида таблицы


/*Задание №2.
	Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs */

-- Вернёмся к загруженной БД и создадим нужное представление 

USE shop;

CREATE OR REPLACE VIEW prod_catalog (prod_id, prod_name, cat_name)
AS SELECT p.id, p.name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat
ON p.catalog_id = cat.id;

SELECT * FROM prod_catalog; -- просмотр созданной таблицы-представления


/*Задание №3.
	Запрос создания августа с конкретными датами */

-- Создадим и заполним таблицу дат

CREATE TABLE date_tbl(
	created_at DATE
);

INSERT INTO date_tbl VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

SELECT * FROM date_tbl; -- проверка созданной таблицы

-- Сделаем запрос с созданием месяца и проверкой на наличие дат в созданной таблице

SELECT gen_date AS august_day,
(SELECT EXISTS (SELECT * FROM date_tbl WHERE created_at = august_day)) AS presence
FROM 
(SELECT * FROM
(select adddate('2018-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) gen_date from
 (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
 (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
 (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
 (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
 (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
WHERE gen_date BETWEEN '2018-08-01' AND '2018-08-31') AS august_day
ORDER BY august_day;

-- явно есть более изящное решение, чем создание такого огромного количества дат и дальнейшего вычленения необходимых, но тут уже нужны процедуры)


/*Задание №4.
	Запрос с обновлением таблицы до 5 свежих записей. */

-- Будем оперировать с нашей таблицей, добавим записей

SELECT * FROM date_tbl; -- наша таблица

INSERT INTO date_tbl VALUES
	('2018-08-10'),
	('2018-08-12'),
	('2018-08-26'),
	('2018-08-03');

SELECT * FROM date_tbl
ORDER BY created_at DESC 
LIMIT 5; -- 5 свежих строк

-- Удалим строки, которые не выходят в 5 свяжих

DELETE FROM date_tbl
WHERE created_at NOT IN (SELECT * FROM 
(SELECT * FROM date_tbl
ORDER BY created_at DESC 
LIMIT 5) AS fresh_c_ad
);

SELECT * FROM date_tbl ORDER BY created_at; -- проверяем
 
-- Практическое задание №8.

-- "Администрирование MySQL"

/* Задание №1.
	Создать двух пользователей с доступом к бд shop. 1 - запрос на чтение, 2 - любые операции */

-- Создадим первого пользователя с привелегией чтения

DROP USER IF EXISTS 'shop_reader'@'localhosts';
CREATE USER 'shop_reader'@'localhost' identified WITH sha256_password BY '123';
GRANT SELECT ON shop.* TO 'shop_reader'@'localhost'; -- даём привелегию чтения (select) по бд shop

-- Прописываем в cmd: mysql -h localhost -u shop_reader -p

-- Проверим работу 

SELECT * FROM users; -- доступна для пользователя

-- Недоступные команды 

DROP TABLE test777;
CREATE TABLE test777(
tesе int
);

-- Создадим второго пользователя с полными привелегиями

DROP USER IF EXISTS 'shop_full'@'localhost';
CREATE USER 'shop_full'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop.* TO 'shop_full'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop_full'@'localhost';

-- Прописываем в cmd: mysql -h localhost -u shop_full -p

-- Проверим работу 

CREATE TABLE tst(
some_tst int
);

INSERT INTO tst VALUES 
	(12),
	(15),
	(2);
ALTER TABLE tst MODIFY COLUMN some_tst INT PRIMARY KEY;

SELECT * FROM tst;

DROP TABLE tst;

-- Всё работает, команды доступны

/* Задание №2.
	Создать пользователя user_read без доступа к таблице accounts, но способный извлекать представление username */

-- Создание таблицы аккаунтов( _2 поскольку не хочется удалять имеющуюсся) 

DROP TABLE IF EXISTS accounts_2;
CREATE TABLE accounts_2 (
	id SERIAL PRIMARY KEY,
	name VARCHAR(45),
	password VARCHAR(45)
);

INSERT INTO accounts_2 VALUES
	(NULL, 'alex', '123'),
	(NULL, 'john', '123'),
	(NULL, 'roy', '123');

-- Создадим представление username

CREATE OR REPLACE VIEW username(user_id, user_name) AS 
	SELECT id, name FROM accounts_2;

SELECT * FROM accounts_2; -- наша созданная таблица 
SELECT * FROM username; -- представление

-- Создадим нашего пользователя c привилегиями нашей задачи

DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.username TO 'shop_reader'@'localhost';

-- Прописываем в cmd: mysql -h localhost -u shop_reader -p

-- Проверим работу

SELECT * FROM accounts; -- недоступная команды 

SELECT * FROM username; -- доступная команда

-- Непонятно только как переключать пользователей внутри DBeaver, всё проверки были консольные, мб подскажете)


-- Практическое задание №8.

-- "Хранимые процедуры и функции, триггеры"

/* Задание №1.
	Создать функцию hello(), функция в зависимости от времени возвращает приветствие */

DROP FUNCTION IF EXISTS hello;

delimiter //  -- для понимания конца функции

CREATE FUNCTION hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '11:59:59' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '17:59:59' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '23:59:59' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //

delimiter ; -- опять заменим для отрабатывания call

CALL hello(); -- вызов функции


-- Сделаем это с использованием IF/ELSE

DROP PROCEDURE IF EXISTS hello;

delimiter //

CREATE PROCEDURE hello()
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '11:59:59') THEN
		SELECT 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '17:59:59') THEN
		SELECT 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '23:59:59') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //

delimiter ;

CALL hello();


/* Задание №2.
	Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию. */

DROP TRIGGER IF EXISTS nullTrigger;

delimiter //

CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //

delimiter ;

-- Проверки 

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5000, 2); -- два неопределённых поля, отмена операции

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", NULL, 15000, 12); -- удачно

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", "Мощная видеокарта", 15000, 12); -- удачно

