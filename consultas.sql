-- Mostrar las notas de los alumnos que sean mayores de edad ordenadas de mayor a menor
-- 1 Subquery 1 Join 1 Order By
SELECT 
    * 
FROM 
    (SELECT 
        * 
    FROM 
        Alumno 
    WHERE 
        mayoriaEdad = TRUE) 
    AS AlumnosMayores 
    INNER JOIN 
    `Alumno/Materia` AS AlumMat 
    ON AlumMat.PK_dniAlumno = AlumnosMayores.PK_dni 
ORDER BY AlumMat.calificacion DESC;

-- Mostrar los promedios por materia de cada curso, ordenarlos de mayor a menor

-- Use esta funcion para simplificar la query
-- 1 Funcion Agregada/Campo calculado 2 Joins 2 Subqueries 1 Order By
DELIMITER $$
-- Devuelve el promedio del curso de una determinada materia
CREATE FUNCTION IF NOT EXISTS promedioCurso(año TINYINT, division TINYINT, materia VARCHAR(50)) RETURNS DECIMAL(4, 2)
READS SQL DATA
BEGIN
    DECLARE myVar DECIMAL(4, 2);

    SELECT 
        AVG(AlumMat.calificacion) AS promedio 
    INTO
        myVar
    FROM 
        (SELECT 
            * 
        FROM 
            Alumno 
        WHERE 
            FK_año = año 
            AND 
            FK_division = division) 
        AS FilteredAlumnos 
        INNER JOIN 
        (SELECT 
            * 
        FROM 
            `Alumno/Materia` AS AlumMat 
        WHERE 
            AlumMat.PK_Materia = materia) 
        AS FilteredAlumMat
        ON FilteredAlumnos.PK_dni = FilteredAlumMat.PK_dniAlumno;

    RETURN myVar;
END$$
DELIMITER ;

SELECT 
    año, 
    division, 
    Materia.PK_nombre, 
    promedioCurso(año, division, Materia.PK_nombre) AS promedio 
FROM 
    Curso 
    CROSS JOIN 
    Materia
ORDER BY promedio DESC;

-- Mostrar los alumnos de mayor edad de cada curso
-- 1 Group by 1 funcion fecha 1 funcion agregada/campo calculado
SELECT
    *,
    MAX(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE(), Alumno.fechaNacimiento)))) AS edad
FROM
    Alumno
GROUP BY (Alumno.año, Alumno.curso);

-- Mostrar todos los alumnos de nombre Ariel que esten cursando el ciclo basico
-- 2 Operadores
SELECT
    *
FROM
    Alumno
WHERE
    Alumno.año IN (1, 2, 3)
    AND
    Alumno.nombre LIKE "%Ariel%";

-- Mostrar los alumnos de menor edad cuya orientacion sea la computacion
-- 1 fecha 1 group by
SELECT
    *,
    MIN(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE(), Alumno.fechaNacimiento)))) AS edad
FROM
    Alumno
WHERE
    (SELECT 
        orientacion 
    FROM 
        Curso 
    WHERE 
        Curso.año = Alumno.año 
        AND 
        Curso.division = Alumno.division) LIKE "Computacion"
GROUP BY (Alumno.año, Alumno.curso);