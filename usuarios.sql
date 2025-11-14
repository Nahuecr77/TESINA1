-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2025 at 02:12 AM
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
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
