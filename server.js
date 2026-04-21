const mysql = require('mysql2');

// 🔥 CONEXIÓN A MYSQL
const conexion = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'admin', // Intentamos con 'root' ya que vacía no funcionó
    database: 'PROCESAMIENTO'
});

conexion.connect(err => {
    if (err) {
        console.log('Error de conexión:', err);
    } else {
        console.log('Conectado a MySQL');
    }
});


const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;



// Ruta principal
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'inicio.html'));
});

// Rutas para estilos e imágenes del inicio (ubicados en la raíz)
app.get('/style.css', (req, res) => {
    res.sendFile(path.join(__dirname, 'style.css'));
});

// Rutas para los estilos e imágenes de la ventana de información
app.get('/inf.css', (req, res) => {
    res.sendFile(path.join(__dirname, 'inf.css'));
});
app.get('/bandera.png', (req, res) => {
    res.sendFile(path.join(__dirname, 'bandera.png'));
});

// Rutas para estadísticas
app.get('/estadisticas.css', (req, res) => {
    res.sendFile(path.join(__dirname, 'estadisticas.css'));
});

// Ruta para la ventana de jugadores
app.get('/jugadores.css', (req, res) => {
    res.sendFile(path.join(__dirname, 'jugadores.css'));
});
console.log("Carpeta de jugadores: ", path.join(__dirname, 'jugadores'));
app.use('/jugadores', express.static(path.join(__dirname, 'jugadores')));

// Permitir acceso a la carpeta 'modelos' (para cargar el mundo.glb)
app.use('/modelos', express.static(path.join(__dirname, 'modelos')));

// Servir archivos estáticos (HTML, CSS, JS, Modelos 3D, .mind files)
app.use(express.static(path.join(__dirname, 'public'), { index: false }));

// API para la trivia
app.get('/api/trivia/:pais', (req, res) => {
    const pais = req.params.pais;
    console.log(`🔎 Buscando trivia para: ${pais}`);

    conexion.query(
        // Forzamos los nombres de columnas a minúsculas y quitamos espacios al país para evitar errores
        'SELECT DISTINCT pregunta AS pregunta, inciso_a AS inciso_a, inciso_b AS inciso_b, respuesta_correcta AS respuesta_correcta FROM preguntas WHERE LOWER(REPLACE(pais_codigo, " ", "")) = LOWER(?)',
        [pais],
        (err, resultados) => {
            if (err) {
                console.log("❌ Error SQL:", err);
                res.status(500).json({ error: 'Error en la base de datos' });
            } else {
                // No es un error si no hay preguntas, solo devolvemos un array vacío
                res.json(resultados);
            }
        }
    );
});


// Ruta para obtener el video desde MySQL (Corregida)
app.get('/api/video/:pais', (req, res) => {
    const paisNombre = req.params.pais;
    const query = 'SELECT youtube_id AS youtube_id FROM videos WHERE LOWER(REPLACE(pais_codigo, " ", "")) = LOWER(?)';

    conexion.query(query, [paisNombre], (err, results) => {
        if (err) {
            console.error("❌ Error en la base de datos:", err);
            return res.status(500).json({ error: "Error interno" });
        }

        if (results && results.length > 0) {
            console.log(`✅ Video encontrado para: ${paisNombre}`);
            // Enviamos el primer resultado encontrado
            res.json(results[0]);
        } else {
            // Si no encuentra el país en la tabla
            console.log(`⚠️ No se encontró video para el país: ${paisNombre}`);
            res.status(404).json({ message: "Video no encontrado" });
        }
    });
});

app.listen(PORT, () => {
    console.log(`Servidor AR corriendo en http://localhost:${PORT}`);
    console.log(`Carpeta de modelos configurada en: ${path.join(__dirname, 'modelos')}`);
    // NOTA: Para probar AR en el móvil, necesitas HTTPS o usar localhost con cable USB.
});