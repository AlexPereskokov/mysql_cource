-- Практическое задание №5.

-- "Операторы, фильтрация, сортировка и ограничение"

/* Задание №1.
	Заполнить текущими датой и временем таблицы created_at and updated_at */

DROP TABLE IF EXISTS users ;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';


INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
	
 UPDATE users
	SET created_at = NOW(),
	updated_at = NOW();  -- заполнение текущей датой и временем таблицы

SELECT * FROM users; -- просмотр заполненных таблиц


/*Задание №2.
	Преобразовать поля к типу DATETIME, сохранив введённые ранее значения */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
UPDATE users
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i'); -- преобразовывыем колонки таблиц к нужному виду datetime

ALTER TABLE users MODIFY COLUMN created_at DATETIME; -- изменяем тип данных колонок
ALTER TABLE users MODIFY COLUMN updated_at DATETIME; -- изменяем тип данных колонок
 
SELECT * FROM users; -- просмотр заполненных таблиц

SHOW CREATE TABLE users; -- просмотр изменённой таблицы
	
/*Задание №3.
	Отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
 
SELECT * FROM storehouses_products
	ORDER BY CASE WHEN value = 0 THEN 2501 ELSE value END; -- упорядочим вывод таблицы по значениям

-- пробовал через максимальное значение через select max(value) from s_p, правильно выдаёт 2500, но нужно число больше, ибо тогда 0 один уйдёт вперёд
-- просто когда не знаем максимальное значение нужно как-то практичнее записать число, но как не понял, надеюсь на Ваш ответ)

SELECT * FROM storehouses_products; -- просмотр заполненной таблицы

/*Задание №4.
	Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
SELECT * FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}'; -- извлечение(вывод) пользователей, рождённых в мае/августе

DELETE FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}'; -- извлечение(удаление) пользователей, если потребуетс

SELECT * FROM users; -- просмотр заполненных таблиц

/*Задание №5.
	Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. */

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

 SELECT * FROM catalogs
	WHERE id IN(5,1,2) ORDER BY CASE
	WHEN id =5 THEN 0
	WHEN id =1 THEN 1
	WHEN id =2 THEN 2
END; -- вывод отсортированных( в условиях задачи) name таблицы каталога
 
-- Практическое задание №5.

-- "Агрегация данных"

/* Задание №1.
	Подсчитать средний возраст пользователей в таблице users */

/* Задание №2.
	Подсчитать количество дней рождений, приходящихся на каждный из дней недели. Учитывая текущий год */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
SELECT round(avg(to_days(now()) - to_days(birthday_at)) / 365.25) AS AVG_AGE FROM users; -- вывод среднего возраста пользователей

-- для среднего возраста мы использовали несколько функций: round(округление до целой части) и avg(для среднего математического)

SELECT dayname(concat(YEAR(now()), '-', substring(birthday_at,6,10))) AS day_of_birthday,
	count(dayname(concat(YEAR(now()), '-', substring(birthday_at,6,10)))) AS count_of_birthday
	FROM users GROUP BY day_of_birthday; -- вывод таблицы дней и количества ДР в этот день недели
	
-- исользуем concat для сложение строковых значений (год - (месяц- день)
-- используем substring для извлечения (месяц-день)
-- используем dayname для преобразования даты в день недели
-- используем count для подсчёта 

/* Задание №3.
	Подсчитайте произведение чисел в столбце таблицы */
CREATE TABLE x (id INT PRIMARY KEY);

INSERT INTO x VALUES (1), (2), (3), (4), (5);

SELECT * FROM x; -- просмотр созданной таблицы

SELECT round(EXP(sum(log(id)))) AS products FROM x; -- произведение стобца таблицы

-- воспользуемся свойсвом логорифмов - произведение равно сумме
-- берём обратную функцию exp - для раскрытие скобок под логорфмом
-- округлим значение - round


