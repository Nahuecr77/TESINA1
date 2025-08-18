#!/usr/bin/env python3
"""
Script para ejecutar la aplicación de inventario escolar
Autor: Sistema de Inventario Escolar
Fecha: 2024
"""

import os
import sys
import subprocess
from app import app

def verificar_dependencias():
    """Verifica que todas las dependencias estén instaladas"""
    dependencias = [
        'flask',
        'mysql-connector-python',
        'werkzeug'
    ]
    
    print("🔍 Verificando dependencias...")
    for dep in dependencias:
        try:
            __import__(dep.replace('-', '_'))
            print(f"✅ {dep} - OK")
        except ImportError:
            print(f"❌ {dep} - NO INSTALADO")
            return False
    return True

def verificar_mysql():
    """Verifica la conexión a MySQL"""
    try:
        from app import get_db_connection
        conn = get_db_connection()
        conn.close()
        print("✅ Conexión a MySQL - OK")
        return True
    except Exception as e:
        print(f"❌ Error de conexión a MySQL: {e}")
        print("💡 Asegúrate de que:")
        print("   - MySQL esté ejecutándose")
        print("   - Las credenciales en app.py sean correctas")
        print("   - La base de datos 'inventario' exista")
        return False

def instalar_dependencias():
    """Instala las dependencias faltantes"""
    print("📦 Instalando dependencias...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", 
                             "flask", "mysql-connector-python", "werkzeug"])
        print("✅ Dependencias instaladas correctamente")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Error instalando dependencias: {e}")
        return False

def ejecutar_base_datos():
    """Ejecuta el script de base de datos"""
    print("🗄️  Verificando base de datos...")
    if os.path.exists('database_script.sql'):
        print("📄 Script de base de datos encontrado")
        print("💡 Para crear la base de datos, ejecuta:")
        print("   mysql -u root -p < database_script.sql")
    else:
        print("❌ No se encontró database_script.sql")

def main():
    """Función principal del script"""
    print("🚀 Iniciando Sistema de Inventario Escolar")
    print("=" * 50)
    
    # Verificar dependencias
    if not verificar_dependencias():
        print("\n🔧 Intentando instalar dependencias...")
        if not instalar_dependencias():
            print("❌ No se pudieron instalar las dependencias")
            return
    
    # Verificar MySQL
    if not verificar_mysql():
        ejecutar_base_datos()
        print("\n❌ No se puede conectar a MySQL")
        print("💡 Verifica la configuración y vuelve a intentar")
        return
    
    print("\n✅ Todo listo para ejecutar la aplicación")
    print("🌐 La aplicación estará disponible en: http://localhost:5000")
    print("📱 Usuarios de prueba:")
    print("   Admin: admin@escuela.com / admin123")
    print("   Usuario: usuario@escuela.com / user123")
    print("\n⏹️  Presiona Ctrl+C para detener la aplicación")
    print("=" * 50)
    
    # Ejecutar la aplicación
    try:
        app.run(
            host='0.0.0.0',  # Permite acceso desde cualquier IP
            port=5000,       # Puerto por defecto
            debug=True,      # Modo debug para desarrollo
            threaded=True    # Soporte para múltiples usuarios
        )
    except KeyboardInterrupt:
        print("\n👋 Aplicación detenida por el usuario")
    except Exception as e:
        print(f"\n❌ Error ejecutando la aplicación: {e}")

if __name__ == '__main__':
    main() 