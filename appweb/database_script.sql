-- Script para crear la base de datos de inventario de computadoras para escuela
-- Ejecutar este script en MySQL para crear la base de datos y las tablas necesarias

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS inventario CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inventario;

-- Tabla de usuarios (para login y registro)
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'usuario') DEFAULT 'usuario',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de computadoras (inventario principal)
CREATE TABLE IF NOT EXISTS computadoras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    numero_serie VARCHAR(100) UNIQUE,
    ubicacion VARCHAR(100),
    estado ENUM('disponible', 'en uso', 'mantenimiento', 'baja') DEFAULT 'disponible',
    usuario_id INT,
    fecha_adquisicion DATE,
    fecha_ultimo_mantenimiento DATE,
    observaciones TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

-- Insertar algunos datos de ejemplo para pruebas
-- Usuario administrador (password: admin123)
INSERT INTO usuarios (nombre, correo, password, rol) VALUES 
('Administrador', 'admin@escuela.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/HS.iK2O', 'admin');

-- Usuario normal (password: user123)
INSERT INTO usuarios (nombre, correo, password, rol) VALUES 
('Usuario Prueba', 'usuario@escuela.com', '$2b$12$8K1p/a0dL1LXMIgoEDFrwOe6g7fKoJ7pFqKqKqKqKqKqKqKqKqKqK', 'usuario');

-- Algunas computadoras de ejemplo
INSERT INTO computadoras (nombre, marca, modelo, numero_serie, ubicacion, estado, fecha_adquisicion) VALUES 
('PC-LAB-001', 'Dell', 'OptiPlex 7090', 'DL123456789', 'Laboratorio 1', 'disponible', '2023-01-15'),
('PC-LAB-002', 'HP', 'ProDesk 600', 'HP987654321', 'Laboratorio 1', 'en uso', '2023-02-20'),
('PC-OFICINA-001', 'Lenovo', 'ThinkCentre M90', 'LN456789123', 'Oficina Administrativa', 'disponible', '2023-03-10'),
('PC-BIBLIOTECA-001', 'Dell', 'Vostro 3681', 'DL789123456', 'Biblioteca', 'mantenimiento', '2023-01-30');

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_computadoras_estado ON computadoras(estado);
CREATE INDEX idx_computadoras_ubicacion ON computadoras(ubicacion);
CREATE INDEX idx_usuarios_correo ON usuarios(correo);

-- Mostrar las tablas creadas
SHOW TABLES;

-- Verificar los datos insertados
SELECT 'Usuarios:' as tabla;
SELECT id, nombre, correo, rol FROM usuarios;
SELECT 'Computadoras:' as tabla;
SELECT id, nombre, marca, modelo, numero_serie, ubicacion, estado FROM computadoras; 