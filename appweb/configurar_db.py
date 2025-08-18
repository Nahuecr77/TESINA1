#!/usr/bin/env python3
"""
Script para configurar la base de datos MySQL
Autor: Sistema de Inventario Escolar
Fecha: 2024
"""

import mysql.connector
from mysql.connector import Error
import os
import sys

def conectar_mysql_sin_db():
    """Conecta a MySQL sin especificar base de datos"""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='admin123'  # Cambia esto por tu contraseña
        )
        return connection
    except Error as e:
        print(f"❌ Error conectando a MySQL: {e}")
        return None

def crear_base_datos():
    """Crea la base de datos y las tablas"""
    connection = conectar_mysql_sin_db()
    if not connection:
        return False
    
    try:
        cursor = connection.cursor()
        
        # Crear base de datos
        print("🗄️  Creando base de datos 'inventario'...")
        cursor.execute("CREATE DATABASE IF NOT EXISTS inventario CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
        print("✅ Base de datos creada")
        
        # Usar la base de datos
        cursor.execute("USE inventario")
        
        # Crear tabla usuarios
        print("👥 Creando tabla usuarios...")
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS usuarios (
                id INT AUTO_INCREMENT PRIMARY KEY,
                nombre VARCHAR(100) NOT NULL,
                correo VARCHAR(100) NOT NULL UNIQUE,
                password VARCHAR(255) NOT NULL,
                rol ENUM('admin', 'usuario') DEFAULT 'usuario',
                fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)
        print("✅ Tabla usuarios creada")
        
        # Crear tabla computadoras
        print("💻 Creando tabla computadoras...")
        cursor.execute("""
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
            )
        """)
        print("✅ Tabla computadoras creada")
        
        # Insertar datos de ejemplo
        print("📝 Insertando datos de ejemplo...")
        
        # Verificar si ya existen usuarios
        cursor.execute("SELECT COUNT(*) FROM usuarios")
        if cursor.fetchone()[0] == 0:
            # Usuario administrador (password: admin123)
            from werkzeug.security import generate_password_hash
            admin_password = generate_password_hash('admin123')
            cursor.execute("""
                INSERT INTO usuarios (nombre, correo, password, rol) VALUES 
                (%s, %s, %s, %s)
            """, ('Administrador', 'admin@escuela.com', admin_password, 'admin'))
            
            # Usuario normal (password: user123)
            user_password = generate_password_hash('user123')
            cursor.execute("""
                INSERT INTO usuarios (nombre, correo, password, rol) VALUES 
                (%s, %s, %s, %s)
            """, ('Usuario Prueba', 'usuario@escuela.com', user_password, 'usuario'))
            
            print("✅ Usuarios de ejemplo creados")
        else:
            print("ℹ️  Los usuarios ya existen")
        
        # Verificar si ya existen computadoras
        cursor.execute("SELECT COUNT(*) FROM computadoras")
        if cursor.fetchone()[0] == 0:
            # Computadoras de ejemplo
            computadoras_ejemplo = [
                ('PC-LAB-001', 'Dell', 'OptiPlex 7090', 'DL123456789', 'Laboratorio 1', 'disponible', '2023-01-15'),
                ('PC-LAB-002', 'HP', 'ProDesk 600', 'HP987654321', 'Laboratorio 1', 'en uso', '2023-02-20'),
                ('PC-OFICINA-001', 'Lenovo', 'ThinkCentre M90', 'LN456789123', 'Oficina Administrativa', 'disponible', '2023-03-10'),
                ('PC-BIBLIOTECA-001', 'Dell', 'Vostro 3681', 'DL789123456', 'Biblioteca', 'mantenimiento', '2023-01-30')
            ]
            
            for comp in computadoras_ejemplo:
                cursor.execute("""
                    INSERT INTO computadoras (nombre, marca, modelo, numero_serie, ubicacion, estado, fecha_adquisicion) 
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, comp)
            
            print("✅ Computadoras de ejemplo creadas")
        else:
            print("ℹ️  Las computadoras ya existen")
        
        # Crear índices
        print("🔍 Creando índices...")
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_computadoras_estado ON computadoras(estado)")
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_computadoras_ubicacion ON computadoras(ubicacion)")
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_usuarios_correo ON usuarios(correo)")
        print("✅ Índices creados")
        
        # Confirmar cambios
        connection.commit()
        cursor.close()
        connection.close()
        
        print("\n🎉 ¡Base de datos configurada exitosamente!")
        print("📱 Usuarios disponibles:")
        print("   Admin: admin@escuela.com / admin123")
        print("   Usuario: usuario@escuela.com / user123")
        
        return True
        
    except Error as e:
        print(f"❌ Error configurando base de datos: {e}")
        return False

def verificar_configuracion():
    """Verifica que la base de datos esté configurada correctamente"""
    try:
        from app import get_db_connection
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Verificar tablas
        cursor.execute("SHOW TABLES")
        tablas = [row[0] for row in cursor.fetchall()]
        
        if 'usuarios' in tablas and 'computadoras' in tablas:
            print("✅ Base de datos configurada correctamente")
            
            # Verificar datos
            cursor.execute("SELECT COUNT(*) FROM usuarios")
            usuarios_count = cursor.fetchone()[0]
            cursor.execute("SELECT COUNT(*) FROM computadoras")
            computadoras_count = cursor.fetchone()[0]
            
            print(f"📊 Usuarios: {usuarios_count}")
            print(f"📊 Computadoras: {computadoras_count}")
            
            cursor.close()
            conn.close()
            return True
        else:
            print("❌ Faltan tablas en la base de datos")
            return False
            
    except Exception as e:
        print(f"❌ Error verificando configuración: {e}")
        return False

def main():
    """Función principal"""
    print("🔧 Configurador de Base de Datos - Inventario Escolar")
    print("=" * 60)
    
    # Verificar si MySQL está disponible
    if not conectar_mysql_sin_db():
        print("\n💡 Asegúrate de que:")
        print("   - MySQL esté instalado y ejecutándose")
        print("   - Las credenciales sean correctas")
        print("   - El usuario 'root' tenga permisos")
        return
    
    # Verificar configuración actual
    if verificar_configuracion():
        print("\n✅ La base de datos ya está configurada")
        respuesta = input("¿Quieres recrear la base de datos? (s/N): ").lower()
        if respuesta != 's':
            print("👋 Configuración mantenida")
            return
    
    # Crear base de datos
    print("\n🚀 Configurando base de datos...")
    if crear_base_datos():
        print("\n🎯 ¡Configuración completada!")
        print("🌐 Ahora puedes ejecutar: python run_app.py")
    else:
        print("\n❌ Error en la configuración")

if __name__ == '__main__':
    main() 