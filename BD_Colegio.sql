/*
    Naming conventions:
        * Table names are capitalized: `Person`
        * Column names are camelCase: `userName`
        * Primary keys use the PK prefix: `PK_bookId`
        * Foreign keys use the FK prefix, followed by the name of the table being referenced,
          followed by the column name: `FK_Author_bookAuthor`
          If the column name is redundant, it can be ommited: `FK_Author`
        * Constraint names use a custom prefix ending with the letter C that describes the type of the constraint,
          followed by the table name, followed by the constraint name in camel case: `UC_Book_naturalKey` `FKC_Book_refsAuthor`
        * Trigger
*/

CREATE DATABASE IF NOT EXISTS Colegio;

USE Colegio;

CREATE TABLE IF NOT EXISTS Profesor(
    PK_dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    tarjetaId TEXT NOT NULL,
    direccion VARCHAR(200),
    email VARCHAR(200) NOT NULL,
    fechaNacimiento DATE
);

CREATE TABLE IF NOT EXISTS Curso(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    año TINYINT NOT NULL,
    division TINYINT NOT NULL,
    orientacion ENUM('Computacion', 'Automotor') NOT NULL,
    CONSTRAINT UC_Curso_naturalKey UNIQUE (año, division)
);

CREATE TABLE IF NOT EXISTS Materia(
    PK_nombre VARCHAR(50) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Responsable(
    PK_dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    fechaNacimiento DATE
);

CREATE TABLE IF NOT EXISTS Alumno(
    PK_dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    tarjetaId TEXT NOT NULL,
    FK_Responsable VARCHAR(20) DEFAULT ("__FLAG_DEFAULT_e2Hh5"), -- here, the DEFAULT is simply a flag for the trigger
    foto TEXT, -- svg base64
    FK_Curso INT NOT NULL,
    CONSTRAINT FKC_Alumno_refsResponsable FOREIGN KEY (FK_Responsable) REFERENCES Responsable(PK_dni),
    CONSTRAINT FKC_Alumno_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id)
);

DELIMITER $$
CREATE TRIGGER BI_Alumno_validateFields BEFORE INSERT ON Alumno FOR EACH ROW
BEGIN
    -- If the 'FK_Responsable' field is not given a value on the INSERT statment, raise an exception. This way, 'FK_responsable' will only be NULL if explicitly inserted as such
    IF NEW.FK_Responsable LIKE "__FLAG_DEFAULT_e2Hh5" THEN
        SIGNAL SQLSTATE "HY000"
            SET MESSAGE_TEXT= "Field 'FK_Responsable' must be stated explicitly";
    END IF;
END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS Horario(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_Curso INT NOT NULL,
    hora TIME NOT NULL,
    FK_Materia VARCHAR(50) NOT NULL,
    FK_Profesor VARCHAR(20) NOT NULL,
    CONSTRAINT FKC_Horario_refsMateria FOREIGN KEY (FK_Materia) REFERENCES Materia(PK_nombre),
    CONSTRAINT FKC_Horario_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT FKC_Horario_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni),
    CONSTRAINT UC_Horario_naturalKey UNIQUE (FK_Curso, hora)
);

CREATE TABLE IF NOT EXISTS AsistenciaAlumno(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_Horario INT NOT NULL,
    FK_Alumno VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE()),
    horaLlegada TIME DEFAULT (CURRENT_TIME()),
    estado ENUM('Presente', 'Ausente', 'Tarde'),
    CONSTRAINT FKC_AsistenciaAlumno_refsHorario FOREIGN KEY (FK_Horario) REFERENCES Horario(PK_id),
    CONSTRAINT FKC_AsistenciaAlumno_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT UC_AsistenciaAlumno_naturalKey UNIQUE (FK_Horario, fecha, FK_Alumno)
);

CREATE TABLE IF NOT EXISTS AsistenciaProfesor(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_Horario INT NOT NULL,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE()),
    horaLlegada TIME DEFAULT (CURRENT_TIME()),
    estado ENUM('Presente', 'Ausente', 'Tarde'),
    CONSTRAINT FKC_AsistenciaProfesor_refsHorario FOREIGN KEY (FK_Horario) REFERENCES Horario(PK_id),
    CONSTRAINT UC_AsistenciaProfesor_naturalKey UNIQUE (FK_Horario, fecha)
    -- Professor is already referenced in the 'Horarios' table, there is no need for a FOREING KEY
);

CREATE TABLE IF NOT EXISTS `Alumno/Materia`(
    PK_dniAlumno VARCHAR(20) NOT NULL,
    PK_materia VARCHAR(50) NOT NULL,
    calificacion TINYINT,
    CONSTRAINT `PKC_Alumno/Materia_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_materia),
    CONSTRAINT `FKC_Alumno/Materia_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Materia_refsMateria` FOREIGN KEY (PK_materia) REFERENCES Materia(PK_nombre)
);