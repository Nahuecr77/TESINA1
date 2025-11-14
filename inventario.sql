-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2025 at 05:21 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','usuario') DEFAULT 'usuario',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `rol`, `fecha_registro`) VALUES
(1, 'Administrador', 'admin@escuela.com', 'scrypt:32768:8:1$UhY0aR9biuYfMyWu$6bc60a8f0befc49793e73a5ad991528300fa079e2b96626b2559cbd6635f928052f1510c704e7c82ddbfe10e3cd19ced1adb6f9e4f748c1164a92673c3679eba', 'admin', '2025-07-30 16:36:52'),
(2, 'Usuario Prueba', 'usuario@escuela.com', 'scrypt:32768:8:1$aA36v6O5QeF6b8yB$afaff44b974f4e33d76835158c1e0e4d307243e8fd5bbdb6380ec96248e2e9a5a693be32392530e26df8923fde4d13fb2675fe43f0879f7ad46940ec7306f5b2', 'usuario', '2025-07-30 16:36:52'),
(4, 'viviana guillen', 'vaguillen@escuelasproa.edu.ar', 'scrypt:32768:8:1$3OXWEPZBhzG5IesZ$bbffe0fa60f747c209cf3c730f6b1013066bd2f3338f3c35013f2c8e5913744341752cde4081d81b43493d3f28a01e0cc23409054a8c136cf5a8df3b21b4c033', 'usuario', '2025-08-04 12:17:38'),
(5, 'pablo', 'ptorres@escuelasproa.edu.ar', 'scrypt:32768:8:1$WcZSid4HOggIfeS9$35f8a58f13e8ebbf9e50f7b5f35bcb6fb1b079c4d96c5d1ffa057d164db7782db217f87b39cd286a3fb26637cd024e6c7efd38f565292571684f77e4678c14fc', 'usuario', '2025-08-04 18:12:41'),
(6, 'leo calvi', 'localvi@escuelasproa.edu.ar', 'scrypt:32768:8:1$ODaAoWLoTc4gaMt7$757915903e535b02aaf1c8bff5d53b7b7c6b126ffe0b9b07f37f76cc330dd98741748077befdf92c41d726a60370692f64bbe7a042adad44565db1c07c0325b1', 'usuario', '2025-08-06 16:16:01'),
(7, 'mateo bruno', 'mbrunobarberon@escuelasproa.edu.ar', 'scrypt:32768:8:1$n3ilUnfYMqi5XGam$951bbd1f7cbd3d7a298f839132e93e2e4bedd37530d1112e36197477dbb67bd5989829b7862450e5290dec6c1f33cae15634db5d74fb8083625b66614867523a', 'usuario', '2025-08-08 12:21:48'),
(8, 'giuliana ', 'gmspaccesi@escuelasproa.edu.ar', 'scrypt:32768:8:1$WnLQ8KHhpjDW4NLN$818cf5c83692f4770cff21172638fc8a40e1acd4290057e2a5838fb1a8137cf0efb26345307fde0139667aaf4d158e77593205408419fb81a6427df972a67988', 'usuario', '2025-09-03 22:34:15'),
(11, 'JULIETA DEL ROSARIO DEMICHELIS', 'jdemichelis@escuelasproa.edu.ar', 'scrypt:32768:8:1$fiVoePKQFlb0WRwC$62f0575322f5420c155cc7655c42c60c3d02838f00291ca2662921ac03fb287ee6b4ce986a224d43626d41d425ff660e30f619a17291b18090700f3e1d2f14e0', 'usuario', '2025-10-31 17:44:47');

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
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `idx_usuarios_correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `computadoras`
--
ALTER TABLE `computadoras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
