-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2024 at 10:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car`
--

-- --------------------------------------------------------

--
-- Table structure for table `destination`
--

CREATE TABLE `destination` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lat` decimal(18,15) NOT NULL,
  `lon` decimal(18,15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destination`
--

INSERT INTO `destination` (`id`, `name`, `lat`, `lon`) VALUES
(1, 'Ein Shams', 30.128054651470880, 31.330061245615640),
(2, 'Nozah', 30.086686605994810, 31.300173766788080),
(3, 'Helwan', 29.868823725425010, 31.320034913330886);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `username`, `role`, `created_at`, `email`, `password`, `service_id`, `location`) VALUES
(1, 'seif', NULL, '2024-05-05 17:50:13', 'seif@info.com', '$2b$10$he7nLOOjDyGrFtCp7rG8ju2ITH/Iuow956LXcvgP6MQ8oHs.qAZae', 1, '29.21656 ,30.566'),
(2, 'seif2', NULL, '2024-05-05 17:50:37', 'seif2@info.com', '$2b$10$Bwxd40H75XYG2WJ7trdDB.uJEGeEjlAEmRFhqH7PUMnR1HLOi6Jpe', 2, '29.21656 ,30.566');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `feedback` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `user_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mechanics_locations`
--

CREATE TABLE `mechanics_locations` (
  `Name` varchar(55) NOT NULL,
  `City` varchar(13) DEFAULT NULL,
  `Latitude` varchar(8) DEFAULT NULL,
  `Longitude` varchar(9) DEFAULT NULL,
  `Rate` varchar(4) DEFAULT NULL,
  `PhoneNumber` varchar(12) DEFAULT NULL,
  `Area` varchar(22) DEFAULT NULL,
  `ID` int(3) DEFAULT NULL,
  `OpenTime` varchar(13) DEFAULT NULL,
  `yearsEx` int(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `mechanics_locations`
--

INSERT INTO `mechanics_locations` (`Name`, `City`, `Latitude`, `Longitude`, `Rate`, `PhoneNumber`, `Area`, `ID`, `OpenTime`, `yearsEx`) VALUES
('360 Auto care', ' Alexandria', '31.12803', '29.89088', '4.4', '1196733444', 'Elamriya', 26, '10:00 AM', 5),
('3M AutoMotive ', 'Giza', '29.94093', '31.09678', '4.5', '02 33924878', 'ElHaram', 45, '12:00 PM', 2),
('AAMC Center', ' Alexandria', '31.42336', '29.9832', '4.6', '1106536354', 'muharram bey', 35, '8:00 AM', 3),
('Ahmed Hosni Center', ' Alexandria', '31.15347', '29.90567', '3.9', '1212424334', 'Burg elarab', 22, '9:00 AM', 4),
('Ahmed Ramadan maintance center', 'Giza', '29.90677', '31.26894', '4.5', '1122444045', 'Hawamdiya', 13, '10:00 AM', 7),
('AL ALAMIA JEEP SERVICE CENTER', 'Cairo', '29.98429', '31.30587', '5', '1014252811', 'ElBastin', 5, '7:00 AM', 10),
('Al Mansour car maintenance center', 'Giza', '30.03775', '31.19586', '4.5', '1069700237', 'eldokki', 24, '8:00 AM', 8),
('Al Tawakkil Center for Car Maintenance', 'Cairo', '30.05145', '31.36542', '4.6', '1116666087', 'nasr city', 58, '9:00 AM', 6),
('Al-Sham Center for Modern Car Maintenance', 'Cairo', '30.04438', '31.36359', '4.8', '1114851520', 'nasr city', 115, 'open 24 hours', 11),
('Alex center', ' Alexandria', '31.42323', '29.92133', '4.2', '1254354655', 'Elamriya', 31, '9:00 AM', 2),
('Aman  Center', ' Alexandria', '31.43353', '29.89057', '4.1', '1113435433', 'muharram bey', 24, '7:00 AM', 7),
('Auto Academy', 'Port Said', '31.24615', '32.28763', '4.9', '1033643454', 'Qism ElDawhey', 91, '8:00 AM', 6),
('Auto jameel center', ' Alexandria', '31.12241', '29.90669', '4.4', '1224345445', 'Max', 9, '9:00 AM', 5),
('Auto Master', 'Suez ', '29.90776', '32.54344', '4.7', '1113545455', 'Ataka', 99, '9:00 AM', 9),
('Auto Sohag', 'Sohag', '26.50977', '31.70544', '4.2', '1024344444', 'Qism Second Sohag', 41, '12:00 PM', 5),
('Badr Center', 'Port Said', '31.22444', '32.28977', '4.5', '1024343333', 'porfoad', 60, '10:00 AM', 9),
('BMW Collection Center', ' Alexandria', '31.63445', '29.95965', '4.9', '1199566500', 'Sedi Gaber', 7, '11:00 AM', 2),
('Car Care Center', '  Alexandria ', '31.10172', '29.91373', '4.7', '1124333333', 'kilo 21', 27, '11:00 AM', 8),
('Car fix', ' Alexandria', '31.17078', '29.92205', '4.8', '1000087832', 'muharram bey', 33, '12:00 PM', 3),
('Car Guys Center', ' Alexandria', '31.12069', '29.89323', '4.8', '1147037589', 'north coast', 45, '10:00 AM', 3),
('car tech', 'Sohag', '26.51434', '31.78755', '5', '1233444444', 'Sohag new city', 89, '6:00 AM', 8),
('Car`s  technology', 'Suez', '29.96447', '32.55941', '4', '1033544333', 'Qism forty', 59, '11:00 AM', 3),
('city cars', ' Alexandria', '31.32323', '29.32326', '4.5', '1125435545', 'Second Raml Distruct', 66, '1:00 PM', 5),
('Deutech Zone Auto Service', 'Cairo', '29.97986', '31.28169', '4.8', '1028908888', 'maadi', 34, '10:00 AM', 4),
('EGO CENTER', 'Suez', '29.89766', '32.53323', '3.8', '1043006554', 'kafr elnagar', 71, '11:00 AM', 2),
('Egyptian Engineering Company for Automotive Services 3S', 'Alexandria', '31.17359', '29.94501', '4.3', '1148444811', 'muharram bey', 187, '8:00 AM', 2),
('ElAlamia Egyption', ' Alexandria', '31.25395', '29.92132', '4.2', '1133655667', 'Sedi Gaber', 32, '8:00 AM', 5),
('ElAmar center', ' Alexandria', '31.53321', '29.86433', '5', '1532435364', 'Second Raml Distruct', 76, '7:00 AM', 4),
('Elgamal maintenace', ' Alexandria', '31.16809', '29.89222', '5', '1033234344', ' Mina AlBasal District', 56, '11:00 AM', 6),
('Elmansour Center', ' Alexandria', '31.12065', '29.56668', '4', '1224235344', 'Second Raml Distruct', 28, '8:00 AM', 5),
('Elmohands center', 'Sohag', '26.53439', '31.73222', '4.9', '1000433432', 'Sohag new city', 102, '7:00 AM', 5),
('ElNADY AUTO cetner', 'Suez', '29.97554', '32.54338', '4.2', '1043544445', 'Qism forty', 77, '11:00 AM', 3),
('ElRadwan center for modern car maintenace', 'Giza', '29.97985', '31.15624', '4.9', '1141592426', 'ElHaram', 183, '9:00 AM', 8),
('Elsultan center', 'Sohag', '26.50544', '31.70754', '4.3', '1143545555', 'Qism First Sohag', 44, '11:00 AM', 3),
('Elzaeem Center', ' Alexandria', '31.18653', '29.90323', '4.5', '1243645000', 'kilo 21', 76, '7:00 AM', 1),
('Emad fawzy center', ' Alexandria', '31.12323', '29.91297', '4.2', '1575744353', 'Sedi Gaber', 11, '12:00 PM', 4),
('Eslam ford center', ' Alexandria', '31.13244', '29.96456', '4.6', '1586654676', 'ElAgmi', 8, '10:00 AM', 1),
('Etman car services', 'Alexandria', '31.20693', '29.99817', '4.3', '1063702828', 'Second Raml Distruct', 143, '8:00 AM', 1),
('Eurobian Egyption center', ' Alexandria', '31.15798', '29.89032', '4.9', '1163635640', 'Elamriya', 122, '12:00 PM', 3),
('F.B.S auto service', 'Cairo', '29.98416', '31.27562', '4.7', '1006003002', 'maadi', 46, '8:00 AM', 7),
('H&M car services', 'Cairo', '29.96266', '31.30726', '4.5', '1220001613', 'maadi', 39, '9:00 AM', 6),
('Hassan Sons', 'Sohag', '26.54343', '31.72122', '4.8', '1222434333', 'Qism Second Sohag', 100, '8:00 AM', 10),
('injection center', 'Sohag', '26.56001', '31.72018', '4.6', '1113132222', 'Qism First Sohag', 29, '12:00 PM', 9),
('Korean Center for Car Maintenance', ' Alexandria', '31.23203', '29.90564', '5', '1224374344', 'ElAgmi', 67, '11:00 AM', 9),
('m.c.s center for car maintenace', 'Giza', '30.00864', '31.17777', '4.6', '1001079100', 'Bulaq Dakror', 29, '7:00 AM', 5),
('Masters Car Service', 'Cairo', '29.99395', '31.30806', '4.7', '1158151116', 'ElKhalifa', 47, '9:00 AM', 3),
('Mokattam Car Maintenance Center', 'Cairo', '30.00339', '31.31794', '4.7', '02 25085588', 'Elmokattam', 38, '10:00 AM', 3),
('Name', 'City', 'Latitude', 'Longitude', 'Rate', 'Phone Number', 'Area', 0, 'Open Time', 0),
('petro Auto center', ' Alexandria', '31.13244', '29.89067', '4.8', '1587465450', 'kilo 21', 98, '10:00 AM', 6),
('Rpm center', 'Sohag', '26.53433', '31.70766', '4.1', '1132432422', 'Ekhmim center', 81, '1:00 PM', 6),
('Rpm Egy center', ' Alexandria', '31.13267', '29.97807', '4.1', '1535354544', 'Elagmi', 98, '11:00 AM', 6),
('Sano Car', 'Port Said', '31.23535', '32.29644', '4.6', '1224243343', 'South Portsaid', 94, '9:00 AM', 7),
('Serial Center', 'Sohag', '26.53232', '31.70654', '4.7', '1033334243', 'Qism First Sohag', 43, '9:00 AM', 4),
('Smart Auto Service', 'Suez', '29.95353', '32.57545', '3.9', '1043644345', 'South suiz', 58, '12:00 PM', 5),
('Tamco Center', ' Alexandria', '31.31234', '29.89564', '4.3', '1132434444', 'Burg elarab', 10, '8:00 AM', 4),
('Team Work Center', 'Port Said', '31.23246', '32.27566', '5', '1033254444', 'ElArab', 62, '8:00 AM', 5),
('Tecno car center', 'Sohag', '26.54242', '31.74454', '4.6', '1043433344', 'Ekhmim center', 49, '9:00 AM', 5),
('tecno car for modern car maintenace', 'Cairo', '29.99154', '31.30211', '4.9', '1550555658', 'Elmokattam', 25, '11:00 AM', 3),
('Unit company', 'Sohag', '26.51088', '31.74243', '4.3', '1000324323', 'Sohag new city', 50, '11:00 AM', 3),
('VW Center', 'Port Said', '31.25334', '32.29541', '4.3', '1043245434', 'Qism Elmanakh', 90, '11:00 AM', 8);

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `Name` varchar(20) NOT NULL,
  `Comment` varchar(255) NOT NULL,
  `Rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`Name`, `Comment`, `Rate`) VALUES
('360 Auto care', 'WOW', 3),
('3M AutoMotive', 'WOW ffd', 5);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `service_name` varchar(255) DEFAULT NULL,
  `discription` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `service_name`, `discription`, `image`) VALUES
(1, 'mechanic', 'this is mechanic service', 'image-1714930895561.jpg'),
(2, 'winch', 'this is winch service', 'image-1714930998222.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `submit`
--

CREATE TABLE `submit` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `services_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `location` varchar(255) DEFAULT NULL,
  `distenation` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submit`
--

INSERT INTO `submit` (`id`, `created_at`, `services_id`, `user_id`, `status`, `location`, `distenation`, `phone_number`, `employee_id`) VALUES
(1, '2024-05-05 18:02:27', 1, NULL, NULL, '29.21656 ,30.566', NULL, '01125257350', 1),
(2, '2024-05-05 18:10:05', 1, 3, NULL, '29.21656 ,30.566', NULL, '01125257350', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `created_at`, `email`, `password`, `phone_number`) VALUES
(1, 'nn', '2024-05-04 15:02:01', 'n@infom.com', '$2b$10$DIDgnnEaG/0/l4WRxhNCMeuEUhhKEGMFmdjjFGclZFzTgsaouTl1m', '111011'),
(2, 'nn', '2024-05-04 15:02:23', 'n@insfom.com', '$2b$10$3BuzJSRIujX/J2NEPPfaCer3uRq3FDMsdM9a.WolAlsWgocJeuVii', '111011'),
(3, 'nn', '2024-05-04 15:03:02', 'n@dinsfom.com', '$2b$10$G8UhAam5UCwWAC54JL9RXueEIh66NL/614ideXDokiph1a.Dhcu.u', '111011'),
(6, 'Hassan Khaled', '2024-05-09 15:01:57', 'hassankhaled4432@gmail.com', '$2a$10$yRUdkFxFusepKe14rD4H4.wNGVTLtI5QdhtLAdxeu3L2tewOTiFAm', '01118877375');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `destination`
--
ALTER TABLE `destination`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `embloyee-service` (`service_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `em-fe` (`employee_id`),
  ADD KEY `user-fe` (`user_Id`);

--
-- Indexes for table `mechanics_locations`
--
ALTER TABLE `mechanics_locations`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `submit`
--
ALTER TABLE `submit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service-submit` (`services_id`),
  ADD KEY `user-submit` (`user_id`),
  ADD KEY `employee-submit` (`employee_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `destination`
--
ALTER TABLE `destination`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `submit`
--
ALTER TABLE `submit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `ser-em` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `em-fe` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user-fe` FOREIGN KEY (`user_Id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `submit`
--
ALTER TABLE `submit`
  ADD CONSTRAINT `emp-sib` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ser-sub` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user-sub` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
