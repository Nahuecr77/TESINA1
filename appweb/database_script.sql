-- Script para crear la base de datos de inventario de computadoras para escuela
-- Ejecutar este script en MySQL para crear la base de datos y las tablas necesarias

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS inventario CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE inventario;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-08-2025 a las 16:38:36
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `computadoras`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `computadoras`
--

INSERT INTO `computadoras` (`id`, `nombre`, `marca`, `modelo`, `numero_serie`, `ubicacion`, `estado`, `usuario_id`, `fecha_adquisicion`, `fecha_ultimo_mantenimiento`, `observaciones`) VALUES
(1, 'PC-LAB-001', 'Dell', 'OptiPlex 709', 'DL123456789', 'Laboratorio 1', 'disponible', NULL, '2023-01-15', NULL, NULL),
(2, 'PC-LAB-002', 'HP', 'ProDesk 600', 'HP987654321', 'Laboratorio 1', 'en uso', NULL, '2023-02-20', NULL, NULL),
(3, 'PC-OFICINA-001', 'Lenovo', 'ThinkCentre M90', 'LN456789123', 'Oficina Administrativa', 'disponible', NULL, '2023-03-10', NULL, NULL),
(4, 'PC-BIBLIOTECA-001', 'Dell', 'Vostro 3681', 'DL789123456', 'Biblioteca', 'mantenimiento', NULL, '2023-01-30', NULL, NULL),
(5, 'aula 1', 'LG', 'LG', '23', 'aula 1', 'mantenimiento', 1, NULL, NULL, ''),
(6, 'aula 2', 'LG', 'LG', '21', 'aula 2', 'disponible', 1, NULL, NULL, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','usuario') DEFAULT 'usuario',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `rol`, `fecha_registro`) VALUES
(1, 'Administrador', 'admin@escuela.com', 'scrypt:32768:8:1$UhY0aR9biuYfMyWu$6bc60a8f0befc49793e73a5ad991528300fa079e2b96626b2559cbd6635f928052f1510c704e7c82ddbfe10e3cd19ced1adb6f9e4f748c1164a92673c3679eba', 'admin', '2025-07-30 16:36:52'),
(2, 'Usuario Prueba', 'usuario@escuela.com', 'scrypt:32768:8:1$aA36v6O5QeF6b8yB$afaff44b974f4e33d76835158c1e0e4d307243e8fd5bbdb6380ec96248e2e9a5a693be32392530e26df8923fde4d13fb2675fe43f0879f7ad46940ec7306f5b2', 'usuario', '2025-07-30 16:36:52'),
(4, 'viviana guillen', 'vaguillen@escuelasproa.edu.ar', 'scrypt:32768:8:1$3OXWEPZBhzG5IesZ$bbffe0fa60f747c209cf3c730f6b1013066bd2f3338f3c35013f2c8e5913744341752cde4081d81b43493d3f28a01e0cc23409054a8c136cf5a8df3b21b4c033', 'usuario', '2025-08-04 12:17:38'),
(5, 'pablo', 'ptorres@escuelasproa.edu.ar', 'scrypt:32768:8:1$WcZSid4HOggIfeS9$35f8a58f13e8ebbf9e50f7b5f35bcb6fb1b079c4d96c5d1ffa057d164db7782db217f87b39cd286a3fb26637cd024e6c7efd38f565292571684f77e4678c14fc', 'usuario', '2025-08-04 18:12:41'),
(6, 'leo calvi', 'localvi@escuelasproa.edu.ar', 'scrypt:32768:8:1$ODaAoWLoTc4gaMt7$757915903e535b02aaf1c8bff5d53b7b7c6b126ffe0b9b07f37f76cc330dd98741748077befdf92c41d726a60370692f64bbe7a042adad44565db1c07c0325b1', 'usuario', '2025-08-06 16:16:01'),
(7, 'mateo bruno', 'mbrunobarberon@escuelasproa.edu.ar', 'scrypt:32768:8:1$n3ilUnfYMqi5XGam$951bbd1f7cbd3d7a298f839132e93e2e4bedd37530d1112e36197477dbb67bd5989829b7862450e5290dec6c1f33cae15634db5d74fb8083625b66614867523a', 'usuario', '2025-08-08 12:21:48');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `computadoras`
--
ALTER TABLE `computadoras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_computadoras_estado` (`estado`),
  ADD KEY `idx_computadoras_ubicacion` (`ubicacion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `idx_usuarios_correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `computadoras`
--
ALTER TABLE `computadoras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `computadoras`
--
ALTER TABLE `computadoras`
  ADD CONSTRAINT `computadoras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
