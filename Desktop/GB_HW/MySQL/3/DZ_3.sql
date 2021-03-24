-- ������������ ������� �3.

/* ������� �1.
	���������������� ��������� �� vk, ����������� �� ������������������ */
DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

USE vk;

SHOW tables;

CREATE TABLE users (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(145) NOT NULL, -- COMMENT '���',
 last_name VARCHAR(145) NOT NULL,
 email VARCHAR(145) NOT NULL,
 phone INT UNSIGNED NOT NULL,
 password_hash CHAR(65) DEFAULT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE INDEX email_unique (email),
 UNIQUE INDEX phone_unique (phone)
) ENGINE=InnoDB;

SELECT * FROM users;

DESCRIBE users; -- �������� �������

CREATE TABLE profiles (
 user_id BIGINT UNSIGNED NOT NULL,
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
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 from_user_id BIGINT UNSIGNED NOT NULL,
 to_user_id BIGINT UNSIGNED NOT NULL,
 txt TEXT NOT NULL,
 is_delivered BOOLEAN DEFAULT FALSE,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
 INDEX fk_messages_from_user_idx (from_user_id),
 INDEX fk_messages_to_user_idx (to_user_id),
 CONSTRAINT fk_messages_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_messages_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);

DESCRIBE messages;

CREATE TABLE friend_requests (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 from_user_id BIGINT UNSIGNED NOT NULL,
 to_user_id BIGINT UNSIGNED NOT NULL,
 accepted BOOLEAN DEFAULT FALSE,
 INDEX fk_friend_requests_from_user_idx (from_user_id),
 INDEX fk_friend_requests_to_user_idx (to_user_id),
 CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE communities (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(145) NOT NULL,
 description VARCHAR(245) DEFAULT NULL,
 admin_id BIGINT UNSIGNED NOT NULL,
 INDEX fk_communities_users_admin_idx (admin_id),
 CONSTRAINT fk_communities_users FOREIGN KEY (admin_id) REFERENCES users (id)
);


CREATE TABLE communities_users (
 community_id BIGINT UNSIGNED NOT NULL,
 user_id BIGINT UNSIGNED NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY (community_id, user_id),
 INDEX fk_communities_users_comm_idx (community_id),
 INDEX fk_communities_users_users_idx (user_id),
 CONSTRAINT fk_communities_users_comm FOREIGN KEY (community_id) REFERENCES communities (id),
 CONSTRAINT fk_communities_users_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE media_types (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(45) NOT NULL
);

CREATE TABLE media (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED NOT NULL,
 media_types_id INT UNSIGNED NOT NULL,
 file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
 file_size BIGINT DEFAULT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX fk_media_media_types_idx (media_types_id),
 INDEX fk_media_users__idx (user_id),
 CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

-- �� �������� �� ��� ������ � ���� �� �����, ��������� ��������� ��������� � ������������ ���������
-- �������� ���, ������ ����� ��������������� ��������� �������, ���� ������ � ����������, ������� � ������� �����
-- ��� ������������ ��������� ����� ������ �������� ���-��, ���� ��������, 4 ����� ���������� ����, �� � ������ ������� �� ���� ����������������, ��������� � ��� ��� ������� ������������


/*������� �2.
	����������� ���� ������ ��� ��������� �� vk �� �������� � ����� ���������� ��������� */

-- ����� ������������

CREATE TABLE posts (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- id �����, ����������� ��� ������
 user_id BIGINT UNSIGNED NOT NULL, -- id ������
 txt TEXT NOT NULL, -- ���� �����, �� �������� � ����������� (�� �������)
 attached_file VARCHAR(245) DEFAULT NULL COMMENT '/path/file.jpg', -- ����������� ����,�����,������ ���� ���� (���� �������)
 file_size BIGINT DEFAULT NULL, -- ������ ������������ �����
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- ����� �������� 
 updated_at DATETIME DEFAULT ON UPDATE CURRENT_TIMESTAMP, -- ����� ���������� (�� �� �������� � �����������) 
 INDEX fk_user_posts_idx (user_id), -- ������ ��� ������ ������
 CONSTRAINT fk_user_posts FOREIGN KEY (user_id) REFERENCES users (id) -- ����� 1:������ � �������� users
);

-- ׸���� ������

CREATE TABLE black_list (
 originator_id BIGINT UNSIGNED NOT NULL, -- id ���������� ���������� � ��
 banned_id BIGINT UNSIGNED NOT NULL, -- id, ������������ � ��
 PRIMARY KEY (originator_id, banned_id), -- ���� ��� ������������ �����, ����������� ������
 INDEX fk_originator_idx (originator_id), -- ������ ����������, ��� ��������� ������ ������������
 INDEX fk_banned_idx (banned_id), -- ������ ������������ � ��, ��� ��������� ��� ��� �������
 CONSTRAINT fk_users_originator FOREIGN KEY (originator_id) REFERENCES users (id), -- ����� �� ������:������ � �������� users
 CONSTRAINT fk_users_banned FOREIGN KEY (banned_id) REFERENCES users (id) -- ����� �� ������:������ � �������� users
);

