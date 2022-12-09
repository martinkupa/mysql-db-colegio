/*
    Naming conventions:
        For table creation:
        * Table names are PascalCase and singular: `Person`
        * Column names are camelCase: `userName`
        * Primary keys use the PK prefix: `PK_bookId`
        * Foreign keys use the FK prefix, followed by the name of the table being referenced,
          followed by the column name: `FK_Author_bookAuthor`
          If the column name is redundant, it can be omitted: `FK_Author`
        * Constraint names use a custom prefix ending with the letter C that describes the type of the constraint,
          followed by the table name, followed by the constraint name in camel case: `UC_Book_naturalKey` `FKC_Book_refsAuthor`
        * Intermediate tables that represent a many to many relationship between two already existing tables use 
          `TableOne/TableTwo` as their name: `Book/Publisher`
*/

CREATE DATABASE IF NOT EXISTS Colegio;

USE Colegio;

/*
    Profesor:
    Profesores del colegio
*/
CREATE TABLE IF NOT EXISTS Profesor(
    PK_dni VARCHAR(20) 
        PRIMARY KEY 
        CHECK (PK_dni != ""),
    nombre VARCHAR(50) 
        NOT NULL 
        CHECK (nombre != ""),
    apellido VARCHAR(50) 
        NOT NULL 
        CHECK (apellido != ""),
    celular VARCHAR(20) 
        NOT NULL 
        CHECK (celular != ""),
    tarjetaId TEXT 
        NOT NULL 
        CHECK (tarjetaId != ""),
    direccion VARCHAR(200) 
        NULL
        CHECK (direccion != ""),
    email VARCHAR(200) 
        NOT NULL 
        CHECK (email != ""),
    fechaNacimiento DATE
) COMMENT 'Profesores del colegio';

/*
    Curso:
    Cursos del colegio
*/
CREATE TABLE IF NOT EXISTS Curso(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    año TINYINT 
        NOT NULL,
    division TINYINT 
        NOT NULL,
    orientacion ENUM("Computacion", "Automotor", "Ciclo basico") 
        NOT NULL 
        DEFAULT (IF(año < 3, "Ciclo basico", NULL)),
    turno ENUM('Mañana', 'Tarde', 'Noche')
        NOT NULL,
    CONSTRAINT UC_Curso_naturalKey UNIQUE (año, division),
    CONSTRAINT CC_Curso_tallerCicloBasico CHECK (IF(año < 3, "Ciclo Basico", orientacion) = orientacion)
) COMMENT 'Cursos del colegio';

/*
    Materia:
    Materias del Colegio
*/
CREATE TABLE IF NOT EXISTS Materia(
    PK_nombre VARCHAR(50) 
        PRIMARY KEY
        CHECK (PK_nombre != "")
) COMMENT 'Materias del Colegio';

/*
    Taller:
    Los talleres que se imparten en el colegio. Similar a la tabla Materias. Cada taller tiene un profesor asignado
*/
CREATE TABLE IF NOT EXISTS Taller(
    PK_nombre VARCHAR(50) 
        PRIMARY KEY
        CHECK (PK_nombre != ""),
    FK_Profesor VARCHAR(20)
        NOT NULL,
    CONSTRAINT FKC_Taller_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
) COMMENT 'Los talleres que se imparten en el colegio. Similar a la tabla Materias. Cada taller tiene un profesor asignado';

/*
    RotacionTaller: 
    Las rotaciones de taller del colegio. Similar a la tabla Curso. Cada rotacion tiene un profesor asignado que rota los 
    diferentes talleres junto con los alumnos. Note que esta tabla no depende en absoluto de la tabla curso
*/
CREATE TABLE IF NOT EXISTS RotacionTaller(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_Profesor VARCHAR(20) 
        NOT NULL,
    año TINYINT 
        NOT NULL,
    rotacion TINYINT 
        NOT NULL,
    CONSTRAINT UC_RotacionTaller_naturalKey UNIQUE(año, rotacion),
    CONSTRAINT FKC_RotacionTaller_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
) COMMENT 'Las rotaciones de taller del colegio. Similar a la tabla Curso. Cada rotacion tiene un profesor asignado que rota los diferentes talleres junto con los alumnos. Note que esta tabla no depende en absoluto de la tabla curso';


/*
    CursoOptativo:
    Los cursos de materias optativas del colegio. Note que no se toma la presencialidad de estos cursos
*/
CREATE TABLE IF NOT EXISTS CursoOptativo(
    PK_id INT 
        PRIMARY KEY,
    FK_Profesor VARCHAR(20) 
        NOT NULL,
    division INT 
        NOT NULL,
    orientacion ENUM("Autocad", "Aleman") 
        NOT NULL,
    CONSTRAINT UC_CursoOptativo_naturalKey UNIQUE (division, orientacion),
    CONSTRAINT FKC_CursoOptativo_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
) COMMENT 'Los cursos de materias optativas del colegio. Note que no se toma la presencialidad de estos cursos';

/*
    Responsable:
    Aquellos registrados como responsables de un alumno
*/
CREATE TABLE IF NOT EXISTS Responsable(
    PK_dni VARCHAR(20) 
        PRIMARY KEY
        CHECK (PK_dni != ""),
    nombre VARCHAR(50) 
        NOT NULL
        CHECK (nombre != ""),
    apellido VARCHAR(50) 
        NOT NULL
        CHECK (apellido != ""),
    celular VARCHAR(20) 
        NOT NULL
        CHECK (celular != ""),
    direccion VARCHAR(200) 
        NOT NULL
        CHECK (direccion != ""),
    email VARCHAR(200) 
        NOT NULL
        CHECK (email != ""),
    fechaNacimiento DATE
        NULL
) COMMENT 'Aquellos registrados como responsables de un alumno';


/*
    Alumno:
    Los alumnos del colegio
*/
CREATE TABLE IF NOT EXISTS Alumno(
    PK_dni VARCHAR(20) 
        PRIMARY KEY
        CHECK (PK_dni != ""),
    nombre VARCHAR(50) 
        NOT NULL
        CHECK (nombre != ""),
    apellido VARCHAR(50) 
        NOT NULL
        CHECK (apellido != ""),
    fechaNacimiento DATE 
        NOT NULL,
    direccion VARCHAR(200) 
        NOT NULL
        CHECK (direccion != ""),
    email VARCHAR(200) 
        NOT NULL
        CHECK (email != ""),
    tarjetaId TEXT 
        NOT NULL
        CHECK (tarjetaId != ""),
    FK_año TINYINT 
        NOT NULL,
    FK_division TINYINT 
        NOT NULL,
    FK_rotacion TINYINT 
        NULL,
    CONSTRAINT FKC_Alumno_refsCursoNaturalKey FOREIGN KEY (FK_año, FK_division) REFERENCES Curso(año, division),
    CONSTRAINT FKC_Alumno_refsRotacionTallerNaturalKey FOREIGN KEY (FK_año, FK_rotacion) REFERENCES RotacionTaller(año, rotacion),
    CONSTRAINT CC_Alumno_tallerCicloBasico CHECK (IF(FK_año < 3, NOT ISNULL(FK_rotacion), TRUE))
) COMMENT 'Los alumnos del colegio';

/*
    Horario:
    Los horarios de cada curso
*/
CREATE TABLE IF NOT EXISTS Horario(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_Curso INT 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME
        NOT NULL,
    FK_Materia VARCHAR(50) 
        NOT NULL,
    FK_Profesor VARCHAR(20) 
        NOT NULL,
    CONSTRAINT FKC_Horario_refsMateria FOREIGN KEY (FK_Materia) REFERENCES Materia(PK_nombre),
    CONSTRAINT FKC_Horario_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT FKC_Horario_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni),
    CONSTRAINT UC_Horario_naturalKey UNIQUE (FK_Curso, dia, horaEntrada),
    CONSTRAINT CC_Horario_checkTimes CHECK (horaEntrada < horaSalida)
) COMMENT 'Los horarios de cada curso';


/*
    HorarioCursoOptativo:
    Los horarios de un curso optativo
*/
CREATE TABLE IF NOT EXISTS HorarioCursoOptativo(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_CursoOptativo INT 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME 
        NOT NULL,
    CONSTRAINT UC_HorarioCursoOptativo_naturalKey UNIQUE (FK_CursoOptativo, dia, horaEntrada),
    CONSTRAINT UC_HorarioCursoOptativo_refsCursoOptativo FOREIGN KEY (FK_CursoOptativo) REFERENCES CursoOptativo(PK_id),
    CONSTRAINT CC_HorarioCursoOptativo_checkTimes CHECK (horaEntrada < horaSalida)
) COMMENT 'Los horarios de un curso optativo';

/*
    EntradaCurso: 
    Los horarios de entrada de los alumnos de un determinado curso a lo largo de la semana. Note que si bien en la 
    practica los horarios de entrada dependen de los horarios de las materias, esta tabla no 
    depende de la tabla Horario
*/
CREATE TABLE IF NOT EXISTS EntradaCurso(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_Curso INT 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME 
        NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    actividad ENUM("Laboratorio/Taller", "Curricular", "Ed. Fisica") -- look into this AAAAAAAAAAAAAAAAAAA
        NOT NULL,
    CONSTRAINT UC_EntradaCurso_naturalKey UNIQUE (FK_Curso, dia, horaEntrada),
    CONSTRAINT FKC_EntradaCurso_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT CC_EntradaCurso_checkTimes CHECK (horaEntrada < horaSalida)
) COMMENT 'Los horarios de entrada de los alumnos de un determinado curso a lo largo de la semana. Note que si bien en la practica los horarios de entrada dependen de los horarios de las materias, esta tabla no depende de la tabla Horario';

/*
    EntradaRotacionTaller:
    Los horarios de entrada de los alumnos de una rotacion de taller a lo largo de la semana
    NOTA: No hay tabla de HorarioRotacionTaller porque al haber una solo taller por dia, no es necesaria.
*/
CREATE TABLE IF NOT EXISTS EntradaRotacionTaller(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_RotacionTaller INT 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME 
        NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    CONSTRAINT UC_EntradaRotacionTaller_naturalKey UNIQUE (FK_RotacionTaller, dia, horaEntrada),
    CONSTRAINT FKC_EntradaRotacionTaller_refsRotacionTaller FOREIGN KEY (FK_RotacionTaller) REFERENCES RotacionTaller(PK_id),
    CONSTRAINT CC_EntradaRotacionTaller_checkTimes CHECK (horaEntrada < horaSalida)
) COMMENT 'Los horarios de entrada de los alumnos de una rotacion de taller a lo largo de la semana';

/*
    AsistenciaRotacionTaller:
    El presentismo de un alumno de taller
*/
CREATE TABLE IF NOT EXISTS AsistenciaRotacionTaller(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_EntradaRotacionTaller INT 
        NOT NULL,
    FK_Alumno VARCHAR(20) 
        NOT NULL,
    fecha DATE 
        NOT NULL 
        DEFAULT (CURRENT_DATE()),
    horaLlegada TIME 
        NULL 
        DEFAULT (CURRENT_TIME()),
    estado ENUM("Presente", "Ausente", "Tarde")
        NOT NULL,
    horaRetiro TIME 
        NULL,
    FK_Responsable_firmaRetiro VARCHAR(20)
        NULL,
    CONSTRAINT FKC_AsistenciaRotacionTaller_refsResponsable FOREIGN KEY (FK_Responsable_firmaRetiro) REFERENCES Responsable(PK_dni),
    CONSTRAINT UC_AsistenciaRotacionTaller_naturalKey UNIQUE (FK_EntradaRotacionTaller, fecha, FK_Alumno),
    CONSTRAINT FKC_AsistenciaRotacionTaller_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT FKC_AsistenciaRotacionTaller_refsEntradaRotacionTaller FOREIGN KEY (FK_EntradaRotacionTaller) REFERENCES EntradaRotacionTaller(PK_id),
    CONSTRAINT CC_AsistenciaRotacionTaller_checkTimes CHECK (horaLlegada < horaRetiro) /* Reminder: UNKNOWN doesnt violate check constraints */
) COMMENT 'El presentismo de un alumno de taller';

/*
    EntradaProfesor:
    Los horarios de entrada de los profesores
*/
CREATE TABLE IF NOT EXISTS EntradaProfesor(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_Profesor VARCHAR(20) 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    CONSTRAINT UC_EntradaProfesor_naturalKey UNIQUE (FK_Profesor, dia, horaEntrada),
    CONSTRAINT FKC_EntradaProfesor_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
) COMMENT 'Los horarios de entrada de los profesores';

/*
    ExcepcionEntrada:
    Los dias en los que, por una situacion excepcional, los horarios de entrada de un curso son otros. Un valor nulo para 
    la horaEntrada significa que el alumno no debe asistir
*/
CREATE TABLE IF NOT EXISTS ExcepcionEntrada(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_EntradaCurso INT 
        NOT NULL,
    fecha DATE 
        NOT NULL,
    horaEntrada TIME
        NULL,
    horaSalida TIME
        NULL,
    descripcion VARCHAR(200)
        NULL
        CHECK (descripcion != ""),
    CONSTRAINT FKC_ExcepcionEntrada_refsEntradaCurso FOREIGN KEY (FK_EntradaCurso) REFERENCES EntradaCurso(PK_id),
    CONSTRAINT UC_ExcepcionEntrada_naturalKey UNIQUE (FK_EntradaCurso, fecha),
    CONSTRAINT CC_ExcepcionEntrada_checkTimes CHECK (horaEntrada < horaSalida),
    CONSTRAINT CC_ExcepcionEntrada_enforceCausality CHECK (IF(horaEntrada IS NULL, NULL, horaSalida) = horaSalida) /* If horaEntrada is NULL, then horaSalida should be too */
) COMMENT 'Los dias en los que, por una situacion excepcional, los horarios de entrada de un curso son otros. Un valor nulo para la horaEntrada significa que el alumno no debe asistir';

/*
    AsistenciaAlumno:
    El presentismo del alumno. En caso de retiro anticipado, los campos horaRetiro y (en caso de que el alumno sea menor) 
    FK_Responsable_firmaRetiro deben ser rellenados
*/
CREATE TABLE IF NOT EXISTS AsistenciaAlumno(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_EntradaCurso INT 
        NOT NULL,
    FK_ExcepcionEntrada INT
        NULL,
    FK_Alumno VARCHAR(20) 
        NOT NULL,
    fecha DATE 
        NOT NULL 
        DEFAULT (CURRENT_DATE()),
    horaLlegada TIME 
        NULL 
        DEFAULT (CURRENT_TIME()),
    estado ENUM("Presente", "Ausente", "Tarde")
        NOT NULL,
    horaRetiro TIME
        NULL,
    FK_Responsable_firmaRetiro VARCHAR(20)
        NULL,
    CONSTRAINT FKC_AsistenciaAlumno_refsResponsable FOREIGN KEY (FK_Responsable_firmaRetiro) REFERENCES Responsable(PK_dni),
    CONSTRAINT FKC_AsistenciaAlumno_refsEntradaCurso FOREIGN KEY (FK_EntradaCurso) REFERENCES EntradaCurso(PK_id),
    CONSTRAINT FKC_AsistenciaAlumno_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT FKC_AsistenciaAlumno_refsExcepcionEntrada FOREIGN KEY (FK_ExcepcionEntrada) REFERENCES ExcepcionEntrada(PK_id),
    CONSTRAINT UC_AsistenciaAlumno_naturalKey UNIQUE (FK_EntradaCurso, fecha, FK_Alumno),
    CONSTRAINT CC_AsistenciaAlumno_checkTimes CHECK (horaLlegada < horaRetiro),
    CONSTRAINT CC_AsistenciaAlumno_enforceCausality CHECK (IF(horaLlegada IS NULL, NULL, horaRetiro) = horaRetiro)
) COMMENT 'El presentismo del alumno. En caso de retiro anticipado, los campos horaRetiro y (en caso de que el alumno sea menor) FK_Responsable_firmaRetiro deben ser rellenados';

/*
    AsistenciaProfesor:
    El presentismo de los profesores
*/
CREATE TABLE IF NOT EXISTS AsistenciaProfesor( /* maybe remove */
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_EntradaProfesor INT 
        NOT NULL,
    fecha DATE 
        NOT NULL 
        DEFAULT (CURRENT_DATE()),
    horaLlegada TIME 
        NOT NULL 
        DEFAULT (CURRENT_TIME()),
    estado ENUM("Presente", "Ausente", "Tarde")
        NOT NULL,
    CONSTRAINT FKC_AsistenciaProfesor_refsEntradaProfesor FOREIGN KEY (FK_EntradaProfesor) REFERENCES EntradaProfesor(PK_id),
    CONSTRAINT UC_AsistenciaProfesor_naturalKey UNIQUE (FK_EntradaProfesor, fecha)
    -- Professor is already referenced in the 'Horarios' table, there is no need for a FOREIGN KEY
) COMMENT 'El presentismo de los profesores';

/*
    ExcepcionDia:
    Los dias en los que no hay clase. Estos aplican a todos los horarios de todos los cursos
*/
CREATE TABLE IF NOT EXISTS ExcepcionDia(
    fecha DATE 
        PRIMARY KEY,
    descripcion VARCHAR(200)
        NULL
        CHECK (descripcion != "")
) COMMENT 'Los dias en los que no hay clase. Estos aplican a todos los horarios de todos los cursos';

/*
    Alumno/CursoOptativo:
    Un alumno puede asistir a varios cursos optativos. Un mismo alumno no puede estar en dos divisiones de la misma 
    orientacion a la vez
*/
CREATE TABLE IF NOT EXISTS `Alumno/CursoOptativo`(
    PK_dniAlumno VARCHAR(20) 
        NOT NULL,
    PK_orientacion ENUM("Autocad", "Aleman") 
        NOT NULL,
    FK_division INT 
        NOT NULL,
    calificacion TINYINT
        NULL,
    CONSTRAINT `PKC_Alumno/CursoOptativo_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_orientacion),
    CONSTRAINT `FKC_Alumno/CursoOptativo_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/CursoOptativo_refsCursoOptativoNaturalKey` FOREIGN KEY (FK_division, PK_orientacion) REFERENCES CursoOptativo(division, orientacion) -- Order matters, make sure that the table being referenced has the fields of the unique constraint in the same order
) COMMENT 'Un alumno puede asistir a varios cursos optativos. Un mismo alumno no puede estar en dos divisiones de la misma orientacion a la vez';

/*
    Alumno/Responsable:
    Un adulto puede tener varios alumnos a cargo y un alumno puede tener varios adultos responsables
*/
CREATE TABLE IF NOT EXISTS `Alumno/Responsable`(
    PK_dniAlumno VARCHAR(20) 
        NOT NULL,
    PK_dniResponsable VARCHAR(20) 
        NOT NULL,
    CONSTRAINT `PKC_Alumno/Responsable_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_dniResponsable),
    CONSTRAINT `FKC_Alumno/Responsable_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Responsable_refsResponsable` FOREIGN KEY (PK_dniResponsable) REFERENCES Responsable(PK_dni)
) COMMENT 'Un adulto puede tener varios alumnos a cargo y un alumno puede tener varios adultos responsables';

/*
    Alumno/Materia:
    Un alumno rinde varias materias, y una materia se imparte a varios alumnos
*/
CREATE TABLE IF NOT EXISTS `Alumno/Materia`(
    PK_Materia VARCHAR(50) 
        NOT NULL,
    PK_dniAlumno VARCHAR(20) 
        NOT NULL,
    calificacion TINYINT
        NULL,
    CONSTRAINT `PKC_Alumno/Materia_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_materia),
    CONSTRAINT `FKC_Alumno/Materia_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Materia_refsMateria` FOREIGN KEY (PK_Materia) REFERENCES Materia(PK_nombre)
) COMMENT 'Un alumno rinde varias materias, y una materia se imparte a varios alumnos';

/*
    Taller/RotacionTaller:
    Una rotacion de taller pasa por cada uno de los talleres del colegio a lo largo del año. Cada taller tiene una fecha 
    en la cual una rotacion estara cursando
*/
CREATE TABLE IF NOT EXISTS `Taller/RotacionTaller`(
    PK_Taller VARCHAR(50) 
        NOT NULL,
    PK_RotacionTaller INT 
        NOT NULL,
    fechaInicio DATE
        NULL,
    fechaFin DATE
        NULL,
    CONSTRAINT `PKC_Taller/RotacionTaller_compositeKey` PRIMARY KEY (PK_Taller, PK_RotacionTaller),
    CONSTRAINT `FKC_Taller/RotacionTaller_refsTaller` FOREIGN KEY (PK_Taller) REFERENCES Taller(PK_nombre),
    CONSTRAINT `FKC_Taller/RotacionTaller_refsRotacionTaller` FOREIGN KEY (PK_RotacionTaller) REFERENCES RotacionTaller(PK_id),
    CONSTRAINT `CC_Taller/RotacionTaller_checkDates` CHECK (fechaInicio < fechaFin)
) COMMENT 'Una rotacion de taller pasa por cada uno de los talleres del colegio a lo largo del año. Cada taller tiene una fecha en la cual una rotacion estara cursando';

