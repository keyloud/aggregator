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

-- Дамп данных таблицы aggregator.adress: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.adress_type: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.aggregator_specialist: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.aggregator_specialist_connector_request: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.connection_request: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.customer: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.organization: ~1 rows (приблизительно)
REPLACE INTO `organization` (`organization_id`, `organization_full_name`, `organization_short_name`, `inn`, `kpp`, `ogrn`, `responsible_person_surname`, `responsible_person_name`, `responsible_person_patronymic`, `responsible_person_email`, `responsible_person_phone_number`, `add_info`, `profile_image`) VALUES
	(8, 'ANIME', NULL, '3434343241', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'dark.jpg');

-- Дамп данных таблицы aggregator.registrations: ~7 rows (приблизительно)
REPLACE INTO `registrations` (`registrations_id`, `email`, `password`) VALUES
	(1, 'dima', '$2b$10$Qn3okIvJQJ39.1yGAfHd3u4AOuDUABJvSbVf147vg8/TOmLkI5R7K'),
	(2, 'dimasik', '$2b$10$rWotJCGd8PFZGlAG3xCNXuEgz/eDAVOVFXjFFt.ep2CYGUgwNfkC2'),
	(3, 'test', '$2b$10$8XVNgAv9.joAzX39SlWwDOM2YkAoOvDbm34Yg/gOkqK6J0IdF1CwC'),
	(4, 'vadya', '$2b$10$f9pJik93exAtQX7uOW.NNe.nWVhJl67e8W5G4rroAgx/MS2/gEOoa'),
	(5, 'new', '$2b$10$jIFaYdFmvnM6La2esOVAtOlpgtQrLzdSUil8oeHZof8m0BGkawPjy'),
	(6, 'root', '$2b$10$BuqRHekHLwip6SFujybAGeSJPUogaYVgqVhFp8dMzirFVS4ikyHcy'),
	(8, 'test12@mail.ru', '$2b$10$H/K8s9MWjeU15lVqWNz68eoaIj6lWi8HJMgZ8IiVpAz91oiL917jC');

-- Дамп данных таблицы aggregator.service_detail: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.service_request: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.service_request_detail: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.type_of_service: ~0 rows (приблизительно)

-- Дамп данных таблицы aggregator.users: ~2 rows (приблизительно)
REPLACE INTO `users` (`id`, `name`, `age`) VALUES
	(1, 'dimka', 20),
	(2, 'ivan', 11);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
