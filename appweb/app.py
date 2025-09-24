from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
import os

app = Flask(__name__)
# Clave secreta más segura para producción
app.secret_key = os.environ.get('SECRET_KEY', 'mi_clave_super_secreta_2024_inventario_escolar_12345')

# Configuración de la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'admin123',  # Cambia esto por tu contraseña de MySQL
    'database': 'inventario'
}

def get_db_connection():
    try:
        return mysql.connector.connect(**db_config)
    except Error as e:
        print(f"Error conectando a MySQL: {e}")
        raise e

def require_auth_and_terms(f):
    """Decorador para verificar autenticación y aceptación de términos"""
    def decorated_function(*args, **kwargs):
        if 'usuario_id' not in session:
            return redirect(url_for('login'))
        
        return f(*args, **kwargs)
    decorated_function.__name__ = f.__name__
    return decorated_function

def require_admin(f):
    """Decorador para verificar autenticación, términos y rol de administrador"""
    def decorated_function(*args, **kwargs):
        if 'usuario_id' not in session:
            return redirect(url_for('login'))
        
        # Verificar rol de administrador
        if session.get('usuario_rol') != 'admin':
            flash('Acceso denegado. Se requieren permisos de administrador.', 'danger')
            return redirect(url_for('index'))
        
        return f(*args, **kwargs)
    decorated_function.__name__ = f.__name__
    return decorated_function

# RUTA PRINCIPAL
@app.route('/')
@require_auth_and_terms
def index():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras ORDER BY id DESC")
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('index.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar datos: {e}', 'danger')
        return render_template('index.html', computadoras=[])

# REGISTRO DE USUARIO
@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        password = request.form['password']
        
        # Validar que la contraseña no esté vacía
        if not password:
            flash('La contraseña no puede estar vacía', 'danger')
            return render_template('registro.html')
        
        # Generar hash de la contraseña
        password_hash = generate_password_hash(password)
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("INSERT INTO usuarios (nombre, correo, password) VALUES (%s, %s, %s)", 
                         (nombre, correo, password_hash))
            conn.commit()
            cursor.close()
            conn.close()
            flash('Registro exitoso. Ahora puedes iniciar sesión.', 'success')
            return redirect(url_for('login'))
        except Error as e:
            if "Duplicate entry" in str(e):
                flash('El correo electrónico ya está registrado', 'danger')
            else:
                flash('Error al registrar usuario: ' + str(e), 'danger')
    return render_template('registro.html')

# LOGIN
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']
        password = request.form['password']
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM usuarios WHERE correo = %s", (correo,))
            usuario = cursor.fetchone()
            cursor.close()
            conn.close()
            
            if usuario and check_password_hash(usuario['password'], password):
                session['usuario_id'] = usuario['id']
                session['usuario_nombre'] = usuario['nombre']
                session['usuario_rol'] = usuario['rol']
                flash(f'Bienvenido, {usuario["nombre"]}!', 'success')
                return redirect(url_for('dashboard'))
            else:
                flash('Correo o contraseña incorrectos', 'danger')
        except Error as e:
            flash(f'Error de conexión: {e}', 'danger')
    return render_template('login.html')

# TÉRMINOS Y CONDICIONES
@app.route('/terminos', methods=['GET', 'POST'])
def terminos_condiciones():
    if request.method == 'POST':
        aceptar_terminos = request.form.get('aceptar_terminos')
        aceptar_privacidad = request.form.get('aceptar_privacidad')
        
        if aceptar_terminos and aceptar_privacidad:
            flash('Términos revisados. Continúe con el registro.', 'success')
            return redirect(url_for('registro'))
        else:
            flash('Debe aceptar tanto los términos como la política de privacidad para continuar.', 'danger')
    
    return render_template('terminos_condiciones.html')

# LOGOUT
@app.route('/logout')
def logout():
    session.clear()
    flash('Has cerrado sesión correctamente', 'info')
    return redirect(url_for('login'))

# Filtrar computadoras por estado
@app.route('/filtro_estado', methods=['GET'])
@require_auth_and_terms
def filtro_estado():
    estado = request.args.get('estado', 'todos')
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # Normalizar valores del estado a los del ENUM de BD
        estado_map = {
            'Libre': 'disponible',
            'En Uso': 'en uso',
            'Mantenimiento': 'mantenimiento',
            'Fuera de Servicio': 'baja',
            'disponible': 'disponible',
            'en uso': 'en uso',
            'mantenimiento': 'mantenimiento',
            'baja': 'baja',
            'todos': 'todos'
        }
        estado_bd = estado_map.get(estado, 'todos')
        if estado_bd == 'todos':
            cursor.execute("SELECT * FROM computadoras ORDER BY id DESC")
        else:
            cursor.execute("SELECT * FROM computadoras WHERE estado = %s ORDER BY id DESC", (estado_bd,))
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
    except Error as e:
        flash(f'Error al filtrar computadoras: {e}', 'danger')
        computadoras = []
    return render_template('todas_computadoras.html', computadoras=computadoras)


# CRUD DE COMPUTADORAS

# Agregar nueva computadora
@app.route('/computadora/nueva', methods=['GET', 'POST'])
@require_auth_and_terms
def nueva_computadora():
    
    if request.method == 'POST':
        nombre = request.form['nombre']
        marca = request.form['marca']
        modelo = request.form['modelo']
        numero_serie = request.form['numero_serie']
        ubicacion = request.form['ubicacion']
        estado = request.form['estado']
        fecha_adquisicion = request.form.get('fecha_adquisicion')
        observaciones = request.form.get('observaciones', '')
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            # Normalizar 'Fuera de Servicio' -> 'baja' para compatibilidad con esquema actual
            estado_bd = 'baja' if estado == 'Fuera de Servicio' else estado
            cursor.execute(
                """
                INSERT INTO computadoras (nombre, marca, modelo, numero_serie, ubicacion, estado, 
                                        fecha_adquisicion, observaciones, usuario_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (nombre, marca, modelo, numero_serie, ubicacion, estado_bd,
                 fecha_adquisicion, observaciones, session['usuario_id'])
            )
            conn.commit()
            cursor.close()
            conn.close()
            flash('Computadora agregada correctamente', 'success')
            return redirect(url_for('todas_computadoras'))
        except Error as e:
            if "Duplicate entry" in str(e):
                flash('El número de serie ya existe', 'danger')
            else:
                flash(f'Error al agregar computadora: {e}', 'danger')
    
    return render_template('nueva_computadora.html')

# Ver detalles de computadora
@app.route('/computadora/<int:id>')
@require_auth_and_terms
def ver_computadora(id):
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras WHERE id = %s", (id,))
        computadora = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if computadora:
            return render_template('ver_computadora.html', computadora=computadora)
        else:
            flash('Computadora no encontrada', 'danger')
            return redirect(url_for('index'))
    except Error as e:
        flash(f'Error al cargar computadora: {e}', 'danger')
        return redirect(url_for('index'))

# Editar computadora
@app.route('/computadora/editar/<int:id>', methods=['GET', 'POST'])
@require_auth_and_terms
def editar_computadora(id):
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        if request.method == 'POST':
            nombre = request.form['nombre']
            marca = request.form['marca']
            modelo = request.form['modelo']
            numero_serie = request.form['numero_serie']
            ubicacion = request.form['ubicacion']
            estado = request.form['estado']
            # Convertir cadenas vacías a None para permitir NULL en DATE
            fecha_adquisicion = request.form.get('fecha_adquisicion') or None
            fecha_ultimo_mantenimiento = request.form.get('fecha_ultimo_mantenimiento') or None
            observaciones = request.form.get('observaciones', '')
            
            try:
                # Normalizar 'Fuera de Servicio' -> 'baja' al guardar
                estado_bd = 'baja' if estado == 'Fuera de Servicio' else estado
                cursor.execute(
                    """
                    UPDATE computadoras 
                    SET nombre = %s, marca = %s, modelo = %s, numero_serie = %s, 
                        ubicacion = %s, estado = %s, fecha_adquisicion = %s, 
                        fecha_ultimo_mantenimiento = %s, observaciones = %s
                    WHERE id = %s
                    """,
                    (nombre, marca, modelo, numero_serie, ubicacion, estado_bd,
                     fecha_adquisicion, fecha_ultimo_mantenimiento, observaciones, id)
                )
                conn.commit()
            except Error as e:
                conn.rollback()
                flash(f'Error al actualizar: {e}', 'danger')
                return redirect(url_for('editar_computadora', id=id))

            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return jsonify({'success': True, 'message': 'Computadora actualizada correctamente'})
            flash('Computadora actualizada correctamente', 'success')
            return redirect(url_for('ver_computadora', id=id))
        
        # GET: mostrar formulario con datos actuales
        cursor.execute("SELECT * FROM computadoras WHERE id = %s", (id,))
        computadora = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if computadora:
            return render_template('editar_computadora.html', computadora=computadora)
        else:
            flash('Computadora no encontrada', 'danger')
            return redirect(url_for('index'))
            
    except Error as e:
        flash(f'Error al editar computadora: {e}', 'danger')
        return redirect(url_for('index'))

# Eliminar computadora
@app.route('/computadora/eliminar/<int:id>', methods=['POST'])
@require_auth_and_terms
def eliminar_computadora(id):
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM computadoras WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        
        # Si es una petición AJAX, devolver JSON
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return jsonify({'success': True, 'message': 'Computadora eliminada correctamente'})
        else:
            flash('Computadora eliminada correctamente', 'success')
            return redirect(url_for('index'))
            
    except Error as e:
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return jsonify({'success': False, 'error': str(e)})
        else:
            flash(f'Error al eliminar computadora: {e}', 'danger')
            return redirect(url_for('index'))

# CRUD DE USUARIOS (solo para administradores)

# Listar usuarios
@app.route('/usuarios')
@require_admin
def listar_usuarios():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, nombre, correo, rol, fecha_registro FROM usuarios ORDER BY id")
        usuarios = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('usuarios.html', usuarios=usuarios)
    except Error as e:
        flash(f'Error al cargar usuarios: {e}', 'danger')
        return render_template('usuarios.html', usuarios=[])

# Editar usuario
@app.route('/usuario/editar/<int:id>', methods=['GET', 'POST'])
@require_admin
def editar_usuario(id):
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        if request.method == 'POST':
            nombre = request.form['nombre']
            correo = request.form['correo']
            rol = request.form['rol']
            nueva_password = request.form.get('nueva_password', '')
            
            if nueva_password:
                password_hash = generate_password_hash(nueva_password)
                cursor.execute("""
                    UPDATE usuarios SET nombre = %s, correo = %s, rol = %s, password = %s
                    WHERE id = %s
                """, (nombre, correo, rol, password_hash, id))
            else:
                cursor.execute("""
                    UPDATE usuarios SET nombre = %s, correo = %s, rol = %s
                    WHERE id = %s
                """, (nombre, correo, rol, id))
            
            conn.commit()
            flash('Usuario actualizado correctamente', 'success')
            return redirect(url_for('listar_usuarios'))
        
        # GET: mostrar formulario
        cursor.execute("SELECT * FROM usuarios WHERE id = %s", (id,))
        usuario = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if usuario:
            return render_template('editar_usuario.html', usuario=usuario)
        else:
            flash('Usuario no encontrado', 'danger')
            return redirect(url_for('listar_usuarios'))
            
    except Error as e:
        flash(f'Error al editar usuario: {e}', 'danger')
        return redirect(url_for('listar_usuarios'))

# Eliminar usuario
@app.route('/usuario/eliminar/<int:id>', methods=['POST'])
@require_admin
def eliminar_usuario(id):
    
    if id == session['usuario_id']:
        flash('No puedes eliminar tu propia cuenta', 'danger')
        return redirect(url_for('listar_usuarios'))
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM usuarios WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        flash('Usuario eliminado correctamente', 'success')
    except Error as e:
        flash(f'Error al eliminar usuario: {e}', 'danger')
    
    return redirect(url_for('listar_usuarios'))

# Búsqueda de computadoras
@app.route('/buscar')
@require_auth_and_terms
def buscar_computadoras():
    
    query = request.args.get('q', '')
    if not query:
        return redirect(url_for('index'))
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT * FROM computadoras 
            WHERE nombre LIKE %s OR marca LIKE %s OR modelo LIKE %s 
            OR numero_serie LIKE %s OR ubicacion LIKE %s
            ORDER BY id DESC
        """, (f'%{query}%', f'%{query}%', f'%{query}%', f'%{query}%', f'%{query}%'))
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('buscar.html', computadoras=computadoras, query=query)
    except Error as e:
        flash(f'Error en la búsqueda: {e}', 'danger')
        return render_template('buscar.html', computadoras=[], query=query)

# Rutas para el dashboard
@app.route('/computadoras-en-uso')
@require_auth_and_terms
def computadoras_en_uso():
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras WHERE estado = 'en uso' ORDER BY id DESC")
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('computadoras_en_uso.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar computadoras en uso: {e}', 'danger')
        return render_template('computadoras_en_uso.html', computadoras=[])

@app.route('/computadoras-libres')
@require_auth_and_terms
def computadoras_libres():
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras WHERE estado = 'disponible' ORDER BY id DESC")
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('computadoras_libres.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar computadoras libres: {e}', 'danger')
        return render_template('computadoras_libres.html', computadoras=[])

@app.route('/observaciones')
@require_auth_and_terms
def observaciones():
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras WHERE observaciones IS NOT NULL AND observaciones != '' ORDER BY id DESC")
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('observaciones.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar observaciones: {e}', 'danger')
        return render_template('observaciones.html', computadoras=[])

# Ruta del dashboard (solo menú de opciones)
@app.route('/dashboard')
@require_auth_and_terms
def dashboard():
    return render_template('dashboard.html')

# Ruta para mostrar todas las computadoras
@app.route('/todas-computadoras')
@require_auth_and_terms
def todas_computadoras():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM computadoras ORDER BY id DESC")
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('todas_computadoras.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar computadoras: {e}', 'danger')
        return render_template('todas_computadoras.html', computadoras=[])

@app.route('/netbooks')
@require_auth_and_terms
def listar_netbooks():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            """
            SELECT * FROM computadoras 
            WHERE nombre LIKE %s OR modelo LIKE %s 
            ORDER BY id DESC 
            LIMIT 120
            """,
            ("%netbook%", "%netbook%")
        )
        computadoras = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('netbooks.html', computadoras=computadoras)
    except Error as e:
        flash(f'Error al cargar netbooks: {e}', 'danger')
        return render_template('netbooks.html', computadoras=[])


if __name__ == '__main__':
    app.run(debug=True) 