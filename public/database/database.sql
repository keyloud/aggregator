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

-- Дамп данных таблицы aggregator.adress: ~0 rows (приблизительно)
DELETE FROM `adress`;

-- Дамп данных таблицы aggregator.adress_type: ~0 rows (приблизительно)
DELETE FROM `adress_type`;

-- Дамп данных таблицы aggregator.aggregator_specialist: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist`;

-- Дамп данных таблицы aggregator.aggregator_specialist_connector_request: ~0 rows (приблизительно)
DELETE FROM `aggregator_specialist_connector_request`;

-- Дамп данных таблицы aggregator.connection_request: ~0 rows (приблизительно)
DELETE FROM `connection_request`;

-- Дамп данных таблицы aggregator.customer: ~0 rows (приблизительно)
DELETE FROM `customer`;
INSERT INTO `customer` (`customer_id`, `customer_name`, `customer_surname`, `customer_patronymic`, `customer_phone_number`, `customer_email`, `add_info`, `profile_image`) VALUES
	(1, 'Vadim', 'SSS', 'VVV', '86856732', 'oazesh@gmail.com', 'dascawwcsd', 'av.png');

-- Дамп данных таблицы aggregator.organization: ~3 rows (приблизительно)
DELETE FROM `organization`;
INSERT INTO `organization` (`organization_id`, `organization_full_name`, `organization_short_name`, `inn`, `kpp`, `ogrn`, `responsible_person_surname`, `responsible_person_name`, `responsible_person_patronymic`, `responsible_person_email`, `responsible_person_phone_number`, `add_info`, `profile_image`) VALUES
	(18, 'Koka Ola', 'Koka Ola', '4444', '4444', '4444', 'Ola', 'Koka', 'Patronovna', 'kos@mail.ru', '+79277332638', 'Gena Na', 'IR.jpg'),
	(19, 'PSUTI', 'PSUTI', '7777', '7777', '7777', 'Osanov', 'Vladimir', 'Andreevich', 'osan20@mail.ru', '+79277335638', 'Gena Na', 'nigg.jpg'),
	(20, 'PSUTI TEHNICUM', 'PSUTI', '1234', '1234', '1234', 'Ozanov', 'Vladimir', 'Andreevich', 'ozan11@mail.ru', '+79543303456', 'descrption', 'Zoz0XqMDd4c.jpg'),
	(21, 'STO Pobeda', 'Pobeda', '58585', '45112', '6849', 'Harlamov', 'Garik', 'Alexandrovich', 'oazesh@gmail.com', '+78921423423', 'Welcome to our auto repair shop! We are a team of professionals ready to help you with any problems with your car.', 'pobeda.jpg'),
	(23, 'FARAD GARAGE', 'FQW', '432112', '342432', '65434', 'FEW', 'Fasdqw', 'RWEFD', 'test@gmail.com', '34212', '123423', '2Pac-1996.jpg');

-- Дамп данных таблицы aggregator.registrations: ~5 rows (приблизительно)
DELETE FROM `registrations`;
INSERT INTO `registrations` (`registrations_id`, `email`, `password`, `type`) VALUES
	(16, 'kosolapov10@list.ru', '$2b$10$V6UsPUTOF5.DCVfaPDoTKeYz33VMYKefnCfQbHxK/pCBdjEJHCCMO', ''),
	(17, 'schaminayuliana@gmail.com', '$2b$10$y3KUV5xTV2vOKlbCcfveU.d3CtPQ34cK1uscpyBEJy423TRqVucrm', 'ORG'),
	(18, 'kos@mail.ru', '$2b$10$rQGE4eaD8lbyQHSGrpWdSO1EESJMdEBrOtaNkM6xkWLQvbSGAy/.C', 'ADM'),
	(19, 'osan20@mail.ru', '$2b$10$jnxQx17.u9H90Gvidkl6DeWvvxoASPXB5xPEzp9pxQlORCZ0Hk512', 'ORG'),
	(20, 'ozan11@mail.ru', '$2b$10$byoHGGQx9uc0tbiSDM5w/upg8u5CUZPIbMi1R9o1wC.XXYEhgleAe', 'ORG'),
	(21, 'oazesh@gmail.com', '$2b$10$I5TJ93gXi9gGyjB7nKMGouPC1L4xQW3Go4Gk3T9hj7or62cSUub3G', 'USR'),
	(22, 'test@gmail.com', '$2b$10$GWyHczQNllf.luDIxCyidO2IrKq1q7h1zone7pRKzblKJ88uUOvAi', 'ORG');

-- Дамп данных таблицы aggregator.service_detail: ~0 rows (приблизительно)
DELETE FROM `service_detail`;
INSERT INTO `service_detail` (`service_detail_id`, `service_detail_code`, `service_detail_name`, `service_detail_cost`, `service_detail_duration`, `add_info`) VALUES
	(1, '111', 'Wheel balancing', 500, 60, 'Wheel balancing Wheel balancing Wheel balancing'),
	(2, '222', 'Applying tinting', 1500, NULL, NULL),
	(3, '20', 'Crankshaft alignment', 725, NULL, NULL),
	(4, '21', 'Tire service', 1000, NULL, NULL),
	(5, '21', 'Washing', 400, NULL, NULL),
	(6, '666', 'Change of oil', 1100, NULL, NULL),
	(7, '21', 'Engine repair cap', 30000, NULL, NULL),
	(8, '21', 'Bumper replacement', 20000, NULL, NULL),
	(18, '19', 'Replacement', 28000, NULL, NULL),
	(19, '19', 'Bumper replacement', 25000, NULL, NULL);

-- Дамп данных таблицы aggregator.service_request: ~0 rows (приблизительно)
DELETE FROM `service_request`;

-- Дамп данных таблицы aggregator.service_request_detail: ~0 rows (приблизительно)
DELETE FROM `service_request_detail`;

-- Дамп данных таблицы aggregator.type_of_service: ~0 rows (приблизительно)
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
