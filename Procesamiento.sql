CREATE DATABASE PROCESAMIENTO;

USE PROCESAMIENTO;

CREATE TABLE IF NOT EXISTS paises (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    color VARCHAR(50),
    modelo VARCHAR(150),
    bandera VARCHAR(150)
);

INSERT INTO paises (codigo, nombre, color, modelo, bandera) VALUES
('mexico', 'México', 'green', 'modelos/mexico.glb', 'imagenes/mexico.png'),
('japon', 'Japón', 'white', 'modelos/japon.glb', 'imagenes/japon.png'),
('espana', 'España', 'red', 'modelos/espana.glb', 'imagenes/espana.png'),
('uruguay', 'Uruguay', 'blue', 'modelos/uruguay.glb', 'imagenes/uruguay.png'),
('colombia', 'Colombia', 'yellow', 'modelos/colombia.glb', 'imagenes/colombia.png'),
('coreadelsur', 'Corea del Sur', 'white', 'modelos/coreadelsur.glb', 'imagenes/coreadelsur.png'),
('paisesbajos', 'Países Bajos', 'orange', 'modelos/paisesbajos.glb', 'imagenes/paisesbajos.png'),
('sudafrica', 'Sudáfrica', 'yellow', 'modelos/sudafrica.glb', 'imagenes/sudafrica.png'),
('tunez', 'Túnez', 'red', 'modelos/tunez.glb', 'imagenes/tunez.png'),
('uzbekistan', 'Uzbekistán', 'blue', 'modelos/uzbekistan.glb', 'imagenes/uzbekistan.png');

CREATE TABLE IF NOT EXISTS preguntas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais_codigo VARCHAR(50) NOT NULL, 
    pregunta TEXT NOT NULL,
    inciso_a VARCHAR(255) NOT NULL,
    inciso_b VARCHAR(255) NOT NULL,
    respuesta_correcta CHAR(1) NOT NULL,
    -- Esto crea el vínculo oficial entre las dos tablas:
    CONSTRAINT fk_pais_trivia FOREIGN KEY (pais_codigo) REFERENCES paises(codigo)
);

INSERT INTO preguntas (pais_codigo, pregunta, inciso_a, inciso_b, respuesta_correcta) VALUES
('mexico', '¿En qué año México organizó su primer Mundial?', '1970', '1986', 'A'),
('mexico', '¿Quién es el máximo goleador histórico de la Selección Mexicana?', 'Javier Hernández', 'Cuauhtémoc Blanco', 'A'),
('japon', '¿Cuál es el apodo de la Selección de Japón?', 'Samuráis Blue', 'Tigres de Asia', 'A'),
('japon', '¿En qué año organizó Japón el Mundial junto a Corea?', '1998', '2002', 'B'),
('espana', '¿En qué año ganó España su primer Mundial?', '2006', '2010', 'B'),
('espana', '¿Quién anotó el gol de la victoria en la final del Mundial 2010?', 'Andrés Iniesta', 'Xavi Hernández', 'A'),
('uruguay', '¿Cuántos Mundiales ha ganado Uruguay en total?', '1', '2', 'B'),
('uruguay', '¿Cómo se le conoce al famoso triunfo de Uruguay en Brasil 1950?', 'Maracanazo', 'Centenariazo', 'A'),
('colombia', '¿Quién es el máximo goleador de Colombia en un solo Mundial?', 'James Rodríguez', 'Radamel Falcao', 'A'),
('colombia', '¿Cuál es el apodo de la Selección Colombiana?', 'La Tricolor', 'La Cafetera', 'B'),
('coreadelsur', '¿Cuál fue la mejor posición de Corea en un Mundial?', '4to Lugar', '8vo Lugar', 'A'),
('coreadelsur', '¿Qué jugador coreano brilla actualmente en el Tottenham?', 'Son Heung-min', 'Park Ji-sung', 'A'),
('paisesbajos', '¿Cómo apodan a la Selección de los Países Bajos?', 'La Naranja Mecánica', 'El Reloj Holandés', 'A'),
('paisesbajos', '¿Quién es la leyenda del fútbol total holandés?', 'Johan Cruyff', 'Marco van Basten', 'A'),
('sudafrica', '¿Cómo se llaman los ruidosos instrumentos del Mundial 2010?', 'Vuvuzelas', 'Matracas', 'A'),
('sudafrica', '¿Cuál es el apodo de la selección sudafricana?', 'Bafana Bafana', 'Springboks', 'A'),
('tunez', '¿En qué continente compite la selección de Túnez?', 'Asia', 'África', 'B'),
('tunez', '¿Cuál es el apodo de la selección de Túnez?', 'Las Águilas de Cartago', 'Los Leones del Atlas', 'A'),
('uzbekistan', '¿A qué confederación pertenece Uzbekistán?', 'AFC (Asia)', 'UEFA (Europa)', 'A'),
('uzbekistan', '¿Cuál es el color principal del uniforme de Uzbekistán?', 'Blanco y Azul', 'Rojo y Verde', 'A');

SET SQL_SAFE_UPDATES = 0;
DELETE FROM preguntas;
SET SQL_SAFE_UPDATES = 1;

CREATE TABLE IF NOT EXISTS videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais_codigo VARCHAR(50) NOT NULL,
    youtube_id VARCHAR(50) NOT NULL,
    titulo VARCHAR(100),
    categoria VARCHAR(50) NOT NULL DEFAULT 'goles'
);

INSERT INTO videos (pais_codigo, youtube_id, titulo, categoria) VALUES
('mexico', 'WLYgJyhBlBc', 'Goles de México', 'goles'), 
('mexico', 'oh3baDi1KGE', 'Mejores jugadas México', 'jugadas'), 
('mexico', 'hbhZYAPrK9E', 'Historia de México en Mundiales', 'historia'), 
('mexico', 'yYdr5zowYMA', 'Afición Mexicana', 'aficion'),
('espana', 'oh3baDi1KGE', 'España Campeón', 'goles'), 
('colombia', 'hbhZYAPrK9E', 'Colombia 2 vs Brasil 1', 'goles'), 
('japon', 'yYdr5zowYMA', 'Japon Sorpende al Mundo', 'goles'), 
('uruguay', 'O6FO51YWbhM', 'Uruguay 2 vs Brasil 0', 'goles'), 
('coreadelsur', 'gewILgS9cFo', 'Corea del Sur 2 x 0 Alemania', 'goles'), 
('paisesbajos', 'F-X0geLjmA4', 'Resumen y Goles', 'goles'), 
('sudafrica', '0GBnXiPc5RQ', 'Copa Africana', 'goles'), 
('tunez', 'mKgCoTmFrII', 'Argentina vs Túnez ', 'goles'), 
('uzbekistan', 'zvI9C9aIJgA', 'Uzbekistán Fútbol', 'goles');