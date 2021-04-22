-- Практическое задание №3.

/* Задание №1.
	Проанализировать созданную БД vk */
DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

USE vk;

SHOW tables;

CREATE TABLE users (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(145) NOT NULL, -- COMMENT 'Имя',
 last_name VARCHAR(145) NOT NULL,
 email VARCHAR(145) NOT NULL,
 phone INT UNSIGNED NOT NULL,
 password_hash CHAR(65) DEFAULT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE INDEX email_unique (email),
 UNIQUE INDEX phone_unique (phone)
) ENGINE=InnoDB;

ALTER TABLE users ADD COLUMN passport_number VARCHAR(10);

ALTER TABLE users MODIFY COLUMN passport_number VARCHAR(20);

ALTER TABLE users RENAME COLUMN passport_number TO passport;

ALTER TABLE users ADD UNIQUE KEY passport_unique (passport);

ALTER TABLE users DROP INDEX passport_unique;

ALTER TABLE users DROP COLUMN passport;

SELECT * FROM users;

DESCRIBE users; -- описание таблицы


CREATE TABLE profiles (
 user_id bigint UNSIGNED NOT NULL,
 gender ENUM('f','m','x') NOT NULL,
 birthday DATE NOT NULL,
 photo_id INT UNSIGNED,
 user_status VARCHAR(130),
 city VARCHAR(130),
 country VARCHAR(130),
 UNIQUE INDEX fk_profiles_users_to_idx (user_id),
 CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id)
);

DESCRIBE profiles;

CREATE TABLE messages (
 id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 from_user_id bigint UNSIGNED NOT NULL,
 to_user_id bigint UNSIGNED NOT NULL,
 txt TEXT NOT NULL,
 is_delivered BOOLEAN DEFAULT FALSE,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
 INDEX fk_messages_from_user_idx (from_user_id),
 INDEX fk_messages_to_user_idx (to_user_id),
 CONSTRAINT fk_messages_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_messages_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);

DESCRIBE messages;

CREATE TABLE friend_requests (
 id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 from_user_id bigint UNSIGNED NOT NULL,
 to_user_id bigint UNSIGNED NOT NULL,
 accepted BOOLEAN DEFAULT FALSE,
 INDEX fk_friend_requests_from_user_idx (from_user_id),
 INDEX fk_friend_requests_to_user_idx (to_user_id),
 CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE communities (
 id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(145) NOT NULL,
 description VARCHAR(245) DEFAULT NULL,
 admin_id bigint UNSIGNED NOT NULL,
 INDEX fk_communities_users_admin_idx (admin_id),
 CONSTRAINT fk_communities_users FOREIGN KEY (admin_id) REFERENCES users (id)
);


CREATE TABLE communities_users (
 community_id bigint UNSIGNED NOT NULL,
 user_id bigint UNSIGNED NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY (community_id, user_id),
 INDEX fk_communities_users_comm_idx (community_id),
 INDEX fk_communities_users_users_idx (user_id),
 CONSTRAINT fk_communities_users_comm FOREIGN KEY (community_id) REFERENCES communities (id),
 CONSTRAINT fk_communities_users_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE media_types (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name varchar(45) NOT NULL
);

CREATE TABLE media (
 id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 user_id bigint UNSIGNED NOT NULL,
 media_types_id INT UNSIGNED NOT NULL,
 file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
 file_size bigint DEFAULT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX fk_media_media_types_idx (media_types_id),
 INDEX fk_media_users__idx (user_id),
 CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

-- Создавал БД совместно с Вами на уроке, параллельно вникая в процесс
-- Всё достаточно понятно, просто нужно уметь различать типы данных для корректной записи, и понимать связи между таблицами
-- Относительно нормализации отношений всё также понятно, правда здесь в однострочных таблицах это не применишь

/*Задание №2.
	Дополним ранее созданную БД таблицами постов и ЧС */

-- Реализуем таблицу постов

CREATE TABLE posts (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id поста
	user_id BIGINT UNSIGNED NOT NULL, -- id автора поста
	txt TEXT NOT NULL, -- текст поста, не может быть нулевым
	attached_file VARCHAR(245) DEFAULT NULL COMMENT '/path/file.jpg', -- возможный вложенный файл,музыка,фото,видео
 	attached_file_size bigint DEFAULT NULL, -- размер вложенного файла
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- время создания поста
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, -- время обновления поста, меняется
	INDEX user_posts_idx (user_id), -- индекс юзера, для просмотров постов
	CONSTRAINT fk_user_posts FOREIGN KEY (user_id) REFERENCES users (id) -- связь 1:многим с таблицей users
);

SHOW CREATE TABLE posts; -- для проверки содержимого редактируемой таблицы

ALTER TABLE posts DROP COLUMN attached_file; -- удаление столбца
ALTER TABLE posts DROP COLUMN attached_file_size; -- удаление столбца
ALTER TABLE posts ADD COLUMN media_id bigint UNSIGNED NOT NULL; -- добавление столбца, важно, чтобы соблюдался тип данных переменной и связующего звена другой таблицы
ALTER TABLE posts
ADD CONSTRAINT fk_posts_media
FOREIGN KEY (media_id) REFERENCES media(id); -- создаём связь с таблицей media
-- Реализуем таблицу чёрного списка

CREATE TABLE black_list (
	initiator_id BIGINT UNSIGNED NOT NULL, -- id инициатора блокировки
	banned_id BIGINT UNSIGNED NOT NULL, -- id заблокированного пользователя
	PRIMARY KEY (initiator_id, banned_id), -- ключ пары, для предотвращения повторной блокировки при её наличии
	INDEX initiator_bl_idx (initiator_id), -- индекс инициатора, просмотр всех блокировок 
	INDEX banned_bl_idx (banned_id), -- индекс заблокированного пользователя, просмотр всех кто заблокировал
	CONSTRAINT fk_users_initiator_bl FOREIGN KEY (initiator_id) REFERENCES users (id), -- связь многиx:многим к таблице users
	CONSTRAINT fk_users_banned_bl FOREIGN KEY (banned_id) REFERENCES users (id) -- связь многиx:многим к таблице users
);