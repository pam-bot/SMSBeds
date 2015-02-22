CREATE DATABASE IF NOT EXISTS `sms_input`;
USE `sms_input`;

CREATE TABLE IF NOT EXISTS `sms_input`.`info_query` (
  `query_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from_number` VARCHAR(255) NOT NULL,
  `from_body` VARCHAR(2048) NOT NULL,
  `query_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `sms_input`.`beds_report` (
  `report_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from_number` VARCHAR(255) NOT NULL,
  `from_body` VARCHAR(2048) NOT NULL,
  `hospital_id` INT UNSIGNED NOT NULL,
  `authentic` TINYINT(1) NOT NULL,
  `success` TINYINT(1) NOT NULL,
  `report_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `sms_input`.`registered_staff` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `from_number` VARCHAR(255) NOT NULL,
  `hospital_id` INT UNSIGNED NOT NULL,
  `last_modified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `sms_input`.`unique_users` (
  `from_number` VARCHAR(255) NOT NULL PRIMARY KEY,
  `last_modified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE DATABASE IF NOT EXISTS `sms_data`;
USE `sms_data`;

CREATE TABLE IF NOT EXISTS `sms_data`.`hospital_beds` (
  `hospital_id` INT UNSIGNED NOT NULL PRIMARY KEY,
  `hospital_name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  `beds` INT UNSIGNED DEFAULT NULL,
  `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `sms_data`.`outbreaks` (
  `location` VARCHAR(100) NOT NULL PRIMARY KEY,
  `country` VARCHAR(100) NOT NULL,
  `type` VARCHAR(100) DEFAULT NULL,
  `longitude` DECIMAL(8,6) NOT NULL,
  `latitude` DECIMAL(8,6) NOT NULL,
  `presence` CHAR(1) NOT NULL,
  `report_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/* FAKE DATA ENTRY PEOPLE */
LOCK TABLES sms_input.registered_staff WRITE;
INSERT INTO sms_input.registered_staff (name, from_number, hospital_id) 
VALUES ('Pam', '+16463877470', 1234);
UNLOCK TABLES;

/* FAKE UNIQUE USERS */
LOCK TABLES sms_input.unique_users WRITE;
INSERT INTO sms_input.unique_users (from_number) 
VALUES ('+16134738475');
UNLOCK TABLES;

/* FAKE QUERY DATA */
LOCK TABLES sms_input.info_query WRITE;
INSERT INTO sms_input.info_query (from_number, from_body) 
VALUES ('+16134738475', 'Mamou'),
('+16134738475', 'Conakry');
UNLOCK TABLES;

/* FAKE HOSPITAL DATA */
LOCK TABLES sms_data.hospital_beds WRITE;
INSERT INTO sms_data.hospital_beds (hospital_id, hospital_name, location, country, beds) 
VALUES (1234, 'Hospital1', 'Conakry', 'Guinea', 1),
(5678, 'Hospital2', 'Mamou', 'Guinea', 3);
UNLOCK TABLES;

/* OUTDATED OUTBREAK DATA */
LOCK TABLES sms_data.outbreaks WRITE;
INSERT INTO sms_data.outbreaks (location, country, type, longitude, latitude, presence)
VALUES ('Bamako','Mali','locality',-8.000000,12.650000,'N'),
('Beyla','Guinea','locality',-8.633333,8.683333,'Y'),
('Bo','Sierra Leone','locality',11.740995,7.955179,'Y'),
('Boende','Democratic Republic of the Congo','locality',19.200000,-0.733333,'Y'),
('Boende Moke','Democratic Republic of the Congo','locality',20.750031,-0.381414,'N'),
('Boffa','Guinea','locality',-14.039162,10.180825,'Y'),
('Bombali','Sierra Leone','administrative_area_level_2',-12.163272,9.247584,'Y'),
('Bomi','Liberia','administrative_area_level_1',-10.845147,6.756293,'Y'),
('Bonthe','Sierra Leone','locality',-12.505000,7.526389,'Y'),
('Conakry','Guinea','locality',-13.712222,9.509167,'Y'),
('Coyah','Guinea','locality',-13.383333,9.700000,'Y'),
('Dabola','Guinea','locality',-11.116667,10.750000,'Y'),
('Dalaba','Guinea','locality',-9.383333,10.166667,'Y'),
('Dinguiraye','Guinea','locality',-10.716667,11.300000,'N'),
('Dubreka','Guinea','locality',-13.516667,9.783333,'Y'),
('Forecariah','Guinea','locality',-13.083333,9.433333,'Y'),
('Gbarpolu','Liberia','administrative_area_level_1',-10.080730,7.495264,'Y'),
('Grand Bassa','Liberia','administrative_area_level_1',-9.812494,6.230845,'Y'),
('Grand Cape Mount','Liberia','administrative_area_level_1',-11.071176,7.046776,'Y'),
('Grand Gedeh','Liberia','administrative_area_level_1',-8.221298,5.922208,'Y'),
('Grand Kru','Liberia','administrative_area_level_1',-8.221298,4.761386,'Y'),
('Gueckedou','Guinea','locality',-10.133333,8.566667,'Y'),
('Kailahun','Sierra Leone','locality',-10.573889,8.277222,'Y'),
('Kambia','Sierra Leone','locality',-12.917652,9.126166,'Y'),
('Kayes','Mali','locality',-11.445272,14.436788,'Y'),
('Kenema','Sierra Leone','locality',-11.195717,7.863215,'Y'),
('Kerouane','Guinea','locality',-9.016667,9.266667,'Y'),
('Kindia','Guinea','locality',-12.850000,10.066667,'Y'),
('Kissidougou','Guinea','locality',-10.100000,9.183333,'Y'),
('Koinadugu','Sierra Leone','locality',-11.363630,9.516877,'Y'),
('Kono','Sierra Leone','locality',-10.890310,8.766329,'Y'),
('Kouroussa','Guinea','locality',-9.883333,10.650000,'Y'),
('Lofa','Liberia','administrative_area_level_1',-9.723267,8.191118,'Y'),
('Lokolia','Democratic Republic of the Congo','locality',20.562519,-0.631684,'Y'),
('Lokula','Democratic Republic of the Congo','locality',20.653891,-0.420979,'N'),
('Lola','Guinea','locality',-88.307812,37.318664,'Y'),
('Macenta','Guinea','locality',-9.466667,8.550000,'Y'),
('Margibi','Liberia','administrative_area_level_1',-10.304890,6.515187,'Y'),
('Maryland','Liberia','administrative_area_level_1',-7.741670,4.725888,'Y'),
('Mondombe','Democratic Republic of the Congo','locality',22.753945,-0.775840,'N'),
('Montserrado','Liberia','administrative_area_level_1',-10.529611,6.552581,'Y'),
('Moyamba','Sierra Leone','locality',-12.433333,8.160556,'Y'),
('Nimba','Liberia','administrative_area_level_1',-8.660059,6.842761,'Y'),
('Nzerekore','Guinea','locality',-8.816667,7.750000,'Y'),
('Pita','Guinea','locality',-12.395582,11.059568,'Y'),
('Port Loko','Sierra Leone','locality',-12.787500,8.766667,'Y'),
('Pujehun','Sierra Leone','locality',-11.718056,7.350556,'Y'),
('River Cess','Liberia','administrative_area_level_1',-9.456155,5.902533,'Y'),
('River Gee','Liberia','administrative_area_level_1',-7.872160,5.260489,'Y'),
('Siguiri','Guinea','locality',-9.166667,11.416667,'Y'),
('Sikasso','Mali','locality',-5.666667,11.316667,'N'),
('Sinoe','Liberia','administrative_area_level_1',-8.660059,5.498710,'Y'),
('Telimele','Guinea','locality',-13.033333,10.900000,'Y'),
('Tonkolili','Sierra Leone','locality',-11.794756,8.980427,'Y'),
('Watsikengo','Democratic Republic of the Congo','locality',20.563259,-0.843500,'N'),
('Yomou','Guinea','locality',-9.253300,7.566000,'Y');
UNLOCK TABLES;


