CREATE database M5;

USE m5;

-- Creación de la tabla Usuario
CREATE TABLE Usuario (
  usuario_id INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  correo VARCHAR(100),
  usos_app INT DEFAULT 1
);

-- Creación de la tabla Operario
CREATE TABLE Operario (
  operario_id INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  correo VARCHAR(100),
  usos_sop INT DEFAULT 1
);

-- Creación de la tabla Soporte
CREATE TABLE Soporte (
  soporte_id INT PRIMARY KEY,
  fecha DATE,
  usuario_id INT,
  operario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
  FOREIGN KEY (operario_id) REFERENCES Operario(operario_id)
);

-- Creación de la tabla Evaluación
CREATE TABLE Evaluacion (
  evaluacion_id INT PRIMARY KEY,
  nota INT,
  comentario VARCHAR(200),
  soporte_id INT,
  FOREIGN KEY (soporte_id) REFERENCES Soporte(soporte_id)
);

-- Agregar 5 usuarios
INSERT INTO Usuario (usuario_id, nombre, apellido, edad, correo, usos_app)
VALUES
  (1, 'Leonardo', 'DiCaprio', 46, 'leonardo@example.com', 3),
  (2, 'Jennifer', 'Lawrence', 31, 'jennifer@example.com', 2),
  (3, 'Tom', 'Hanks', 65, 'tom@example.com', 4),
  (4, 'Scarlett', 'Johansson', 37, 'scarlett@example.com', 1),
  (5, 'Brad', 'Pitt', 58, 'brad@example.com', 2);
  
  select * from usuario;

-- Agregar 5 operarios
INSERT INTO Operario (operario_id, nombre, apellido, edad, correo, usos_sop)
VALUES
  (1, 'Robert', 'De Niro', 78, 'robert@example.com', 6),
  (2, 'Meryl', 'Streep', 72, 'meryl@example.com', 3),
  (3, 'Denzel', 'Washington', 67, 'denzel@example.com', 4),
  (4, 'Julia', 'Roberts', 54, 'julia@example.com', 5),
  (5, 'Johnny', 'Depp', 58, 'johnny@example.com', 2);
  
  select * from Operario;

-- Agregar 10 operaciones de soporte
INSERT INTO Soporte (soporte_id, fecha, usuario_id, operario_id)
VALUES
  (1, '2023-07-01', 1, 1),
  (2, '2023-07-02', 2, 2),
  (3, '2023-07-03', 3, 3),
  (4, '2023-07-04', 4, 4),
  (5, '2023-07-05', 5, 5),
  (6, '2023-07-06', 1, 2),
  (7, '2023-07-07', 2, 3),
  (8, '2023-07-08', 3, 4),
  (9, '2023-07-09', 4, 5),
  (10, '2023-07-10', 5, 1);
  
-- Insertar 5 registros de evaluación para poder listar los mejor evaluados
INSERT INTO Evaluacion (evaluacion_id, nota, comentario, soporte_id)
VALUES
  (1, 7, 'Excelente atención', 1),
  (2, 6, 'Buena asistencia', 2),
  (3, 7, 'Muy satisfecho con el soporte', 3),
  (4, 5, 'Atención promedio', 4),
  (5, 7, 'El operario resolvió mi problema rápidamente', 5);

  
-- Seleccione las 3 operaciones con mejor evaluación.
SELECT s.soporte_id, s.fecha, u.nombre AS usuario, o.nombre AS operario, e.nota
FROM Soporte s
JOIN Usuario u ON s.usuario_id = u.usuario_id
JOIN Operario o ON s.operario_id = o.operario_id
JOIN Evaluacion e ON s.soporte_id = e.soporte_id
ORDER BY e.nota DESC
LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.
SELECT s.soporte_id, s.fecha, u.nombre AS usuario, o.nombre AS operario, e.nota
FROM Soporte s
JOIN Usuario u ON s.usuario_id = u.usuario_id
JOIN Operario o ON s.operario_id = o.operario_id
JOIN Evaluacion e ON s.soporte_id = e.soporte_id
ORDER BY e.nota ASC
LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.

SELECT o.operario_id, o.nombre AS operario, COUNT(*) AS total_soportes
FROM Operario o
JOIN Soporte s ON o.operario_id = s.operario_id
GROUP BY o.operario_id, o.nombre
ORDER BY total_soportes DESC
LIMIT 1;

-- Seleccione al cliente que menos veces ha utilizado la aplicación.

SELECT u.usuario_id, u.nombre AS cliente, u.usos_app
FROM Usuario u
ORDER BY u.usos_app ASC
LIMIT 1;

-- Agregue 10 años a los tres primeros usuarios registrados.
UPDATE Usuario
SET edad = edad + 10
ORDER BY usuario_id
LIMIT 3;

-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE Usuario
CHANGE COLUMN correo email VARCHAR(100);

ALTER TABLE Operario
CHANGE COLUMN correo email VARCHAR(100);


-- Seleccione solo los operarios mayores de 20 años.
SELECT *
FROM Operario
WHERE edad > 20;