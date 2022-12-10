/*
    Naming conventions:
        For stored programs:
        * Variable names are camelCase: `myVar`
        * c Prefix for CURSORs: `c_myCursor`
        * f Prefix for variables used in FETCH statements: `f_studentId`
        * tt Prefix for TEMPORARY TABLEs: `tt_RelevantBook`
*/

/*
    t**_checkTallerForAutomotor:
    Los alumnos de automotor tienen una rotacion de taller durante toda la carrera. Este trigger cumple dicha norma 
*/
DELIMITER $$
CREATE TRIGGER tbi_checkTallerForAutomotor_Alumno BEFORE INSERT ON Alumno
FOR EACH ROW
main:BEGIN
    DECLARE orientation VARCHAR(20);
    IF (NEW.FK_año < 3) THEN
        LEAVE main;
    END IF;

    SELECT 
        orientacion 
    INTO 
        orientation 
    FROM 
        Curso 
    WHERE 
        Curso.año = NEW.FK_año 
        AND 
        Curso.division = NEW.FK_division;

    IF (orientation LIKE "Automotor" AND NEW.FK_rotacion IS NULL) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Alumnos de la carrera Automotor deben tener una rotacion de taller";
    END IF;
END main$$
DELIMITER ;
DELIMITER $$

CREATE TRIGGER tbu_checkTallerForAutomotor_Alumno BEFORE UPDATE ON Alumno
FOR EACH ROW
main:BEGIN
    DECLARE orientation VARCHAR(20);
    IF (NEW.FK_año < 3) THEN
        LEAVE main;
    END IF;

    SELECT 
        orientacion 
    INTO 
        orientation 
    FROM 
        Curso 
    WHERE 
        Curso.año = NEW.FK_año 
        AND 
        Curso.division = NEW.FK_division;

    IF (orientation LIKE "Automotor" AND NEW.FK_rotacion IS NULL) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Alumnos de la carrera Automotor deben tener una rotacion de taller";
    END IF;
END main$$
DELIMITER ;




/*
    t**_checkAsistenciaIntegrity:
    Mantiene la integridad referencial entre tablas que referencian tablas comunes. Asegura que los alumnos menores sean retirados por un adulto 
    y completa o revisa el campo de FK_ExcepcionEntrada en caso de ser necesario
*/
DELIMITER $$
CREATE TRIGGER tbi_checkAsistenciaIntegrity_AsistenciaAlumno BEFORE INSERT ON AsistenciaAlumno
FOR EACH ROW
main:BEGIN
    DECLARE alumnoCurso INT;
    DECLARE alumnoAge INT;
    DECLARE entradaCurso INT;
    DECLARE excepcionEntradaCurso INT;
    DECLARE newExcepcionEntrada INT;
    DECLARE excepcion INT;

    SELECT
        Curso.PK_id,
        YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE(), RelevantAlumno.fechaNacimiento))) AS age
    INTO
        alumnoCurso,
        alumnoAge
    FROM
        (SELECT
            Alumno.FK_año,
            Alumno.FK_division,
            Alumno.fechaNacimiento
        FROM
            Alumno
        WHERE
            Alumno.PK_dni = NEW.FK_Alumno)
        AS RelevantAlumno
        INNER JOIN
        Curso
    ON Curso.año = RelevantAlumno.FK_año AND Curso.division = RelevantAlumno.FK_division;

    SELECT
        FK_Curso
    INTO
        entradaCurso
    FROM
        EntradaCurso
    WHERE
        EntradaCurso.PK_id = NEW.FK_EntradaCurso;

    IF (alumnoCurso != entradaCurso) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "El Curso de FK_EntradaCurso no coincide con el de FK_Alumno";
    END IF;

    IF (NEW.FK_ExcepcionEntrada IS NOT NULL) THEN
        SELECT
            FK_EntradaCurso
        INTO
            excepcionEntradaCurso
        FROM
            ExcepcionEntrada
        WHERE
            ExcepcionEntrada.PK_id = NEW.FK_ExcepcionEntrada;
        IF (NEW.FK_EntradaCurso != excepcionEntradaCurso) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "ExcepcionEntrada.FK_EntradaCurso no coincide con AsistenciaAlumno.FK_EntradaCurso";
        END IF;
    ELSE
        SELECT
            PK_id
        INTO
            newExcepcionEntrada
        FROM
            ExcepcionEntrada
        WHERE
            ExcepcionEntrada.fecha LIKE CURRENT_DATE()
            AND
            ExcepcionEntrada.FK_EntradaCurso = NEW.FK_EntradaCurso;
        SET NEW.FK_ExcepcionEntrada = newExcepcionEntrada;
    END IF;

    IF ((NEW.horaRetiro IS NOT NULL) AND (NEW.FK_Responsable_firmaRetiro IS NULL) AND (alumnoAge < 18)) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Los menores deben ser retirados por un adulto";
    END IF;
END main$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tbu_checkAsistenciaIntegrity_AsistenciaAlumno BEFORE UPDATE ON AsistenciaAlumno
FOR EACH ROW
main:BEGIN
    DECLARE alumnoCurso INT;
    DECLARE alumnoAge INT;
    DECLARE entradaCurso INT;
    DECLARE excepcionEntradaCurso INT;
    DECLARE newExcepcionEntrada INT;
    DECLARE excepcion INT;

    SELECT
        Curso.PK_id,
        YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE(), RelevantAlumno.fechaNacimiento))) AS age
    INTO
        alumnoCurso,
        alumnoAge
    FROM
        (SELECT
            Alumno.FK_año,
            Alumno.FK_division,
            Alumno.fechaNacimiento
        FROM
            Alumno
        WHERE
            Alumno.PK_dni = NEW.FK_Alumno)
        AS RelevantAlumno
        INNER JOIN
        Curso
    ON Curso.año = RelevantAlumno.FK_año AND Curso.division = RelevantAlumno.FK_division;

    SELECT
        FK_Curso
    INTO
        entradaCurso
    FROM
        EntradaCurso
    WHERE
        EntradaCurso.PK_id = NEW.FK_EntradaCurso;

    IF (alumnoCurso != entradaCurso) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "El Curso de FK_EntradaCurso no coincide con el de FK_Alumno";
    END IF;

    IF (NEW.FK_ExcepcionEntrada IS NOT NULL) THEN
        SELECT
            FK_EntradaCurso
        INTO
            excepcionEntradaCurso
        FROM
            ExcepcionEntrada
        WHERE
            ExcepcionEntrada.PK_id = NEW.FK_ExcepcionEntrada;
        IF (NEW.FK_EntradaCurso != excepcionEntradaCurso) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "ExcepcionEntrada.FK_EntradaCurso no coincide con AsistenciaAlumno.FK_EntradaCurso";
        END IF;
    ELSE
        SELECT
            PK_id
        INTO
            newExcepcionEntrada
        FROM
            ExcepcionEntrada
        WHERE
            ExcepcionEntrada.fecha LIKE CURRENT_DATE()
            AND
            ExcepcionEntrada.FK_EntradaCurso = NEW.FK_EntradaCurso;
        SET NEW.FK_ExcepcionEntrada = newExcepcionEntrada;
    END IF;

    IF ((NEW.horaRetiro IS NOT NULL) AND (NEW.FK_Responsable_firmaRetiro IS NULL) AND (alumnoAge < 18)) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Los menores deben ser retirados por un adulto";
    END IF;
END main$$
DELIMITER ;

-- trigger for EntradaRotacionTaller overlap
-- trigger for taller/rotaciontaller overlap
/*
    t**_preventOverlapping_*:
    Previene que se solapen los diferentes rangos de tiempo
*/

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbi_preventOverlapping_Horario BEFORE INSERT ON Horario
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM Horario WHERE Horario.dia = NEW.dia AND Horario.FK_Curso = NEW.FK_Curso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbu_preventOverlapping_Horario BEFORE UPDATE ON Horario
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM Horario WHERE Horario.dia = NEW.dia AND Horario.FK_Curso = NEW.FK_Curso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbi_preventOverlapping_EntradaCurso BEFORE INSERT ON EntradaCurso
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM EntradaCurso WHERE EntradaCurso.dia = NEW.dia AND EntradaCurso.FK_Curso = NEW.FK_Curso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbu_preventOverlapping_EntradaCurso BEFORE UPDATE ON EntradaCurso
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM EntradaCurso WHERE EntradaCurso.dia = NEW.dia AND EntradaCurso.FK_Curso = NEW.FK_Curso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbi_preventOverlapping_HorarioCursoOptativo BEFORE INSERT ON HorarioCursoOptativo
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM HorarioCursoOptativo WHERE HorarioCursoOptativo.dia = NEW.dia AND HorarioCursoOptativo.FK_CursoOptativo = NEW.FK_CursoOptativo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbu_preventOverlapping_HorarioCursoOptativo BEFORE UPDATE ON HorarioCursoOptativo
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM HorarioCursoOptativo WHERE HorarioCursoOptativo.dia = NEW.dia AND HorarioCursoOptativo.FK_CursoOptativo = NEW.FK_CursoOptativo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbi_preventOverlapping_ExcepcionEntrada BEFORE INSERT ON ExcepcionEntrada
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM ExcepcionEntrada WHERE ExcepcionEntrada.fecha = NEW.fecha AND ExcepcionEntrada.FK_EntradaCurso = NEW.FK_EntradaCurso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbu_preventOverlapping_ExcepcionEntrada BEFORE UPDATE ON ExcepcionEntrada
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM ExcepcionEntrada WHERE ExcepcionEntrada.fecha = NEW.fecha AND ExcepcionEntrada.FK_EntradaCurso = NEW.FK_EntradaCurso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbi_preventOverlapping_EntradaRotacionTaller BEFORE INSERT ON EntradaRotacionTaller
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM EntradaRotacionTaller WHERE EntradaRotacionTaller.dia = NEW.dia AND EntradaRotacionTaller.FK_RotacionTaller = NEW.FK_RotacionTaller;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbu_preventOverlapping_EntradaRotacionTaller BEFORE UPDATE ON EntradaRotacionTaller
FOR EACH ROW
BEGIN
    DECLARE errMessage VARCHAR(200);
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE id INT;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida, PK_id FROM EntradaRotacionTaller WHERE EntradaRotacionTaller.dia = NEW.dia AND EntradaRotacionTaller.FK_RotacionTaller = NEW.FK_RotacionTaller;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme, id;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada < endTime) AND (NEW.horaSalida > startTime) THEN
            SET errMessage = CONCAT("Overlapping time frames are not allowed. Conflicting PK_id: ", CAST(id AS CHAR));
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = errMessage;
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;
-- overlap asistenciarotaciontaller


DELIMITER $$
CREATE EVENT e_ManejoAsistencias
    ON SCHEDULE 
        EVERY 23 HOUR 
        STARTS CURRENT_TIMESTAMP()
    ON COMPLETION PRESERVE
    COMMENT 'Inserta los ausentes. Revisa los horarios del dia e inserta una asistencia de Ausente por cada alumno del curso. Esto lo hace para todos los cursos'
    DO main:BEGIN
        -- Variable declarations
        DECLARE currentWeekday VARCHAR(9) DEFAULT ELT(WEEKDAY(CURRENT_DATE())+1, "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo");
        -- Cursor related declarations
        DECLARE done_c_Curso BIT DEFAULT FALSE;
        DECLARE f_curso INT;
        DECLARE c_Curso CURSOR FOR SELECT PK_id FROM Curso;
        DECLARE CONTINUE HANDLER FOR NOT FOUND 
            SET done_c_Curso = TRUE;

        IF (currentWeekday IN ("Sabado", "Domingo")) THEN
            LEAVE main;
        END IF;

        OPEN c_Curso;
        forEach_Curso:LOOP
            -- Boilerplate cleanup
            DROP TEMPORARY TABLE IF EXISTS tt_RelevantEntrada;
            DROP TEMPORARY TABLE IF EXISTS tt_RelevantAlumno;
            DROP TEMPORARY TABLE IF EXISTS tt_AlumnoCrossEntrada;
            FETCH c_Curso INTO f_curso;
            IF done_c_Curso THEN
                LEAVE forEach_Curso;
            END IF;

            -- Loop body
            BEGIN
                DECLARE isEntradaSubQEmpty BIT DEFAULT FALSE;
                DECLARE isAlumnoSubQEmpty BIT DEFAULT FALSE;
                DECLARE cursoAño INT;
                DECLARE cursoDiv INT;

                CREATE TEMPORARY TABLE tt_RelevantEntrada
                    SELECT
                        PK_id
                    FROM
                        EntradaCurso
                    WHERE
                        EntradaCurso.FK_Curso = f_curso
                        AND
                        EntradaCurso.dia LIKE currentWeekday
                ;

                SELECT TRUE INTO isEntradaSubQEmpty WHERE NOT EXISTS(SELECT * FROM tt_RelevantEntrada);
                IF isEntradaSubQEmpty THEN
                    ITERATE forEach_Curso;
                END IF;

                SELECT Curso.año, Curso.division INTO cursoAño, cursoDiv FROM Curso WHERE Curso.PK_id = f_curso;
                CREATE TEMPORARY TABLE tt_RelevantAlumno
                    SELECT
                        PK_dni
                    FROM
                        Alumno
                    WHERE
                        Alumno.FK_año = cursoAño
                        AND
                        Alumno.FK_division = cursoDiv
                    ;
                
                SELECT TRUE INTO isAlumnoSubQEmpty WHERE NOT EXISTS(SELECT * FROM tt_RelevantAlumno);
                IF isAlumnoSubQEmpty THEN
                    ITERATE forEach_Curso;
                END IF;

                CREATE TEMPORARY TABLE tt_AlumnoCrossEntrada 
                    SELECT 
                        PK_dni AS AlumnoDni, 
                        PK_id AS EntradaId 
                    FROM 
                        tt_RelevantAlumno 
                        CROSS JOIN
                        tt_RelevantEntrada
                    ;


                BEGIN
                    -- Cursor related declarations
                    DECLARE done_c_AlumnoCrossEntrada BIT DEFAULT FALSE;
                    DECLARE f_AlumnoDni VARCHAR(20);
                    DECLARE f_EntradaId INT;
                    DECLARE c_AlumnoCrossEntrada CURSOR FOR SELECT AlumnoDni, EntradaId FROM tt_AlumnoCrossEntrada;
                    DECLARE CONTINUE HANDLER FOR NOT FOUND
                        SET done_c_AlumnoCrossEntrada = TRUE;

                    OPEN c_AlumnoCrossEntrada;
                    forEach_AlumnoCrossEntrada:LOOP
                        -- Boilerplate cleanup
                        FETCH c_AlumnoCrossEntrada INTO f_AlumnoDni, f_EntradaId;
                        IF done_c_AlumnoCrossEntrada THEN
                            LEAVE forEach_AlumnoCrossEntrada;
                        END IF;

                        -- Loop body
                        BEGIN
                            DECLARE duplicate_entry CONDITION FOR 1062;
                            DECLARE CONTINUE HANDLER FOR duplicate_entry 
                                BEGIN END;
                            INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, horaLlegada, horaRetiro, estado)
                                VALUES (f_EntradaId, f_AlumnoDni, NULL, NULL, 'Ausente');
                        END;
                    END LOOP forEach_AlumnoCrossEntrada;
                    CLOSE c_AlumnoCrossEntrada;
                END;
            END;
        END LOOP forEach_Curso;
        CLOSE c_Curso;
    END main$$
DELIMITER ;