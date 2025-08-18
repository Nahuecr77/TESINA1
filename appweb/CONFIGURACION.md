# Configuración del Sistema de Inventario Escolar

## 🔧 Variables de Entorno

### 1. Crear archivo `.env`

Copia el archivo `env_example.txt` como `.env` y configura las variables:

```bash
copy env_example.txt .env
```

### 2. Variables disponibles

```env
# Clave secreta para sesiones Flask
SECRET_KEY=mi_clave_super_secreta_2024_inventario_escolar_12345_cambiar_en_produccion

# Configuración de la base de datos
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=admin123
DB_NAME=inventario

# Configuración de Flask
FLASK_DEBUG=True
FLASK_HOST=0.0.0.0
FLASK_PORT=5000

# Configuración de logs
LOG_LEVEL=INFO
```

## 🚀 Instalación y Configuración

### 1. Instalar dependencias

```bash
.venv\Scripts\pip.exe install -r requirements.txt
.venv\Scripts\pip.exe install python-dotenv
```

### 2. Configurar base de datos

```bash
.venv\Scripts\python.exe configurar_db.py
```

### 3. Verificar hashes de contraseñas

```bash
.venv\Scripts\python.exe verificar_hashes.py
```

### 4. Ejecutar aplicación

```bash
.venv\Scripts\python.exe app.py
```

## 🔐 Credenciales de Acceso

- **Administrador**: admin@escuela.com / admin123
- **Usuario**: usuario@escuela.com / user123

## ⚠️ Problemas Comunes

### Error: "Invalid hash method ''"

Este error ocurre cuando los hashes de contraseñas en la base de datos están corruptos o vacíos.

**Solución:**
1. Ejecutar el script de verificación: `python verificar_hashes.py`
2. El script corregirá automáticamente los hashes inválidos

### Error de conexión a base de datos

Verificar que:
1. MySQL esté ejecutándose
2. Las credenciales en `.env` sean correctas
3. La base de datos `inventario` exista

## 🔒 Seguridad

### Para desarrollo:
- La clave secreta actual es suficiente
- Usar variables de entorno desde `.env`

### Para producción:
- Cambiar `SECRET_KEY` por una clave más segura
- Usar variables de entorno del sistema
- Configurar `FLASK_DEBUG=False`
- Usar HTTPS

## 📁 Estructura de archivos

```
appweb/
├── .env                    # Variables de entorno (crear desde env_example.txt)
├── app.py                  # Aplicación principal
├── config.py              # Configuración
├── configurar_db.py       # Script de configuración de BD
├── verificar_hashes.py    # Script de verificación de hashes
├── env_example.txt        # Ejemplo de variables de entorno
└── CONFIGURACION.md       # Este archivo
``` 