-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.7.5-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных aggregator
CREATE DATABASE IF NOT EXISTS `aggregator` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `aggregator`;

-- Дамп структуры для таблица aggregator.adress
CREATE TABLE IF NOT EXISTS `adress` (
  `adress_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `adress_type_id` int(11) DEFAULT NULL,
  `subject_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `city_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `street_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `house_number` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(250) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`adress_id`),
  KEY `Индекс 3` (`organization_id`,`adress_type_id`),
  KEY `adress_type_id` (`adress_type_id`),
  CONSTRAINT `adress_ibfk_1` FOREIGN KEY (`adress_type_id`) REFERENCES `adress_type` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.adress: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.adress_type
CREATE TABLE IF NOT EXISTS `adress_type` (
  `adress_type_id` int(11) NOT NULL,
  `adress_type_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`adress_type_id`) USING BTREE,
  CONSTRAINT `adress` FOREIGN KEY (`adress_type_id`) REFERENCES `adress` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.adress_type: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.aggregator_specialist
CREATE TABLE IF NOT EXISTS `aggregator_specialist` (
  `aggregator_specialist_id` int(11) NOT NULL,
  `aggregator_specialist_surname` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `aggregator_specialist_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `aggregator_specialist_patronymic` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `aggregator_specialist_department` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `aggregator_specialist_position` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `aggregator_specialist_phone_number` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.aggregator_specialist: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.aggregator_specialist_connector_request
CREATE TABLE IF NOT EXISTS `aggregator_specialist_connector_request` (
  `aggregator_specialist_connector_request_id` int(11) NOT NULL,
  `aggregator_specialist_id` int(11) DEFAULT NULL,
  `connection_request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_connector_request_id`),
  KEY `Индекс 2` (`aggregator_specialist_id`,`connection_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.aggregator_specialist_connector_request: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.connection_request
CREATE TABLE IF NOT EXISTS `connection_request` (
  `connection_request_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `reg_number` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `date_begin` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `status` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`connection_request_id`),
  KEY `Индекс 2` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.connection_request: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_surname` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `customer_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `customer_patronymic` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `customer_phone_number` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.customer: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.organization
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_full_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `organization_short_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `inn` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `kpp` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `ogrn` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `responsible_person_surname` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `responsible_person_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `responsible_person_patronymic` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `responsible_person_email` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `responsible_person_phone_number` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `profile_image` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.organization: ~1 rows (приблизительно)
INSERT INTO `organization` (`organization_id`, `organization_full_name`, `organization_short_name`, `inn`, `kpp`, `ogrn`, `responsible_person_surname`, `responsible_person_name`, `responsible_person_patronymic`, `responsible_person_email`, `responsible_person_phone_number`, `add_info`, `profile_image`) VALUES
	(8, 'ANIME', NULL, '3434343241', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'dark.jpg');

-- Дамп структуры для таблица aggregator.registrations
CREATE TABLE IF NOT EXISTS `registrations` (
  `registrations_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` tinytext CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL,
  `password` char(100) CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL,
  PRIMARY KEY (`registrations_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.registrations: ~7 rows (приблизительно)
INSERT INTO `registrations` (`registrations_id`, `email`, `password`) VALUES
	(1, 'dima', '$2b$10$Qn3okIvJQJ39.1yGAfHd3u4AOuDUABJvSbVf147vg8/TOmLkI5R7K'),
	(2, 'dimasik', '$2b$10$rWotJCGd8PFZGlAG3xCNXuEgz/eDAVOVFXjFFt.ep2CYGUgwNfkC2'),
	(3, 'test', '$2b$10$8XVNgAv9.joAzX39SlWwDOM2YkAoOvDbm34Yg/gOkqK6J0IdF1CwC'),
	(4, 'vadya', '$2b$10$f9pJik93exAtQX7uOW.NNe.nWVhJl67e8W5G4rroAgx/MS2/gEOoa'),
	(5, 'new', '$2b$10$jIFaYdFmvnM6La2esOVAtOlpgtQrLzdSUil8oeHZof8m0BGkawPjy'),
	(6, 'root', '$2b$10$BuqRHekHLwip6SFujybAGeSJPUogaYVgqVhFp8dMzirFVS4ikyHcy'),
	(8, 'test12@mail.ru', '$2b$10$H/K8s9MWjeU15lVqWNz68eoaIj6lWi8HJMgZ8IiVpAz91oiL917jC');

-- Дамп структуры для таблица aggregator.service_detail
CREATE TABLE IF NOT EXISTS `service_detail` (
  `service_detail_id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `service_detail_code` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `service_detail_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `service_detail_cost` int(11) DEFAULT NULL,
  `service_detail_duration` int(11) DEFAULT NULL,
  `add_info` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`service_detail_id`),
  KEY `Индекс 2` (`type_id`),
  CONSTRAINT `service_detail_ibfk_1` FOREIGN KEY (`service_detail_id`) REFERENCES `type_of_service` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.service_detail: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.service_request
CREATE TABLE IF NOT EXISTS `service_request` (
  `service_request_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `date_service` datetime DEFAULT NULL,
  `add_info_char` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`service_request_id`),
  KEY `Индекс 2` (`customer_id`,`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.service_request: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.service_request_detail
CREATE TABLE IF NOT EXISTS `service_request_detail` (
  `service_request_detail_id` int(11) NOT NULL,
  `service_request_id` int(11) DEFAULT NULL,
  `service_detail_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`service_request_detail_id`),
  KEY `Индекс 2` (`service_request_id`,`service_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.service_request_detail: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.type_of_service
CREATE TABLE IF NOT EXISTS `type_of_service` (
  `type_id` int(11) NOT NULL,
  `type_code` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `type_name` char(50) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.type_of_service: ~0 rows (приблизительно)

-- Дамп структуры для таблица aggregator.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `name` text CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы aggregator.users: ~2 rows (приблизительно)
INSERT INTO `users` (`id`, `name`, `age`) VALUES
	(1, 'dimka', 20),
	(2, 'ivan', 11);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
