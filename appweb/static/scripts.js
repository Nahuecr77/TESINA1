// Scripts para el Sistema de Inventario Escolar

// Función para mostrar mensajes de confirmación
function confirmarAccion(mensaje) {
    return confirm(mensaje);
}

// Función para validar formularios
function validarFormulario(formulario) {
    const campos = formulario.querySelectorAll('input[required]');
    let valido = true;
    
    campos.forEach(campo => {
        if (!campo.value.trim()) {
            campo.style.borderColor = '#ff4444';
            valido = false;
        } else {
            campo.style.borderColor = '#ddd';
        }
    });
    
    return valido;
}

// Función para mostrar/ocultar contraseña
function togglePassword(inputId) {
    const input = document.getElementById(inputId);
    const icon = document.querySelector(`[onclick="togglePassword('${inputId}')"]`);
    
    if (input.type === 'password') {
        input.type = 'text';
        icon.innerHTML = '👁️';
    } else {
        input.type = 'password';
        icon.innerHTML = '👁️‍🗨️';
    }
}

// Función para búsqueda en tiempo real
function buscarEnTiempoReal(input, tablaId) {
    const filtro = input.value.toLowerCase();
    const tabla = document.getElementById(tablaId);
    const filas = tabla.getElementsByTagName('tr');
    
    for (let i = 1; i < filas.length; i++) {
        const celdas = filas[i].getElementsByTagName('td');
        let mostrar = false;
        
        for (let j = 0; j < celdas.length; j++) {
            const texto = celdas[j].textContent || celdas[j].innerText;
            if (texto.toLowerCase().indexOf(filtro) > -1) {
                mostrar = true;
                break;
            }
        }
        
        filas[i].style.display = mostrar ? '' : 'none';
    }
}

// Función para formatear fechas
function formatearFecha(fecha) {
    if (!fecha) return 'N/A';
    const d = new Date(fecha);
    return d.toLocaleDateString('es-ES');
}

// Función para mostrar loading
function mostrarLoading() {
    const loading = document.createElement('div');
    loading.id = 'loading';
    loading.innerHTML = `
        <div style="
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        ">
            <div style="
                background: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
            ">
                <div style="
                    width: 40px;
                    height: 40px;
                    border: 4px solid #f3f3f3;
                    border-top: 4px solid #3498db;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                    margin: 0 auto 10px;
                "></div>
                <p>Cargando...</p>
            </div>
        </div>
        <style>
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
    `;
    document.body.appendChild(loading);
}

// Función para ocultar loading
function ocultarLoading() {
    const loading = document.getElementById('loading');
    if (loading) {
        loading.remove();
    }
}

// Función para mostrar notificaciones
function mostrarNotificacion(mensaje, tipo = 'info') {
    const notificacion = document.createElement('div');
    notificacion.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 5px;
        color: white;
        font-weight: bold;
        z-index: 10000;
        animation: slideIn 0.3s ease-out;
    `;
    
    const colores = {
        'success': '#28a745',
        'error': '#dc3545',
        'warning': '#ffc107',
        'info': '#17a2b8'
    };
    
    notificacion.style.backgroundColor = colores[tipo] || colores.info;
    notificacion.textContent = mensaje;
    
    document.body.appendChild(notificacion);
    
    setTimeout(() => {
        notificacion.style.animation = 'slideOut 0.3s ease-in';
        setTimeout(() => notificacion.remove(), 300);
    }, 3000);
}

// Agregar estilos CSS para animaciones
const estilos = document.createElement('style');
estilos.textContent = `
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
`;
document.head.appendChild(estilos);

// Inicialización cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', function() {
    console.log('Sistema de Inventario Escolar - JavaScript cargado');
    
    // Agregar validación a formularios
    const formularios = document.querySelectorAll('form');
    formularios.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validarFormulario(this)) {
                e.preventDefault();
                mostrarNotificacion('Por favor, completa todos los campos requeridos', 'warning');
            }
        });
    });
    
    // Agregar confirmación a enlaces de eliminación
    const enlacesEliminar = document.querySelectorAll('a[href*="eliminar"], button[onclick*="eliminar"]');
    enlacesEliminar.forEach(enlace => {
        enlace.addEventListener('click', function(e) {
            if (!confirmarAccion('¿Estás seguro de que quieres eliminar este elemento?')) {
                e.preventDefault();
            }
        });
    });
}); 