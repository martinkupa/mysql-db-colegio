/*
    Naming conventions:
        For stored programs:
        * Variable names are camelCase: `myVar`
        * c Prefix for CURSORs: `c_myCursor`
        * f Prefix for variables used in FETCH statements: `f_studentId`
        * tt Prefix for TEMPORARY TABLEs: `tt_RelevantBook`
*/

-- trigger for Alumno checking rotacion if año < 3
-- trigger for horariocursooptativo overlap
-- trigger for EntradaCurso overlap
-- trigger for EntradaRotacionTaller overlap

-- asistencia alumno pertenece al mismo curso q el horario y responsableretiro nulo solo si es mayor

-- excepcion entrada overlap

DELIMITER $$
CREATE EVENT e_ManejoAsistencias
    ON SCHEDULE 
        EVERY 23 HOUR 
        STARTS CURRENT_TIMESTAMP()
    ON COMPLETION PRESERVE
    COMMENT 'Inserta los ausentes. Revisa los horarios del dia e inserta una asistencia de Ausente por cada alumno del curso. Esto lo hace para todos los cursos'
    DO main:BEGIN
        -- Variable declarations
        -- !!!!!!!!!!!!!!!!!!! HANDLE WEEKENDS
        DECLARE currentWeekday VARCHAR(9) DEFAULT ELT(WEEKDAY(CURRENT_DATE())+1, "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo");

        -- Cursor related declarations
        DECLARE done_c_Curso BIT DEFAULT FALSE;
        DECLARE f_curso INT;
        DECLARE c_Curso CURSOR FOR SELECT PK_id FROM Curso;
        DECLARE CONTINUE HANDLER FOR NOT FOUND 
            SET done_c_Curso = TRUE;


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


DELIMITER $$
CREATE TRIGGER IF NOT EXISTS preventOverlapping BEFORE INSERT ON Horario
FOR EACH ROW
BEGIN
    DECLARE done BIT DEFAULT FALSE;
    DECLARE startTime TIME;
    DECLARE endTIme TIME;
    DECLARE myCursor CURSOR FOR SELECT horaEntrada, horaSalida FROM Horario WHERE Horario.dia = NEW.dia AND Horario.FK_Curso = NEW.FK_Curso;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN myCursor;
    forEach: LOOP
        FETCH myCursor INTO startTime, endTIme;
        IF done THEN
            LEAVE forEach;
        END IF;
        IF (NEW.horaEntrada BETWEEN startTime AND endTime) OR (NEW.horaSalida BETWEEN startTime AND endTime) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Overlapping time frames are not allowed";
        END IF;
    END LOOP;
    CLOSE myCursor;
END$$
DELIMITER ;

