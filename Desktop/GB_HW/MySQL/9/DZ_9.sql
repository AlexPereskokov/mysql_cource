-- Практическое задание №9.

-- "Оптимизация запросов"

-- Подгрузим существующие файлы для реализации задачи 

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина' ENGINE=InnoDB;

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
  desription TEXT COMMENT 'Описание',
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
	Создать таблицу logs типа Archive. При создании записи в других таблица в logs пеомещается время и дата создания записи, название, индентификатор и содержимое поля name */

-- создадим таблицу 

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	created_at DATETIME NOT NULL,
	table_name varchar(45) NOT NULL,
	str_id bigint(20) NOT NULL,
	name_value varchar(45) NOT NULL
) ENGINE = ARCHIVE; -- указываем необходимый тип 

-- для создания записей в новой таблице данных другой таблицы воспользуемся триггерами 

-- тригuер таблицы users

DROP TRIGGER IF EXISTS watchlog_users;
delimiter //  
CREATE TRIGGER watchlog_user AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(created_at, table_name, str_id, name_valuse) 
	VALUES (now(), 'users', NEW.id, NEW.name); -- префикс для новых значений
END //
delimiter ;

-- тригер таблицы catalogs

DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

-- -- тригер таблицы products

delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


/* Задание №2.
	Создайте SQL-запрос, который помещает в таблицу users миллион записей  */
 
-- Создадим тест таблицу для данного задания

DROP TABLE IF EXISTS test_users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- создадим процедуру заполнения

DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
delimiter ;

-- проверка с вызовом процедуры

SELECT * FROM test_users;

CALL insert_into_users();


-- Практическое задание №10.

-- "NoSQL"


/* Задание №1.
	В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.  */
 
-- Скачаем redis, ибо в Windows это не встроенно

-- следующие действия проведены в консоли  

-- возьмём в качестве адресов следующие 

SADD ip '127.0.0.1' '127.0.0.2' '127.0.0.3'

-- адреса уникальны, повторы невозможны (добавленных 0 напишет)

SADD ip '127.0.0.1' 


SMEMBERS ip -- список уникальный ip

SCARD ip -- подсчёт количества адресов

/* Задание №2.
	При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени  */
 
-- Скачаем redis, ибо в Windows это не встроенно

-- следующие действия проведены в консоли  

-- для выполнения двух условий будем устанавливать ключом имя и email

-- имя по почте

set alex@mail.ru alex 
get alex@mail.ru 

-- почту по имени

set alex alex@mail.ru
get alex 

/* Задание №3.
	Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB. */

-- Скачиваем mongoDB, проводим действия в консоли 

-- для таблицы товаров

use products
db.products.insertMany([
	{"name":'Intel Core i3-8100',"description": 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',"price": "7890.00","catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name"'Intel Core i5-7400',"description": 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',"price": "12700.00","catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name"'AMD FX-8320E',"description": 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',"price": "4780.00","catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name"'AMD FX-8320',"description": 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',"price": "7120.00","catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name"'ASUS ROG MAXIMUS X HERO',"description": 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',"price": "19310.00","catalog_id": "Мат. платы", "created_at": new Date(), "updated_at": new Date()},
	{"name"'Gigabyte H310M S2H',"description": 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',"price": "4790.00","catalog_id": "Мат. платы", "created_at": new Date(), "updated_at": new Date()},
	{"name"'MSI B250M GAMING PRO',"description": 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',"price": "5060.00","catalog_id": "Мат. платы", "created_at": new Date(), "updated_at": new Date()},;
])

db.products.find({name: "AMD FX-8320"}).pretty() -- проверка

-- для таблицы категорий 

use catalogs
db.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Мат.платы"}, {"name": "Видеокарты"}])
