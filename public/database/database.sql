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
  `subject_name` char(50) DEFAULT NULL,
  `city_name` char(50) DEFAULT NULL,
  `street_name` char(50) DEFAULT NULL,
  `house_number` char(50) DEFAULT NULL,
  `add_info` char(250) DEFAULT NULL,
  PRIMARY KEY (`adress_id`),
  KEY `Индекс 3` (`organization_id`,`adress_type_id`),
  KEY `adress_type_id` (`adress_type_id`),
  CONSTRAINT `adress_ibfk_1` FOREIGN KEY (`adress_type_id`) REFERENCES `adress_type` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.adress: ~0 rows (приблизительно)
DELETE FROM `adress`;

-- Дамп структуры для таблица aggregator.adress_type
CREATE TABLE IF NOT EXISTS `adress_type` (
  `adress_type_id` int(11) NOT NULL,
  `adress_type_name` char(50) DEFAULT NULL,
  `add_info` char(50) DEFAULT NULL,
  PRIMARY KEY (`adress_type_id`) USING BTREE,
  CONSTRAINT `adress` FOREIGN KEY (`adress_type_id`) REFERENCES `adress` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.adress_type: ~0 rows (приблизительно)
DELETE FROM `adress_type`;

-- Дамп структуры для таблица aggregator.aggregator_specialist
CREATE TABLE IF NOT EXISTS `aggregator_specialist` (
  `aggregator_specialist_id` int(11) NOT NULL,
  `aggregator_specialist_surname` char(50) DEFAULT NULL,
  `aggregator_specialist_name` char(50) DEFAULT NULL,
  `aggregator_specialist_patronymic` char(50) DEFAULT NULL,
  `aggregator_specialist_department` char(50) DEFAULT NULL,
  `aggregator_specialist_position` char(50) DEFAULT NULL,
  `aggregator_specialist_phone_number` char(50) DEFAULT NULL,
  `add_info` char(50) DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.aggregator_specialist: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist`;

-- Дамп структуры для таблица aggregator.aggregator_specialist_connector_request
CREATE TABLE IF NOT EXISTS `aggregator_specialist_connector_request` (
  `aggregator_specialist_connector_request_id` int(11) NOT NULL,
  `aggregator_specialist_id` int(11) DEFAULT NULL,
  `connection_request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_connector_request_id`),
  KEY `Индекс 2` (`aggregator_specialist_id`,`connection_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.aggregator_specialist_connector_request: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist_connector_request`;

-- Дамп структуры для таблица aggregator.connection_request
CREATE TABLE IF NOT EXISTS `connection_request` (
  `connection_request_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `reg_number` char(50) DEFAULT NULL,
  `date_begin` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `status` char(50) DEFAULT NULL,
  `add_info` char(50) DEFAULT NULL,
  PRIMARY KEY (`connection_request_id`),
  KEY `Индекс 2` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.connection_request: ~0 rows (приблизительно)
DELETE FROM `connection_request`;

-- Дамп структуры для таблица aggregator.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` text DEFAULT NULL,
  `customer_surname` text DEFAULT NULL,
  `customer_patronymic` text DEFAULT NULL,
  `customer_phone_number` char(50) DEFAULT NULL,
  `customer_email` text DEFAULT NULL,
  `add_info` char(50) DEFAULT NULL,
  `profile_image` text DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.customer: ~0 rows (приблизительно)
DELETE FROM `customer`;

-- Дамп структуры для таблица aggregator.organization
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_full_name` text DEFAULT NULL,
  `organization_short_name` text DEFAULT NULL,
  `inn` text DEFAULT NULL,
  `kpp` text DEFAULT NULL,
  `ogrn` text DEFAULT NULL,
  `responsible_person_surname` text DEFAULT NULL,
  `responsible_person_name` text DEFAULT NULL,
  `responsible_person_patronymic` text DEFAULT NULL,
  `responsible_person_email` text DEFAULT NULL,
  `responsible_person_phone_number` text DEFAULT NULL,
  `add_info` text DEFAULT NULL,
  `profile_image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.organization: ~2 rows (приблизительно)
DELETE FROM `organization`;
INSERT INTO `organization` (`organization_id`, `organization_full_name`, `organization_short_name`, `inn`, `kpp`, `ogrn`, `responsible_person_surname`, `responsible_person_name`, `responsible_person_patronymic`, `responsible_person_email`, `responsible_person_phone_number`, `add_info`, `profile_image`) VALUES
	(18, 'Koka Ola', 'Koka Ola', '4444', '4444', '4444', 'Ola', 'Koka', 'Patronovna', 'kos@mail.ru', '+79277332638', 'Gena Na', 'IR.jpg'),
	(19, 'PSUTI', 'PSUTI', '7777', '7777', '7777', 'Osanov', 'Vladimir', 'Andreevich', 'osan20@mail.ru', '+79277335638', 'Gena Na', 'nigg.jpg'),
	(20, 'PSUTI TEHNICUM', 'PSUTI', '1234', '1234', '1234', 'Ozanov', 'Vladimir', 'Andreevich', 'ozan11@mail.ru', '+79543303456', 'descrption', 'Zoz0XqMDd4c.jpg');

-- Дамп структуры для таблица aggregator.registrations
CREATE TABLE IF NOT EXISTS `registrations` (
  `registrations_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` tinytext NOT NULL,
  `password` char(100) NOT NULL,
  `type` char(50) NOT NULL,
  PRIMARY KEY (`registrations_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.registrations: ~9 rows (приблизительно)
DELETE FROM `registrations`;
INSERT INTO `registrations` (`registrations_id`, `email`, `password`, `type`) VALUES
	(16, 'kosolapov10@list.ru', '$2b$10$V6UsPUTOF5.DCVfaPDoTKeYz33VMYKefnCfQbHxK/pCBdjEJHCCMO', ''),
	(17, 'schaminayuliana@gmail.com', '$2b$10$y3KUV5xTV2vOKlbCcfveU.d3CtPQ34cK1uscpyBEJy423TRqVucrm', 'ORG'),
	(18, 'kos@mail.ru', '$2b$10$rQGE4eaD8lbyQHSGrpWdSO1EESJMdEBrOtaNkM6xkWLQvbSGAy/.C', 'ADM'),
	(19, 'osan20@mail.ru', '$2b$10$jnxQx17.u9H90Gvidkl6DeWvvxoASPXB5xPEzp9pxQlORCZ0Hk512', 'ORG'),
	(20, 'ozan11@mail.ru', '$2b$10$byoHGGQx9uc0tbiSDM5w/upg8u5CUZPIbMi1R9o1wC.XXYEhgleAe', 'ORG');

-- Дамп структуры для таблица aggregator.service_detail
CREATE TABLE IF NOT EXISTS `service_detail` (
  `service_detail_id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `service_detail_code` char(50) DEFAULT NULL,
  `service_detail_name` char(50) DEFAULT NULL,
  `service_detail_cost` int(11) DEFAULT NULL,
  `service_detail_duration` int(11) DEFAULT NULL,
  `add_info` char(50) DEFAULT NULL,
  PRIMARY KEY (`service_detail_id`),
  KEY `Индекс 2` (`type_id`),
  CONSTRAINT `service_detail_ibfk_1` FOREIGN KEY (`service_detail_id`) REFERENCES `type_of_service` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.service_detail: ~0 rows (приблизительно)
DELETE FROM `service_detail`;

-- Дамп структуры для таблица aggregator.service_request
CREATE TABLE IF NOT EXISTS `service_request` (
  `service_request_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `date_service` datetime DEFAULT NULL,
  `add_info_char` char(50) DEFAULT NULL,
  PRIMARY KEY (`service_request_id`),
  KEY `Индекс 2` (`customer_id`,`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.service_request: ~0 rows (приблизительно)
DELETE FROM `service_request`;

-- Дамп структуры для таблица aggregator.service_request_detail
CREATE TABLE IF NOT EXISTS `service_request_detail` (
  `service_request_detail_id` int(11) NOT NULL,
  `service_request_id` int(11) DEFAULT NULL,
  `service_detail_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`service_request_detail_id`),
  KEY `Индекс 2` (`service_request_id`,`service_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.service_request_detail: ~0 rows (приблизительно)
DELETE FROM `service_request_detail`;

-- Дамп структуры для таблица aggregator.type_of_service
CREATE TABLE IF NOT EXISTS `type_of_service` (
  `type_id` int(11) NOT NULL,
  `type_code` char(50) DEFAULT NULL,
  `type_name` char(50) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8;

-- Дамп данных таблицы aggregator.type_of_service: ~0 rows (приблизительно)
DELETE FROM `type_of_service`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
