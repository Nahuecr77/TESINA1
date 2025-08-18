"""
Archivo de configuración para el Sistema de Inventario Escolar
Autor: Sistema de Inventario Escolar
Fecha: 2024
"""

import os
from datetime import timedelta

class Config:
    """Configuración base de la aplicación"""
    
    # Clave secreta para sesiones (cambia esto en producción)
    SECRET_KEY = os.environ.get('SECRET_KEY', 'mi_clave_super_secreta_2024_inventario_escolar_12345')
    
    # Configuración de la base de datos MySQL
    DB_CONFIG = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_USER', 'root'),
        'password': os.environ.get('DB_PASSWORD', 'admin123'),
        'database': os.environ.get('DB_NAME', 'inventario'),
        'charset': 'utf8mb4',
        'collation': 'utf8mb4_unicode_ci'
    }
    
    # Configuración de la aplicación Flask
    DEBUG = os.environ.get('FLASK_DEBUG', 'True').lower() == 'true'
    HOST = os.environ.get('FLASK_HOST', '0.0.0.0')
    PORT = int(os.environ.get('FLASK_PORT', 5000))
    
    # Configuración de sesiones
    PERMANENT_SESSION_LIFETIME = timedelta(hours=24)  # Sesión de 24 horas
    SESSION_COOKIE_SECURE = False  # True en producción con HTTPS
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
    
    # Configuración de seguridad
    WTF_CSRF_ENABLED = True
    WTF_CSRF_TIME_LIMIT = 3600  # 1 hora
    
    # Configuración de archivos
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB máximo
    UPLOAD_FOLDER = 'uploads'
    ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}
    
    # Configuración de paginación
    ITEMS_PER_PAGE = 20
    
    # Configuración de búsqueda
    SEARCH_MIN_LENGTH = 2
    
    # Configuración de notificaciones
    FLASH_MESSAGES_TIMEOUT = 5  # segundos
    
    # Configuración de logs
    LOG_LEVEL = os.environ.get('LOG_LEVEL', 'INFO')
    LOG_FILE = 'app.log'
    
    # Configuración de respaldo
    BACKUP_ENABLED = True
    BACKUP_FOLDER = 'backups'
    BACKUP_RETENTION_DAYS = 30

class DevelopmentConfig(Config):
    """Configuración para desarrollo"""
    DEBUG = True
    DB_CONFIG = {
        'host': 'localhost',
        'user': 'root',
        'password': 'admin123',
        'database': 'inventario_dev'
    }

class ProductionConfig(Config):
    """Configuración para producción"""
    DEBUG = False
    SECRET_KEY = os.environ.get('SECRET_KEY')  # Debe estar definida en producción
    SESSION_COOKIE_SECURE = True
    DB_CONFIG = {
        'host': os.environ.get('DB_HOST'),
        'user': os.environ.get('DB_USER'),
        'password': os.environ.get('DB_PASSWORD'),
        'database': os.environ.get('DB_NAME')
    }

class TestingConfig(Config):
    """Configuración para pruebas"""
    TESTING = True
    DB_CONFIG = {
        'host': 'localhost',
        'user': 'root',
        'password': 'admin123',
        'database': 'inventario_test'
    }

# Diccionario de configuraciones
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}

def get_config():
    """Obtiene la configuración según el entorno"""
    env = os.environ.get('FLASK_ENV', 'development')
    return config.get(env, config['default'])

# Información de la aplicación
APP_INFO = {
    'name': 'Sistema de Inventario Escolar',
    'version': '1.0.0',
    'description': 'Sistema web para gestión de inventario de computadoras en instituciones educativas',
    'author': 'Sistema de Inventario Escolar',
    'contact': 'admin@escuela.com'
}

# Estados de computadoras disponibles
ESTADOS_COMPUTADORA = [
    'disponible',
    'en uso', 
    'mantenimiento',
    'baja'
]

# Roles de usuario disponibles
ROLES_USUARIO = [
    'admin',
    'usuario'
]

# Ubicaciones comunes
UBICACIONES_COMUNES = [
    'Laboratorio 1',
    'Laboratorio 2', 
    'Laboratorio 3',
    'Oficina Administrativa',
    'Biblioteca',
    'Sala de Profesores',
    'Dirección',
    'Secretaría',
    'Aula 101',
    'Aula 102',
    'Aula 103',
    'Sala de Informática',
    'Taller de Computación'
]

# Marcas comunes de computadoras
MARCAS_COMUNES = [
    'Dell',
    'HP',
    'Lenovo',
    'Acer',
    'Asus',
    'Apple',
    'Samsung',
    'Toshiba',
    'Sony',
    'Gateway',
    'Compaq',
    'IBM'
] 