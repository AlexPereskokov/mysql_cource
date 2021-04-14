-- Практическое задание №2.

/* Задание №1.
	Создать файл .my.cnf */
[mysql]
user=root
password=
-- Несмотря на создание файла вход также возможен только благодоря ранее изученному входу с паролем (mysql -u root -p)

/*Задание №2.
	Создадим базу данных example c таблицей users и двумя столбцами: id & name */
-- Заходим mysql
mysql -u root -p
-- Создаём базу данных example
CREATE DATABASE  example;
-- Cоздадим таблицу users c двумя стобцами разных типов данных 
CREATE TABLE  users (id SERIAL PRIMARY KEY,name VARCHAR(255) COMMENT 'Имя пользователя');
-- Вариантов типов данных много, использование зависит от конкретных целей
exit

/*Задание №3.
	Создать дамп созданной example бд, развернуть содержимое дампа в бд sample */
-- Создадим бд sample
CREATE DATABASE sample;
-- Сделаем дамп
mysqldump -u root -p example > sample.sql
mysql -u root -p sample < sample.SQL
-- Зайдём для проверки созданной базы
mysql -u root -p
SHOW databeses;
-- Выведем таблицу
DESCRIBE sample.users;

/*Задание №4.
	Дамб таблицы help_keyword, но только первых 100 строк */
-- Делаем дамп
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > firs_100_rows_h_k.sql
-- Перекидываем файл в созданную бд (dump_h_k)
mysql -u root -p dump_h_k < firs_100_rows_h_k.SQL
-- Получаем ошибку, таблица зарезервирована базой mysql.