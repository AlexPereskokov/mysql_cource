-- Практическое задание №6.

-- "Операторы, фильтрация, сортировка и ограничение. Агрегация данных"

-- Загрузим наш готовый дамп с прошлых уроков, для проверки работоспособности наших запросов

-- MySQL dump 10.16  Distrib 10.3.10-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: vkn
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--
CREATE DATABASE vk2;

USE vk2;

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_communities_users_admin_idx` (`admin_id`),
  CONSTRAINT `fk_communities_users` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'autem','Omnis quia quo repellendus cupiditate et aut. Repudiandae incidunt dicta non aut nam est. Qui aspernatur a placeat corporis sed non facilis.',1),(2,'ipsam','Deleniti sed voluptatum aliquam tempore. Ipsam repudiandae et non soluta magni modi velit. Doloribus fugiat aut aliquid mollitia minima officiis. Quo quia possimus labore quibusdam quia.',1),(3,'odit','Dolorum sunt blanditiis rerum ea. Unde officiis veritatis voluptatem omnis modi. Autem quo et deleniti amet aut.',3),(4,'facilis','Sint deserunt magnam quibusdam perspiciatis. Eius deserunt voluptatem voluptatem inventore eveniet voluptatum aliquam. Quidem animi asperiores impedit quod.',5),(5,'ut','Voluptatem corporis aut delectus. Nesciunt possimus voluptatum voluptatem sapiente. Illo et neque quia qui voluptatem aut recusandae libero. Illo maxime quis id ut ut qui. Facere laborum qui dolor omnis.',5),(6,'quod','Id placeat at ut dolorum dolorem quas eius. Temporibus amet consequatur illum vel quibusdam fugit quia ullam. Iure asperiores voluptatem eveniet consequatur tempora exercitationem saepe quasi. Ex voluptas voluptatem blanditiis et.',5),(7,'omnis','Deserunt laborum qui corrupti vitae. Inventore in qui autem ea maiores ad. Vitae corporis est aspernatur totam tempora.',10),(8,'neque','Dolor exercitationem ea aperiam omnis sint quo sed. Tempora illum expedita asperiores. Mollitia reiciendis atque illo quos voluptas maiores est id.',10);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities_users`
--

DROP TABLE IF EXISTS `communities_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities_users` (
  `community_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`community_id`,`user_id`),
  KEY `fk_communities_users_comm_idx` (`community_id`),
  KEY `fk_communities_users_users_idx` (`user_id`),
  CONSTRAINT `fk_communities_users_comm` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`),
  CONSTRAINT `fk_communities_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities_users`
--

LOCK TABLES `communities_users` WRITE;
/*!40000 ALTER TABLE `communities_users` DISABLE KEYS */;
INSERT INTO `communities_users` VALUES (1,1,'1990-12-28 05:53:38'),(1,2,'1988-12-05 09:23:46'),(1,3,'2019-11-07 02:02:49'),(1,4,'1980-01-20 07:41:50'),(1,5,'1986-08-08 00:20:52'),(1,6,'2015-06-10 10:47:35'),(1,7,'2013-11-25 16:16:27'),(1,9,'2019-12-19 18:14:15'),(1,10,'1981-05-12 21:37:11'),(1,11,'1986-06-10 19:13:40'),(2,1,'2019-10-03 05:06:14'),(2,2,'2017-07-28 00:44:10'),(2,3,'2019-07-01 07:04:53'),(2,10,'1981-08-28 04:01:11'),(2,11,'1994-01-29 20:31:47'),(3,2,'2012-12-25 22:36:30'),(3,3,'2009-10-24 14:07:03'),(3,4,'1990-06-20 20:28:35'),(3,5,'1995-01-18 11:55:06'),(3,8,'1979-07-24 19:25:37'),(3,9,'2014-11-29 21:06:26'),(4,1,'1982-04-03 06:04:55'),(4,5,'1994-01-20 22:06:43'),(4,6,'1981-09-19 20:36:23'),(4,10,'1992-04-14 06:49:05'),(5,1,'1983-03-25 08:52:15'),(5,2,'1984-12-19 21:09:30'),(5,5,'2018-09-28 03:58:58'),(5,9,'1983-06-03 16:46:18'),(6,5,'1977-09-05 02:53:26'),(6,6,'2007-10-07 08:39:36'),(6,9,'1998-10-29 11:07:56'),(6,10,'1987-11-01 12:17:31'),(6,11,'1975-04-29 21:52:26'),(7,3,'2002-01-26 02:34:48'),(7,5,'1996-06-30 06:18:04'),(7,6,'1985-05-18 14:25:42'),(7,7,'1985-11-29 05:51:23'),(7,8,'1997-07-26 15:34:51'),(7,10,'2006-09-08 07:19:34'),(7,11,'1971-02-24 05:07:45'),(8,10,'1987-03-31 15:14:04');
/*!40000 ALTER TABLE `communities_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `request_type` int unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`from_user_id`,`to_user_id`),
  KEY `fk_friend_requests_from_user_idx` (`from_user_id`),
  KEY `fk_friend_requests_to_user_idx` (`to_user_id`),
  KEY `fk_friends_types` (`request_type`),
  CONSTRAINT `fk_friend_requests_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_friend_requests_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_friends_types` FOREIGN KEY (`request_type`) REFERENCES `friend_requests_types` (`id`),
  CONSTRAINT `sender_not_reciever_check` CHECK ((`from_user_id` <> `to_user_id`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,2,1,'2017-09-27 06:47:53'),(1,3,1,'1986-10-02 19:43:55'),(1,4,3,'2003-11-21 07:52:52'),(1,5,1,'2009-01-14 22:39:17'),(1,6,2,'1978-06-12 11:51:02'),(1,7,1,'1975-07-31 10:07:37'),(1,11,1,'2011-10-20 03:41:20'),(2,3,3,'1978-04-07 14:52:47'),(2,4,3,'2015-11-22 04:15:34'),(2,5,1,'1987-03-12 21:23:21'),(2,10,2,'2018-11-29 10:14:17'),(2,11,2,'1985-09-24 08:33:11'),(3,4,1,'2008-06-14 03:33:41'),(3,5,1,'1997-12-22 14:39:38'),(3,6,1,'2007-09-16 21:37:23'),(3,7,1,'2013-03-18 07:19:43'),(3,10,2,'2004-10-05 19:43:07'),(3,11,1,'2003-12-06 09:45:56'),(4,5,1,'1990-05-10 07:14:37'),(5,1,1,'2010-01-14 22:39:17'),(5,6,1,'1991-01-06 03:31:10'),(5,7,1,'1995-11-01 23:52:03'),(6,7,1,'1989-10-24 05:07:37'),(6,8,1,'1978-09-09 02:38:33'),(6,9,3,'1984-12-29 22:38:10'),(6,11,2,'1991-09-18 02:01:46'),(7,8,2,'1975-09-13 16:30:31'),(7,9,1,'2005-01-17 01:24:22'),(7,11,1,'1997-04-29 02:59:17'),(8,5,1,'1976-02-13 03:28:05'),(8,10,2,'1971-06-04 08:18:54'),(9,8,3,'1990-03-15 09:58:18'),(9,10,1,'1982-03-22 05:09:28'),(10,5,1,'1971-06-18 06:46:58'),(10,7,3,'2012-02-04 06:36:36'),(10,11,3,'1981-02-10 08:41:17'),(11,5,3,'2010-04-29 11:07:45'),(11,6,2,'1990-02-23 05:16:15'),(11,9,3,'1989-03-03 07:49:54');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests_types`
--

DROP TABLE IF EXISTS `friend_requests_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests_types`
--

LOCK TABLES `friend_requests_types` WRITE;
/*!40000 ALTER TABLE `friend_requests_types` DISABLE KEYS */;
INSERT INTO `friend_requests_types` VALUES (1,'accepted'),(2,'declined'),(3,'unfriended');
/*!40000 ALTER TABLE `friend_requests_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `media_types_id` int unsigned NOT NULL,
  `file_name` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '/files/folder/img.png',
  `file_size` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_media_media_types_idx` (`media_types_id`),
  KEY `fk_media_users_idx` (`user_id`),
  CONSTRAINT `fk_media_media_types` FOREIGN KEY (`media_types_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `fk_media_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'reiciendis.jpg',576223050,'1989-03-31 07:18:50'),(2,2,2,'et.avi',65802451,'1974-05-06 21:24:27'),(3,3,3,'autem.mp3',0,'1973-02-13 16:12:19'),(4,4,4,'aut.docx',2034150,'2001-04-19 08:51:36'),(5,5,1,'hic.png',0,'1978-09-18 00:12:30'),(6,6,2,'dolores.mp4',7,'1973-11-18 05:02:09'),(7,7,3,'veritatis.mp3',8638,'2001-03-15 01:22:43'),(8,8,4,'sit.odt',364003,'2001-07-10 17:06:48'),(9,9,1,'officiis.png',2466,'1994-09-18 15:39:07'),(10,10,2,'error.avi',0,'1982-10-08 11:48:23'),(11,11,3,'sed.mp3',1,'1990-03-13 23:25:50'),(12,1,1,'quos.png',1,'1993-03-06 04:59:36'),(13,2,1,'et.jpg',6,'1995-08-12 07:38:41'),(14,3,2,'labore.avi',746145073,'1991-04-04 00:25:47'),(15,4,3,'aut.mp3',52058493,'2003-08-15 15:16:32'),(16,5,4,'voluptatum.odt',6,'2001-01-25 06:12:55'),(17,6,1,'est.jpg',577582207,'1999-08-04 15:18:49'),(18,7,2,'beatae.avi',1116422,'1995-10-04 06:38:51'),(19,8,3,'quam.mp3',388361,'1986-01-28 06:34:28'),(20,9,4,'blanditiis.doc',572905,'2011-07-05 02:07:16'),(21,10,1,'commodi.png',573,'2016-02-21 20:54:22'),(22,11,2,'modi.mp3',1,'1993-10-25 02:54:33'),(23,1,1,'cumque.jpg',86254,'1986-05-31 16:45:06'),(24,1,1,'similique.png',7,'1980-04-03 05:29:37'),(25,1,1,'possimus.png',156,'2008-08-16 18:28:00'),(26,2,2,'ex.avi',2128941,'1979-08-02 12:34:03'),(27,3,3,'aut.mp3',90,'1999-09-11 17:51:07'),(28,3,3,'ratione.mp3',507,'2003-03-25 09:28:50'),(29,6,1,'vel.png',789367827,'2005-01-17 00:04:50'),(30,7,2,'et.mp4',689,'2011-09-14 18:49:24');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'image'),(2,'video'),(3,'music'),(4,'document');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `txt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delivered` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_messages_from_user_idx` (`from_user_id`),
  KEY `fk_messages_to_user_idx` (`to_user_id`),
  CONSTRAINT `fk_messages_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_messages_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,2,'Recusandae rem dolorum est corporis et. Dicta ad nobis necessitatibus odio. Suscipit et sint id id.',1,'2011-03-13 10:08:55','2021-03-21 02:35:53'),(2,1,2,'Similique pariatur dolorem quisquam. Sed dolores voluptas quia eaque blanditiis molestiae. Fuga quo nulla et magnam.',1,'2015-10-03 02:45:38','2021-03-21 02:35:53'),(3,2,1,'Deserunt dicta soluta corporis vero id rerum placeat. Qui corrupti repudiandae et explicabo. Est velit quibusdam labore unde omnis mollitia.',1,'1994-08-01 13:15:13','2021-03-21 02:35:53'),(4,2,1,'Fuga aut ut ea quis. Officiis rerum eaque eos nobis aperiam et voluptatem est.',1,'1997-01-09 05:09:47','2021-03-21 02:35:53'),(5,2,1,'Blanditiis impedit temporibus est veniam. Nisi omnis eaque similique autem distinctio. Enim voluptatem quas fugit quas sint quis.',0,'2016-03-23 20:14:26','2021-03-21 02:35:53'),(6,1,5,'Autem nihil sed velit voluptas tempora. Et aut inventore qui molestiae. Soluta sed saepe et vitae repellendus nobis.',1,'1983-07-16 00:04:12','1985-12-29 11:05:50'),(7,1,5,'Ratione qui minima facere laborum pariatur veritatis inventore nulla. Quaerat mollitia non autem. Delectus tempora reprehenderit autem saepe. Est ducimus voluptatem sit aliquam nisi earum sapiente.',0,'2010-05-13 21:00:14','2021-03-21 02:35:53'),(8,6,1,'Rerum temporibus maxime consequatur facilis sunt voluptatem. Ducimus voluptates officiis nulla consequatur. Non dolor rerum minima ut expedita est molestiae. Sapiente eos quo natus.',0,'2001-04-01 13:52:08','2021-03-21 02:35:53'),(9,6,1,'Ullam recusandae est qui ad. Quo exercitationem dolorem eaque doloremque dolorem nam voluptatem dolore. Molestiae iure ut eveniet perspiciatis minima voluptatem dignissimos et.',0,'2001-12-20 21:37:33','2021-03-21 02:35:53'),(10,2,5,'Esse eaque natus id. Velit quis sed dignissimos corporis dolores eligendi ea. Libero eum inventore vel ducimus reiciendis a natus. Magnam assumenda ratione et aut voluptate.',1,'1973-08-10 05:45:24','1974-06-23 13:40:40'),(11,2,5,'Ut dolorem qui voluptatibus a cupiditate sapiente est. Nisi dolor quaerat sunt aut amet. Quae officia atque est distinctio itaque temporibus harum illum.',1,'2008-10-29 12:56:46','2021-03-21 02:35:53'),(12,5,2,'Maiores quia ab suscipit eligendi vel. Maxime laudantium nostrum temporibus. Dolorum voluptatem cupiditate blanditiis. Quisquam laudantium possimus iste occaecati eum cupiditate quas.',0,'2008-11-10 13:49:48','2021-03-21 02:35:53'),(13,3,4,'Inventore quibusdam officiis eligendi dolor qui non. Et est ad tenetur eaque explicabo.',1,'1988-02-24 19:48:34','2021-03-21 02:35:53'),(14,4,3,'Aliquam rerum nesciunt dolores amet et repellat. Perspiciatis modi sunt in magnam vel voluptatem. Reprehenderit expedita laboriosam molestiae incidunt aperiam sequi.',1,'2008-02-11 10:58:02','2021-03-21 02:35:53'),(15,4,3,'Sed non provident cupiditate est eos repudiandae omnis. Soluta magnam velit minus sint asperiores. Nihil omnis quam et ratione inventore. Ut necessitatibus aliquid ipsa et eum sunt id.',1,'1995-10-04 00:00:36','2021-03-21 02:35:53'),(16,3,4,'Non quam assumenda non omnis velit ratione quis. Occaecati excepturi nam labore impedit et. Ab maxime qui blanditiis sint. Optio porro quidem occaecati error voluptatibus officiis architecto.',1,'1985-03-15 21:38:57','2021-03-21 02:35:53'),(17,4,3,'Asperiores velit omnis incidunt consequuntur quidem repellat. Rerum velit fuga nulla animi est. Labore accusantium nobis quia adipisci hic qui optio. Quis sed aut numquam assumenda iusto ipsam rem.',1,'1989-10-05 23:23:37','1991-03-23 20:34:49'),(18,3,4,'Ea molestiae voluptas nulla rerum. Molestias mollitia nam unde magnam est temporibus nulla. Aut sit sed odio. Culpa quia ut consequuntur aperiam quae consequatur quia.',1,'2016-03-20 11:17:31','2021-03-21 02:35:53'),(19,4,3,'Voluptas nihil earum eum quis deleniti optio. Adipisci rem cum nemo veniam. Ullam ullam asperiores molestias. Eligendi tempore repellat laudantium minus quae.',1,'1984-10-02 17:22:15','2012-07-22 06:46:40'),(20,1,10,'Laboriosam id excepturi dolorem quis eaque in quaerat. Et architecto blanditiis voluptas minus. Eligendi non dolorum assumenda nemo error. Maiores quo omnis atque explicabo quia cupiditate culpa.',0,'1980-03-16 21:31:44','2019-05-03 13:55:53'),(21,9,1,'Et laboriosam itaque porro architecto perferendis quam quam maiores. Ratione quibusdam expedita voluptatum aliquam tempore. Suscipit aut ea qui.',0,'1976-06-13 07:49:17','2021-03-21 02:35:53'),(22,3,6,'Beatae est optio in quis debitis. Quia ut voluptas quia fugit. Dolores est sit dolorum maiores.',1,'1981-07-28 11:20:01','2003-04-01 22:02:51'),(23,6,3,'Magni et corporis unde officiis ab. Aut eaque qui velit facere optio eaque. Harum excepturi praesentium sit veniam.',0,'2007-08-31 18:44:40','2021-03-21 02:35:53'),(24,3,6,'Reiciendis nisi vero nisi omnis sit sapiente reiciendis quis. Tenetur exercitationem ut numquam. Nobis animi aut blanditiis reprehenderit amet. Molestias qui praesentium quae sit et voluptatem.',0,'2020-10-02 23:27:12','2021-03-21 02:35:53'),(25,4,10,'Accusamus reiciendis nesciunt temporibus aut. Nesciunt veniam odit numquam at illo voluptatem reiciendis velit. Et et eum occaecati.',1,'2007-09-17 02:46:27','2021-03-21 02:35:53'),(26,10,4,'Fugit aut ipsa nihil laboriosam optio quibusdam architecto. Tempora corrupti et et. Rerum placeat quis ut quia illo et non debitis. In sint odio non et velit cumque.',0,'2006-04-04 10:27:03','2021-03-21 02:35:53'),(27,10,4,'Dolor tenetur sit nisi unde rerum. Aliquid ipsam totam aliquid ut architecto magnam qui. Itaque alias possimus ullam.',0,'2012-12-03 19:30:42','2021-03-21 02:35:53'),(28,10,4,'Saepe laborum est quam eveniet eveniet voluptates. Nulla dolor eum labore dignissimos perspiciatis. Doloremque doloremque sed error laboriosam architecto mollitia nemo.',1,'1978-11-07 10:06:15','2021-01-24 04:19:09'),(29,5,7,'Qui est magni autem delectus aliquam inventore aut eius. Eos qui quia sint labore nesciunt sit.\nBeatae sed qui delectus odio nam. Iure in cumque et ratione. Similique consequatur esse vitae et.',1,'1994-06-25 01:40:59','2021-03-21 02:35:53'),(30,5,6,'Quibusdam qui reprehenderit vel sequi natus ut. Sunt modi quasi aperiam et iste sunt minima. Est qui et quae magnam.',0,'2004-10-18 18:01:01','2021-03-21 02:35:53'),(31,5,8,'Quis a ipsa est aspernatur velit necessitatibus amet. Nobis perferendis inventore et est repudiandae quo officia. Possimus libero a error cupiditate incidunt et.',0,'1998-12-19 13:53:29','2021-03-21 02:35:53'),(32,6,11,'Voluptatem perferendis consequatur illum exercitationem excepturi dolor corporis voluptas. Neque sapiente nulla in non ex voluptatem libero. Similique id in unde aut enim.',1,'2009-09-25 00:49:18','2021-03-21 02:35:53'),(33,11,6,'Ea non eligendi consectetur hic quia aut. Ut et et excepturi ut. Repellendus blanditiis sequi ut commodi.',1,'2017-03-20 07:44:23','2021-03-21 02:35:53'),(34,6,11,'Ex ut velit ex ut. Sunt dolorem blanditiis minus a necessitatibus eos rerum. Eos cumque ut soluta.',1,'1996-02-11 01:37:41','2021-03-21 02:35:53'),(35,11,6,'Esse asperiores ducimus recusandae. Corporis repudiandae amet in suscipit velit quia. Necessitatibus nulla esse dolores voluptas minima numquam.',1,'2008-08-26 10:41:05','2021-03-21 02:35:53'),(36,11,6,'Quos molestiae quia repudiandae et temporibus. Necessitatibus nesciunt qui asperiores et. Ut voluptatum nulla recusandae error a. Quidem sed saepe nisi unde at consectetur sit.',1,'1986-04-19 19:28:52','2021-03-21 02:35:53'),(37,7,9,'Quia quo molestiae odio. Minus veritatis ut sed nihil. Qui pariatur eveniet optio in molestiae velit. Aut libero laboriosam ab illo optio.',0,'1983-04-18 02:33:57','2021-03-21 02:35:53'),(38,8,10,'Doloremque quod doloremque velit. Assumenda perferendis corrupti quas inventore veniam. Id cum impedit vel.',1,'1972-06-18 17:10:12','2021-03-21 02:35:53'),(39,8,11,'Natus ea maiores non omnis. Quis expedita sit delectus sequi veritatis accusantium alias. Dolores voluptatum quas sint et saepe cupiditate quod quasi. Ut et doloribus reprehenderit qui.',1,'1972-03-10 00:03:24','2021-03-21 02:35:53'),(40,8,11,'Inventore itaque amet eveniet a nesciunt nobis error. Illo nostrum cupiditate eum odio nihil id. Consequatur quo et sed itaque. Sunt ipsam hic nisi aut aut fugit sunt qui.',1,'2019-09-20 18:28:30','2021-03-21 02:35:53'),(41,8,11,'Corrupti porro ut doloremque et vero. Sed reiciendis dignissimos rerum voluptas quo libero. Aliquam dolorem sit est dolor sunt quisquam quidem.',1,'1970-05-28 15:28:05','2021-03-21 02:35:53'),(42,8,11,'Eum ea porro vitae repellat sapiente. Fuga sunt enim accusamus laborum veniam. Natus iure est aut.',1,'1999-04-05 10:19:02','2021-03-21 02:35:53'),(43,9,11,'Ipsam officia iure veritatis hic eos. Nulla nemo aut itaque. Consequuntur dolorum et deleniti ut. Est fugiat qui perspiciatis modi ad vero.',1,'1981-03-06 16:21:04','2018-09-04 02:47:59'),(44,9,11,'Ipsam tempore minima soluta mollitia. Et illum esse facilis sunt culpa qui consequatur. Rerum ab impedit debitis necessitatibus quis.',1,'2005-04-24 20:43:47','2021-03-21 02:35:53'),(45,11,9,'Officiis ea tempora maiores perspiciatis eveniet repellat. Iste quia qui sit velit accusamus ipsa. Amet delectus tempora quod sunt. Voluptas porro magnam unde sed dolorem.',1,'2013-06-29 16:18:56','2016-02-03 05:02:12'),(46,11,9,'Quia laborum voluptatum vitae minus ullam harum dolores. Voluptates voluptas adipisci inventore quasi et. Quae aliquam blanditiis aliquam est atque possimus ut. Ut non magni aut dolorem quam dolores.',1,'2019-01-27 13:28:44','2021-03-21 02:35:53'),(47,11,9,'Minima deleniti nihil alias totam ratione vero. Nihil quae dolor libero beatae enim autem. Repellendus et eligendi vel libero aliquid deserunt officia.',1,'1979-11-21 15:43:46','2021-03-21 02:35:53'),(48,9,11,'Sit voluptatibus optio quo aliquid quas perspiciatis. Et deserunt atque nemo beatae a. Quod fuga numquam ratione sit explicabo.',1,'1976-08-05 21:54:35','2021-03-21 02:35:53'),(49,11,9,'Optio ratione qui qui voluptates eos commodi. Laudantium odit ut porro ut occaecati earum. Sed quo magnam repellat aliquam inventore.',0,'2019-07-24 19:49:58','2021-03-21 02:35:53'),(50,10,11,'Autem non omnis et. Amet voluptas voluptas rerum. Aut officia sunt quidem culpa.',1,'2009-12-01 13:16:23','2021-03-21 02:35:53');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `txt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `user_posts_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'Et sit maxime rerum quisquam alias rerum. Quos laborum accusamus vitae vel sapiente et ut aperiam. Unde occaecati inventore vitae eos laborum qui. Itaque enim voluptates praesentium et aut quia.','1973-08-20 21:00:56','2007-03-19 09:11:05'),(2,1,'Praesentium delectus temporibus et quia porro et. Sunt quibusdam et et nisi sint. Et sunt rerum alias est velit nesciunt nam sed. Eos cupiditate qui aut maiores cupiditate pariatur.','1972-03-20 11:39:32','2008-10-16 13:37:06'),(3,1,'Velit numquam ducimus autem perferendis. Necessitatibus dolorum consequatur assumenda. Atque at atque vel aut maiores omnis perspiciatis. Repellendus dolorem totam adipisci.','1976-01-29 14:58:51','2015-06-12 13:58:27'),(4,1,'Aut qui ipsa doloribus voluptate dolores consequatur. Nemo temporibus eos excepturi dolor qui vitae sint. Ut nostrum dolor minus veritatis.','2012-07-31 23:40:55',NULL),(5,1,'Eius adipisci rerum mollitia ipsum. Voluptatem mollitia suscipit ut libero porro et voluptatem. Omnis placeat cupiditate ipsum aspernatur.','1986-02-17 11:47:44',NULL),(6,2,'Sunt quod accusantium qui a at. Eos magnam quibusdam laudantium fugiat sit porro. Cum voluptas et sunt voluptas. Animi quasi maxime occaecati est quis.','1996-03-29 05:11:10','2006-09-12 10:55:18'),(7,5,'Sit quod ea eligendi officia eos. Recusandae placeat eos qui eum. Quia magni aperiam sit consequatur autem.','2020-08-21 16:01:10',NULL),(8,5,'Debitis ad quas provident nemo. Eligendi repellendus eaque tempora incidunt perferendis. Ipsam libero nostrum sit autem numquam dolore vel. Iste dolore unde sint sed iusto error.','2005-10-17 03:38:20',NULL),(9,5,'Temporibus dolor numquam qui aut et ut. Minima et numquam labore. Ut adipisci molestiae totam nihil accusantium occaecati incidunt.','1974-10-04 22:33:22',NULL),(10,5,'Quaerat aspernatur ipsa nihil eius sapiente explicabo. Nemo ut minima architecto officia sed. Saepe quam deserunt illo.','2002-05-18 14:46:58',NULL),(11,6,'Quaerat consequatur veniam consequuntur tempora. Est exercitationem quibusdam laborum ut. Qui porro maiores nam error cum quam beatae. Adipisci laudantium et quas quas.','2020-05-23 15:38:58',NULL),(12,6,'Ut quos repellendus iste dolore rerum. Nam est et saepe consequatur debitis et quia. Dolore eos amet autem fugiat.','2011-11-17 06:44:47',NULL),(13,8,'Illo dolore magni aut vero. Iusto corporis iste sed quo. Magnam incidunt eaque neque ullam facere voluptas ea.','1999-03-04 07:00:36',NULL),(14,10,'Praesentium iure et ducimus fugit illum repellat. Illum voluptatem dolorum maiores. Nesciunt sint perferendis eveniet possimus facere.','1988-04-09 18:30:16',NULL),(15,10,'Vel dolores rerum earum id et quo qui. Ipsam voluptatem accusantium molestiae et est et. Ipsum qui ut magni qui. Exercitationem earum occaecati illo exercitationem qui nesciunt atque.','2004-11-12 03:38:28',NULL),(16,10,'Fuga corrupti quis ipsa ea est odio. Id dolores doloremque eum neque vero molestias.','1994-11-18 15:26:01','1988-04-22 07:47:40'),(17,11,'Quidem ipsa est reiciendis voluptatibus numquam sint. Odit aut rerum natus praesentium. Doloribus architecto amet dolor distinctio sed.','2006-03-22 17:45:21',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_likes`
--

DROP TABLE IF EXISTS `posts_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_likes` (
  `post_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `like_type` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_idx` (`post_id`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `posts_likes_fk` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `users_likes_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_likes`
--

LOCK TABLES `posts_likes` WRITE;
/*!40000 ALTER TABLE `posts_likes` DISABLE KEYS */;
INSERT INTO `posts_likes` VALUES (1,1,0),(1,2,1),(1,3,1),(1,4,1),(1,6,1),(1,9,1),(1,10,1),(1,11,1),(2,2,1),(2,3,0),(3,2,1),(3,3,0),(3,4,1),(3,8,1),(3,11,1),(4,1,0),(4,3,1),(4,7,1),(4,8,0),(4,9,1),(4,10,1),(5,2,0),(5,5,0),(5,6,1),(5,10,1),(5,11,1),(6,2,1),(7,3,1),(8,1,0),(8,2,0),(8,3,1),(8,4,1),(8,5,1),(8,6,0),(8,7,1),(9,5,0),(9,8,1),(9,10,0),(9,11,0),(11,1,1),(11,2,1),(11,3,1),(11,4,0),(11,6,1),(11,8,1),(12,5,1),(13,2,1),(13,3,1),(13,4,0),(13,5,1),(13,6,1),(13,8,1),(15,11,1),(16,1,1),(16,2,1),(16,3,1),(16,4,1),(16,5,1),(16,6,1),(16,7,0),(16,9,1),(16,11,1),(17,5,1),(17,6,1),(17,11,0);
/*!40000 ALTER TABLE `posts_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL,
  `gender` enum('f','m','x') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `user_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(130) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(130) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `profiles_photo_fk` (`photo_id`),
  CONSTRAINT `fk_profiles_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `profiles_photo_fk` FOREIGN KEY (`photo_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'m','1989-04-09',1,'Magni repellat sunt consequatu','Hamillfurt','Austria'),(2,'x','1991-11-11',13,'Minus assumenda at et doloribu','Westburgh','Austria'),(3,'f','2000-10-01',NULL,'Maiores nihil dolore voluptate','Camilahaven','Russia'),(4,'f','1977-12-18',NULL,'Nulla ut distinctio commodi ma','Osinskibury','USA'),(5,'f','1985-10-14',5,'Quae omnis fugiat soluta solut','Raphaellestad','USA'),(6,'x','2006-12-02',17,'Voluptates aliquam et mollitia','Hansenburgh','USA'),(7,'x','2014-12-27',NULL,'Inventore voluptatem reiciendi','Jessycamouth','Russia'),(8,'x','1970-04-06',NULL,'Quia corporis ut maxime reicie','East Carrieborough','Canada'),(9,'x','2020-02-28',9,'Repellendus id occaecati error','Anabellestad','Canada'),(10,'m','1992-01-27',21,'Delectus qui non sed rerum cum','Port Charity','Germany'),(11,'x','2002-04-29',NULL,'Perspiciatis quos voluptates e','West Lenniemouth','France');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` char(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`),
  UNIQUE KEY `phone_unique` (`phone`),
  CONSTRAINT `phone_check` CHECK (((length(`phone`) = 11) and (not((`phone` like _utf8mb4'%[^0-9]%')))))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Guadalupe','Nitzsche','greenfelder.antwan@example.org','89213456678','d6f684fe75bdff654841d18f34c9acd6d3b05233','2011-12-04 16:57:02'),(2,'Elmira','Bayer','xjacobs@example.org','89214507878','501a9b34edb153894128f6255ff3ef6bf0d3f4db','1990-01-20 18:48:26'),(3,'D\'angelo','Cruickshank','linwood.medhurst@example.org','89214567878','3273c607f8dfbc808adaa5493b7439ba08c3f43e','1994-09-04 15:21:06'),(4,'Princess','Runolfsson','huel.nash@example.org','89213455643','21444980cef626302f7ae9a507971889c9daac1d','1987-08-27 19:05:04'),(5,'Ethan','Legros','mhickle@example.org','89219567878','4dd91825495d2233602c0b0af6ff8b113b1844d9','1993-01-08 23:58:41'),(6,'Freda','Sporer','devyn70@example.net','89213457870','3df01bfd0a99988ca0383a49481e523226d4adca','1997-11-10 19:45:09'),(7,'Bonnie','Prosacco','hester.marvin@example.com','89213332222','10db70a3dcce2a22dd8eabdc7342260c91ff1749','1982-09-30 14:12:03'),(8,'Sierra','Bruen','aprosacco@example.net','89212222334','99fbaa12eecf0e10bf372dbf9cf7f98267b6636e','2004-01-28 04:41:46'),(9,'Trudie','Heller','hjohnston@example.net','89213336675','33b1681186add7816a701f570615c9d0aae215ab','1999-06-10 12:49:14'),(10,'Shaylee','Sawayn','pagac.clarissa@example.org','89212233456','b1771cc64742c38ec18ac67a4e61597b05cc9e20','1973-12-14 01:24:44'),(11,'Demarco','Eichmann','lakin.ethel@example.org','89233388787','f7f50eddf4d112d2d858510211128b8e0de60f84','2006-02-22 14:32:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 19:56:18

/* Задание №1.
	Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал пользователю наибольшее число сообщений.  */

-- Возьмём первого пользователя (id=1) и посмотрим кто с ним общался

SELECT * FROM messages WHERE to_user_id = 1;

-- Соберём более наглядную таблицу с отправителями и количеством их сообщений

SELECT DISTINCT from_user_id AS sender_id,
		count(*) AS count_of_messages FROM messages WHERE to_user_id =1 GROUP BY from_user_id;

-- Выводим самого общительного пользователя (лимит)

SELECT DISTINCT from_user_id AS max_sender_id,
		count(*) AS count_of_messages FROM messages WHERE to_user_id =1 GROUP BY from_user_id LIMIT 1;

	
/* Задание №2.
	Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.  */	

-- Выведем профили 18-летних пользователей
	
SELECT user_id FROM profiles WHERE YEAR(curdate()) - YEAR(birthday) < 18;

-- Выведем id_посты и добавим ограничение по возрасту подзапросом

SELECT * FROM posts;

SELECT id FROM posts 
	WHERE user_id IN (SELECT user_id FROM profiles 
								WHERE YEAR(curdate()) - YEAR(birthday) < 18);

-- Подсчёт общего количества лайков через запрос таблицы пост_лайк и подзапроса

SELECT count(*) FROM posts_likes
	WHERE post_id IN (SELECT id FROM posts 
							WHERE user_id IN (SELECT user_id FROM profiles
														WHERE YEAR(curdate()) - YEAR(birthday) < 18));

													
/* Задание №3.
	 Определить, кто больше поставил лайков (всего) - мужчины или женщины?  */	
																							
	
SELECT gender FROM profiles; -- таблица гендеров пользователей

SELECT user_id FROM posts_likes; -- таблица ставивших лайки пользователей

-- Сделаем внутренний запрос, ссылаясь на внешнюю таблицу (иначе работать не будет)

-- Создаём таблицу пост_лайков с заменой id на гендер

SELECT (SELECT gender FROM profiles WHERE user_id = posts_likes.user_id)
	FROM posts_likes;

-- Далее добавляем наши условия для подсчёта общего числа лайков от гендеров

SELECT 
	 (SELECT gender FROM profiles WHERE user_id = posts_likes.user_id) AS gender,
	 COUNT(*) AS total FROM posts_likes
				WHERE like_type = 1 GROUP BY gender;

-- Выведем самых лайкающих (лимит)
	
SELECT 
	 (SELECT gender FROM profiles WHERE user_id = posts_likes.user_id) AS gender,
	 COUNT(*) AS total FROM posts_likes
				WHERE like_type = 1 GROUP BY gender LIMIT 1;	
	
	
/* Задание №4.
	 Найти пользователя, который проявляет наименьшую активность в использовании социальной сети.  */		

-- Будем измерять активность в отправленных сообщениях (можно выбрать и другие меры)

SELECT from_user_id FROM messages; -- сообщения от пользователя

SELECT id FROM users; -- общее количество пользователей

-- Совместим подзапросом количество сообщений от конкретного пользователя, ссылаясь на внешнюю таблицу

SELECT (SELECT count(*) FROM messages WHERE messages.from_user_id = users.id) FROM users;
			
-- Преобразуем результат к подведению самого необщительного человека с выводом его личности

SELECT 
   concat(first_name, ' ', last_name) AS user, 
  (SELECT count(*) FROM messages WHERE messages.from_user_id = users.id) AS count_of_messages
FROM users
ORDER BY count_of_messages 
LIMIT 1;

			
			
			
			
	
	