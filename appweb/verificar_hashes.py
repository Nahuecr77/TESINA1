#!/usr/bin/env python3
"""
Script para verificar y corregir hashes de contraseñas en la base de datos
"""

import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash, check_password_hash
from dotenv import load_dotenv
import os

# Cargar variables de entorno
load_dotenv()

def get_db_connection():
    """Conectar a la base de datos"""
    db_config = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_USER', 'root'),
        'password': os.environ.get('DB_PASSWORD', 'admin123'),
        'database': os.environ.get('DB_NAME', 'inventario')
    }
    return mysql.connector.connect(**db_config)

def verificar_hashes():
    """Verificar y corregir hashes de contraseñas"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Obtener todos los usuarios
        cursor.execute("SELECT id, nombre, correo, password FROM usuarios")
        usuarios = cursor.fetchall()
        
        print(f"🔍 Verificando {len(usuarios)} usuarios...")
        
        for usuario in usuarios:
            print(f"\n📋 Usuario: {usuario['nombre']} ({usuario['correo']})")
            print(f"   Hash actual: {usuario['password'][:50]}...")
            
            # Verificar si el hash está vacío o mal formateado
            if not usuario['password'] or usuario['password'].strip() == '':
                print("   ❌ Hash vacío detectado")
                
                # Generar nuevo hash basado en el correo (temporal)
                nueva_password = 'admin123' if 'admin' in usuario['correo'] else 'user123'
                nuevo_hash = generate_password_hash(nueva_password)
                
                # Actualizar en la base de datos
                cursor.execute("UPDATE usuarios SET password = %s WHERE id = %s", 
                             (nuevo_hash, usuario['id']))
                print(f"   ✅ Hash corregido con contraseña: {nueva_password}")
                
            else:
                # Verificar si el hash es válido
                try:
                    # Intentar verificar con una contraseña de prueba
                    test_password = 'admin123' if 'admin' in usuario['correo'] else 'user123'
                    if check_password_hash(usuario['password'], test_password):
                        print("   ✅ Hash válido")
                    else:
                        print("   ⚠️  Hash no coincide con contraseña esperada")
                except Exception as e:
                    print(f"   ❌ Hash inválido: {e}")
                    # Corregir hash inválido
                    nueva_password = 'admin123' if 'admin' in usuario['correo'] else 'user123'
                    nuevo_hash = generate_password_hash(nueva_password)
                    cursor.execute("UPDATE usuarios SET password = %s WHERE id = %s", 
                                 (nuevo_hash, usuario['id']))
                    print(f"   ✅ Hash corregido con contraseña: {nueva_password}")
        
        # Confirmar cambios
        conn.commit()
        cursor.close()
        conn.close()
        
        print("\n🎉 Verificación completada")
        print("\n📱 Credenciales de acceso:")
        print("   Admin: admin@escuela.com / admin123")
        print("   Usuario: usuario@escuela.com / user123")
        
    except Error as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    print("🔧 Verificador de Hashes de Contraseñas")
    print("=" * 50)
    verificar_hashes() 