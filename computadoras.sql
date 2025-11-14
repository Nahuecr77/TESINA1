-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2025 at 02:11 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventario`
--

-- --------------------------------------------------------

--
-- Table structure for table `computadoras`
--

CREATE TABLE `computadoras` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `numero_serie` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `estado` enum('disponible','en uso','mantenimiento','baja') DEFAULT 'disponible',
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_adquisicion` date DEFAULT NULL,
  `fecha_ultimo_mantenimiento` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `computadoras`
--

INSERT INTO `computadoras` (`id`, `nombre`, `marca`, `modelo`, `numero_serie`, `ubicacion`, `estado`, `usuario_id`, `fecha_adquisicion`, `fecha_ultimo_mantenimiento`, `observaciones`) VALUES
(1, 'PC-LAB-001', 'Dell', 'OptiPlex 709', 'DL123456789', 'Laboratorio 1', 'disponible', NULL, '2023-01-15', NULL, 'None'),
(2, 'PC 15', 'Gobierno', 'GW2-W116', 'MEC0003009579', 'CARRO GRIS', 'en uso', NULL, '2023-02-20', NULL, 'Se sale una tecla'),
(3, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'GW2W1180009216', 'Caja 1 / Aula 4', 'baja', NULL, '2023-03-10', NULL, ''),
(4, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'HN211Q60000638', 'Caja 1 / Aula 4', 'en uso', NULL, '2023-01-30', NULL, ''),
(5, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'GW2W1160002772', '24- Caja 1 / Aula 4', 'baja', 1, '2023-03-19', '2025-04-01', ''),
(6, 'Carro', 'Gobierno', 'GW2-W116', '04', 'Aula 3', 'disponible', 1, '2025-09-08', '2025-03-04', 'Se le salio un tornillo y se reemplazo'),
(7, 'Ministerio de educacion', 'Pixart', 'GW2-W116', 'GW2W1160002839', '19-Caja 1 / Aula 4', 'disponible', 4, '0000-00-00', NULL, ''),
(8, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'HN211Q60001145', '28-Caja 1 / Aula 4', 'disponible', 4, '0000-00-00', NULL, ''),
(9, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'GW2W1160002841', '22-Caja 1 / Aula 4', 'disponible', 4, '0000-00-00', NULL, ''),
(10, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'GW2W11160002468', '17-Caja 1 / Aula 4', 'disponible', 4, '0000-00-00', NULL, ''),
(11, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'GW2W1160002050', '21-Caja 1 / Aula 4', 'disponible', 4, '0000-00-00', NULL, ''),
(12, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000217', '4- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(13, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'MEC0003006849', '5 - Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(14, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001020', '6 - Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(15, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000213', '7 - Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(16, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'MEC0003009693', '8 - Sala de arte ', 'disponible', 4, '0000-00-00', NULL, ''),
(17, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001008', '9 - Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(18, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001012', '10- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(19, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001142', '11- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(20, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000977', '12- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(21, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001010', '13- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(22, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000214', '20- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(23, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000975', '19- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(24, 'Ministerio de educacion ', 'Pixart', 'GW2-W116', 'MEC0004000212', '18-Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(25, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001001', '14- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(26, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001147', '15- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(27, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000974', '17- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(28, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC00040009711', '16- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(29, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000218', '30- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(30, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000632', '29- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(31, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004000211', '28- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(32, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001143', '27-Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(33, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001146', '26- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(34, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001018', '25- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(35, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001141', '24- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(36, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001019', '23-Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(37, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC0004001017', '22- Sala de arte', 'disponible', 4, '0000-00-00', NULL, ''),
(38, 'Ministerio de educacion ', 'Pixart', 'HN2-11Q6', 'MEC004001005', '21- Sala de arte', 'disponible', 4, NULL, NULL, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `computadoras`
--
ALTER TABLE `computadoras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_computadoras_estado` (`estado`),
  ADD KEY `idx_computadoras_ubicacion` (`ubicacion`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `computadoras`
--
ALTER TABLE `computadoras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `computadoras`
--
ALTER TABLE `computadoras`
  ADD CONSTRAINT `computadoras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
