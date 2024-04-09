-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.30 - MySQL Community Server - GPL
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
CREATE DATABASE IF NOT EXISTS `aggregator` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aggregator`;

-- Дамп структуры для таблица aggregator.adress
CREATE TABLE IF NOT EXISTS `adress` (
  `adress_id` int NOT NULL,
  `organization_id` int DEFAULT NULL,
  `adress_type_id` int DEFAULT NULL,
  `subject_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `street_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `house_number` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `add_info` char(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`adress_id`),
  KEY `Индекс 3` (`organization_id`,`adress_type_id`),
  KEY `adress_type_id` (`adress_type_id`),
  CONSTRAINT `adress_ibfk_1` FOREIGN KEY (`adress_type_id`) REFERENCES `adress_type` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.adress: ~0 rows (приблизительно)
DELETE FROM `adress`;

-- Дамп структуры для таблица aggregator.adress_type
CREATE TABLE IF NOT EXISTS `adress_type` (
  `adress_type_id` int NOT NULL,
  `adress_type_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `add_info` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`adress_type_id`) USING BTREE,
  CONSTRAINT `adress` FOREIGN KEY (`adress_type_id`) REFERENCES `adress` (`adress_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.adress_type: ~0 rows (приблизительно)
DELETE FROM `adress_type`;

-- Дамп структуры для таблица aggregator.aggregator_specialist
CREATE TABLE IF NOT EXISTS `aggregator_specialist` (
  `aggregator_specialist_id` int NOT NULL,
  `aggregator_specialist_surname` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aggregator_specialist_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aggregator_specialist_patronymic` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aggregator_specialist_department` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aggregator_specialist_position` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aggregator_specialist_phone_number` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `add_info` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.aggregator_specialist: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist`;

-- Дамп структуры для таблица aggregator.aggregator_specialist_connector_request
CREATE TABLE IF NOT EXISTS `aggregator_specialist_connector_request` (
  `aggregator_specialist_connector_request_id` int NOT NULL,
  `aggregator_specialist_id` int DEFAULT NULL,
  `connection_request_id` int DEFAULT NULL,
  PRIMARY KEY (`aggregator_specialist_connector_request_id`),
  KEY `Индекс 2` (`aggregator_specialist_id`,`connection_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.aggregator_specialist_connector_request: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist_connector_request`;

-- Дамп структуры для таблица aggregator.connection_request
CREATE TABLE IF NOT EXISTS `connection_request` (
  `connection_request_id` int NOT NULL,
  `organization_id` int DEFAULT NULL,
  `reg_number` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_begin` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `status` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `add_info` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`connection_request_id`),
  KEY `Индекс 2` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.connection_request: ~0 rows (приблизительно)
DELETE FROM `connection_request`;

-- Дамп структуры для таблица aggregator.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` mediumtext COLLATE utf8mb4_general_ci,
  `customer_surname` mediumtext COLLATE utf8mb4_general_ci,
  `customer_patronymic` mediumtext COLLATE utf8mb4_general_ci,
  `customer_phone_number` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_email` mediumtext COLLATE utf8mb4_general_ci,
  `add_info` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_image` mediumtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.customer: ~1 rows (приблизительно)
DELETE FROM `customer`;
INSERT INTO `customer` (`customer_id`, `customer_name`, `customer_surname`, `customer_patronymic`, `customer_phone_number`, `customer_email`, `add_info`, `profile_image`) VALUES
	(1, 'Vadim', 'Шакиров', 'VVV', '86856732', 'oazesh@gmail.com', 'dascawwcsd', 'av.png');

-- Дамп структуры для таблица aggregator.organization
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` int NOT NULL AUTO_INCREMENT,
  `organization_full_name` mediumtext COLLATE utf8mb4_general_ci,
  `organization_short_name` mediumtext COLLATE utf8mb4_general_ci,
  `inn` mediumtext COLLATE utf8mb4_general_ci,
  `kpp` mediumtext COLLATE utf8mb4_general_ci,
  `ogrn` mediumtext COLLATE utf8mb4_general_ci,
  `responsible_person_surname` mediumtext COLLATE utf8mb4_general_ci,
  `responsible_person_name` mediumtext COLLATE utf8mb4_general_ci,
  `responsible_person_patronymic` mediumtext COLLATE utf8mb4_general_ci,
  `responsible_person_email` mediumtext COLLATE utf8mb4_general_ci,
  `responsible_person_phone_number` mediumtext COLLATE utf8mb4_general_ci,
  `add_info` mediumtext COLLATE utf8mb4_general_ci,
  `profile_image` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.organization: ~5 rows (приблизительно)
DELETE FROM `organization`;
INSERT INTO `organization` (`organization_id`, `organization_full_name`, `organization_short_name`, `inn`, `kpp`, `ogrn`, `responsible_person_surname`, `responsible_person_name`, `responsible_person_patronymic`, `responsible_person_email`, `responsible_person_phone_number`, `add_info`, `profile_image`) VALUES
	(18, 'СТО «Мотор»', 'Мотор', '4444', '4444', '4444', 'Савостьянов', 'Дмитрий', 'Юрьевич', 'kos@mail.ru', '+79277332638', 'Приветствуем вас в нашем автосервисе! Мы - команда опытных профессионалов, готовых решить любые проблемы вашего автомобиля. У нас вы найдете полный спектр услуг: от технического обслуживания до сложного ремонта. Мы специализируемся на работе с различными марками и моделями автомобилей, используем только качественные запчасти и оборудование. Наши мастера обладают высокой квалификацией и готовы помочь вам в любое время. Приходите к нам, и ваш автомобиль будет в надежных руках!', 'motor.jpg'),
	(19, 'СТО «Монолит»', 'Монолит', '7777', '7777', '7777', 'Osanov', 'Vladimir', 'Andreevich', 'osan20@mail.ru', '+79277335638', 'Добро пожаловать в наш автосервис! Мы - профессиональная команда специалистов, готовых помочь вам с любыми проблемами вашего автомобиля. Мы предлагаем широкий спектр услуг, включая регулярное техническое обслуживание, диагностику и ремонт двигателя, трансмиссии, подвески, замену масла, фильтров, тормозных дисков и других деталей, а также электродиагностику и ремонт электроники автомобиля. Мы работаем с автомобилями всех марок и моделей, используя только качественные запчасти, и наши мастера обладают большим опытом. Приходите к нам, и ваш автомобиль будет в надежных руках! Наша цель - обеспечить вам безопасность и комфорт во время езды.', 'monolit.jpg'),
	(20, 'СТО «Формула»', 'Формула', '1234', '1234', '1234', 'Осанов', 'Владимир', 'Андреевич', 'ozan11@mail.ru', '+79543303456', 'Добро пожаловать в наш автосервис! Мы - команда опытных специалистов, готовых помочь вам с решением любых проблем вашего автомобиля.', 'formula.jpg'),
	(21, 'СТО «Победа»', 'Победа', '58585', '45112', '6849', 'Шакиров', 'Вадим', 'Витальевич', 'oazesh@gmail.com', '+78921423423', 'Добро пожаловать в наше автосервисное предприятие! Мы - команда профессионалов, готовых помочь вам с любыми проблемами вашего автомобиля.', 'pobeda.jpg'),
	(23, 'СТО «Спутник»', 'Спутник', '432112', '342432', '65434', 'Косолапов', 'Виталий', 'Павлович', 'test@gmail.com', '34212', 'В нашем автосервисе вы встретите идеальное сочетание роскоши, качества и профессионализма. Мы специализируемся на обслуживании автомобилей премиум-класса, где каждая деталь имеет значение.', 'sputnik.jpg');

-- Дамп структуры для таблица aggregator.registrations
CREATE TABLE IF NOT EXISTS `registrations` (
  `registrations_id` int NOT NULL AUTO_INCREMENT,
  `email` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` char(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`registrations_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.registrations: ~7 rows (приблизительно)
DELETE FROM `registrations`;
INSERT INTO `registrations` (`registrations_id`, `email`, `password`, `type`) VALUES
	(16, 'kosolapov10@list.ru', '$2b$10$V6UsPUTOF5.DCVfaPDoTKeYz33VMYKefnCfQbHxK/pCBdjEJHCCMO', ''),
	(17, 'schaminayuliana@gmail.com', '$2b$10$y3KUV5xTV2vOKlbCcfveU.d3CtPQ34cK1uscpyBEJy423TRqVucrm', 'ORG'),
	(18, 'kos@mail.ru', '$2b$10$rQGE4eaD8lbyQHSGrpWdSO1EESJMdEBrOtaNkM6xkWLQvbSGAy/.C', 'ADM'),
	(19, 'osan20@mail.ru', '$2b$10$jnxQx17.u9H90Gvidkl6DeWvvxoASPXB5xPEzp9pxQlORCZ0Hk512', 'ORG'),
	(20, 'ozan11@mail.ru', '$2b$10$byoHGGQx9uc0tbiSDM5w/upg8u5CUZPIbMi1R9o1wC.XXYEhgleAe', 'ORG'),
	(21, 'oazesh@gmail.com', '$2b$10$I5TJ93gXi9gGyjB7nKMGouPC1L4xQW3Go4Gk3T9hj7or62cSUub3G', 'USR'),
	(22, 'test@gmail.com', '$2b$10$GWyHczQNllf.luDIxCyidO2IrKq1q7h1zone7pRKzblKJ88uUOvAi', 'ORG');

-- Дамп структуры для таблица aggregator.service_detail
CREATE TABLE IF NOT EXISTS `service_detail` (
  `service_detail_id` int NOT NULL,
  `service_detail_code` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `service_detail_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `service_detail_cost` int DEFAULT NULL,
  `service_detail_duration` int DEFAULT NULL,
  `add_info` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`service_detail_id`),
  CONSTRAINT `service_detail_ibfk_1` FOREIGN KEY (`service_detail_id`) REFERENCES `type_of_service` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.service_detail: ~10 rows (приблизительно)
DELETE FROM `service_detail`;
INSERT INTO `service_detail` (`service_detail_id`, `service_detail_code`, `service_detail_name`, `service_detail_cost`, `service_detail_duration`, `add_info`) VALUES
	(1, '18', 'Балансировка колёс', 500, 60, 'Wheel balancing Wheel balancing Wheel balancing'),
	(2, '18', 'Нанесение тонировки', 1500, NULL, NULL),
	(3, '20', 'Центровка коленчатого вала', 725, NULL, NULL),
	(4, '21', 'Шиномонтажный сервис', 1000, NULL, NULL),
	(5, '21', 'Мойка', 400, NULL, NULL),
	(6, '18', 'Замена масла', 1100, NULL, NULL),
	(7, '21', 'Ремонт колпачка двигателя', 30000, NULL, NULL),
	(8, '21', 'Замена бампера', 20000, NULL, NULL),
	(18, '19', 'Балансировка колёс', 28000, NULL, NULL),
	(19, '19', 'Замена бампера', 25000, NULL, NULL);

-- Дамп структуры для таблица aggregator.service_request
CREATE TABLE IF NOT EXISTS `service_request` (
  `service_request_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `date_service` datetime DEFAULT NULL,
  `add_info_char` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`service_request_id`),
  KEY `Индекс 2` (`customer_id`,`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.service_request: ~0 rows (приблизительно)
DELETE FROM `service_request`;

-- Дамп структуры для таблица aggregator.service_request_detail
CREATE TABLE IF NOT EXISTS `service_request_detail` (
  `service_request_detail_id` int NOT NULL,
  `service_request_id` int DEFAULT NULL,
  `service_detail_id` int DEFAULT NULL,
  PRIMARY KEY (`service_request_detail_id`),
  KEY `Индекс 2` (`service_request_id`,`service_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.service_request_detail: ~0 rows (приблизительно)
DELETE FROM `service_request_detail`;

-- Дамп структуры для таблица aggregator.type_of_service
CREATE TABLE IF NOT EXISTS `type_of_service` (
  `type_id` int NOT NULL,
  `type_code` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type_name` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дамп данных таблицы aggregator.type_of_service: ~10 rows (приблизительно)
DELETE FROM `type_of_service`;
INSERT INTO `type_of_service` (`type_id`, `type_code`, `type_name`) VALUES
	(1, '111', 'Wheel balancing'),
	(2, '222', 'Applying tinting'),
	(3, '333', 'Crankshaft alignment'),
	(4, '444', 'Tire service'),
	(5, '555', 'Washing'),
	(6, '666', 'Change of oil'),
	(7, '777', 'Engine repair cap'),
	(8, '888', 'Bumper replacement'),
	(18, '1818', 'Bumper replacement'),
	(19, '1919', 'Bumper replacement');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
