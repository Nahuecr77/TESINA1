@echo off
chcp 65001 >nul
title Sistema de Inventario Escolar

echo.
echo ========================================
echo    SISTEMA DE INVENTARIO ESCOLAR
echo ========================================
echo.

:: Verificar si existe el entorno virtual
if exist ".venv\Scripts\activate.bat" (
    echo [INFO] Activando entorno virtual...
    call .venv\Scripts\activate.bat
) else (
    echo [INFO] No se encontró entorno virtual, usando Python del sistema
)

:: Verificar si Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python no está instalado o no está en el PATH
    echo [INFO] Descarga Python desde: https://python.org
    pause
    exit /b 1
)

:: Verificar si existe el archivo app.py
if not exist "app.py" (
    echo [ERROR] No se encontró el archivo app.py
    pause
    exit /b 1
)

:: Verificar si existe el archivo database_script.sql
if not exist "database_script.sql" (
    echo [WARNING] No se encontró database_script.sql
    echo [INFO] Asegúrate de crear la base de datos manualmente
) else (
    echo [INFO] Script de base de datos encontrado
    echo [INFO] Para crear la base de datos ejecuta:
    echo [INFO] mysql -u root -p ^< database_script.sql
)

echo.
echo [INFO] Iniciando aplicación...
echo [INFO] La aplicación estará disponible en: http://localhost:5000
echo [INFO] Usuarios de prueba:
echo [INFO]   Admin: admin@escuela.com / admin123
echo [INFO]   Usuario: usuario@escuela.com / user123
echo.
echo [INFO] Presiona Ctrl+C para detener la aplicación
echo ========================================
echo.

:: Ejecutar la aplicación
python run_app.py

echo.
echo [INFO] Aplicación detenida
pause 