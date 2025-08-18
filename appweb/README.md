# 🏫 Sistema de Inventario Escolar

Sistema web completo para la gestión de inventario de computadoras en instituciones educativas.

## 📋 Características

- ✅ **Gestión de Usuarios**: Registro, login y sistema de roles (admin/usuario)
- ✅ **CRUD de Computadoras**: Crear, leer, actualizar y eliminar equipos
- ✅ **Búsqueda Avanzada**: Buscar por nombre, marca, modelo, ubicación, etc.
- ✅ **Dashboard**: Estadísticas y reportes del inventario
- ✅ **Sistema de Sesiones**: Seguridad y control de acceso
- ✅ **Base de Datos MySQL**: Almacenamiento robusto y escalable
- ✅ **Interfaz Responsiva**: Diseño moderno y fácil de usar

## 🚀 Instalación Rápida

### 1. Requisitos Previos
- Python 3.7 o superior
- MySQL 5.7 o superior
- Git (opcional)

### 2. Clonar/Descargar el Proyecto
```bash
git clone <url-del-repositorio>
cd appweb
```

### 3. Configurar Base de Datos
```bash
# Opción A: Script automático (recomendado)
python configurar_db.py

# Opción B: Manual
mysql -u root -p < database_script.sql
```

### 4. Instalar Dependencias
```bash
pip install flask mysql-connector-python werkzeug
```

### 5. Ejecutar la Aplicación
```bash
# Opción A: Script automático (recomendado)
python run_app.py

# Opción B: Script batch (Windows)
ejecutar_app.bat

# Opción C: Directo
python app.py
```

## 📱 Acceso al Sistema

Una vez ejecutada la aplicación, accede a:
- **URL**: http://localhost:5000
- **Admin**: admin@escuela.com / admin123
- **Usuario**: usuario@escuela.com / user123

## 🔧 Configuración

### Variables de Entorno (Opcional)
Crea un archivo `.env` en la raíz del proyecto:

```env
# Base de Datos
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña
DB_NAME=inventario

# Flask
FLASK_ENV=development
FLASK_DEBUG=True
SECRET_KEY=tu_clave_secreta_muy_segura

# Logs
LOG_LEVEL=INFO
```

### Configuración de MySQL
Edita las credenciales en `app.py` o `config.py`:

```python
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'tu_contraseña',  # Cambia esto
    'database': 'inventario'
}
```

## 📁 Estructura del Proyecto

```
appweb/
├── app.py                 # Aplicación principal Flask
├── config.py              # Configuraciones centralizadas
├── run_app.py             # Script de ejecución principal
├── configurar_db.py       # Script de configuración de BD
├── ejecutar_app.bat       # Script batch para Windows
├── database_script.sql    # Script SQL de la base de datos
├── README.md              # Este archivo
├── templates/             # Plantillas HTML
├── static/                # Archivos estáticos (CSS, JS, imágenes)
└── .venv/                 # Entorno virtual (si existe)
```

## 🛠️ Scripts Disponibles

### `run_app.py`
Script principal que:
- ✅ Verifica dependencias
- ✅ Comprueba conexión a MySQL
- ✅ Instala dependencias faltantes
- ✅ Ejecuta la aplicación con configuración optimizada

### `configurar_db.py`
Script de configuración de base de datos que:
- ✅ Crea la base de datos automáticamente
- ✅ Crea todas las tablas necesarias
- ✅ Inserta datos de ejemplo
- ✅ Configura índices para mejor rendimiento

### `ejecutar_app.bat`
Script batch para Windows que:
- ✅ Activa entorno virtual si existe
- ✅ Verifica Python
- ✅ Ejecuta la aplicación
- ✅ Muestra información útil

## 🔐 Seguridad

### Clave Secreta
La aplicación usa una clave secreta para las sesiones. En producción, cambia la clave en `app.py`:

```python
app.secret_key = 'tu_clave_super_secreta_muy_larga_y_compleja'
```

### Contraseñas
- Las contraseñas se hashean con Werkzeug
- Usa contraseñas fuertes en producción
- Cambia las contraseñas por defecto

### Base de Datos
- Usa un usuario específico para la aplicación (no root)
- Configura permisos mínimos necesarios
- Habilita SSL en producción

## 📊 Funcionalidades

### Para Usuarios Normales
- Ver lista de computadoras
- Buscar equipos
- Ver detalles de computadoras
- Dashboard con estadísticas

### Para Administradores
- Todo lo anterior +
- Gestionar usuarios
- Agregar/editar/eliminar computadoras
- Ver reportes completos
- Configurar el sistema

## 🐛 Solución de Problemas

### Error de Conexión a MySQL
```
Error conectando a MySQL: [Errno 2003] Can't connect to MySQL server
```
**Solución:**
1. Verifica que MySQL esté ejecutándose
2. Confirma las credenciales en `app.py`
3. Asegúrate de que la base de datos exista

### Error de Dependencias
```
ModuleNotFoundError: No module named 'flask'
```
**Solución:**
```bash
pip install flask mysql-connector-python werkzeug
```

### Error de Hash Method
```
ValueError: Invalid hash method ''.
```
**Solución:**
- Verifica que la importación de Werkzeug esté descomentada
- Asegúrate de que las contraseñas no estén vacías

### Puerto en Uso
```
OSError: [Errno 98] Address already in use
```
**Solución:**
- Cambia el puerto en `app.py`: `app.run(port=5001)`
- O detén otros servicios que usen el puerto 5000

## 📈 Próximas Mejoras

- [ ] Exportar reportes a PDF/Excel
- [ ] Sistema de respaldos automáticos
- [ ] Notificaciones por email
- [ ] API REST para integración
- [ ] Módulo de mantenimiento preventivo
- [ ] Sistema de tickets de soporte
- [ ] Dashboard con gráficos interactivos
- [ ] Módulo de auditoría de cambios

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Soporte

- **Email**: admin@escuela.com
- **Issues**: Usa la sección de Issues en GitHub
- **Documentación**: Consulta este README

---

**¡Gracias por usar el Sistema de Inventario Escolar!** 🎓 