/*
    Naming conventions:
        * Table names are PascalCase: `Person`
        * Column names are camelCase: `userName`
        * Primary keys use the PK prefix: `PK_bookId`
        * Foreign keys use the FK prefix, followed by the name of the table being referenced,
          followed by the column name: `FK_Author_bookAuthor`
          If the column name is redundant, it can be omitted: `FK_Author`
        * Constraint names use a custom prefix ending with the letter C that describes the type of the constraint,
          followed by the table name, followed by the constraint name in camel case: `UC_Book_naturalKey` `FKC_Book_refsAuthor`
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

CREATE TABLE IF NOT EXISTS CursoOptativo(
    PK_id INT PRIMARY KEY,
    FK_Profesor VARCHAR(20) NOT NULL,
    division INT NOT NULL,
    orientacion ENUM('Autocad', 'Aleman') NOT NULL,
    CONSTRAINT UC_CursoOptativo_naturalKey UNIQUE (division, orientacion),
    CONSTRAINT FKC_CursoOptativo_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
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
    mayoriaEdad TINYINT NOT NULL,
    foto TEXT, -- svg base64
    FK_Curso INT NOT NULL,
    CONSTRAINT FKC_Alumno_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id)
);

CREATE TABLE IF NOT EXISTS Horario(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_Curso INT NOT NULL,
    dia ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes') NOT NULL,
    hora TIME NOT NULL,
    FK_Materia VARCHAR(50) NOT NULL,
    FK_Profesor VARCHAR(20) NOT NULL,
    CONSTRAINT FKC_Horario_refsMateria FOREIGN KEY (FK_Materia) REFERENCES Materia(PK_nombre),
    CONSTRAINT FKC_Horario_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT FKC_Horario_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni),
    CONSTRAINT UC_Horario_naturalKey UNIQUE (FK_Curso, dia, hora)
);

CREATE TABLE IF NOT EXISTS HorarioCursoOptativo(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    FK_CursoOptativo INT NOT NULL,
    dia ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes') NOT NULL,
    horaEntrada TIME NOT NULL,
    horaSalida TIME NOT NULL,
    CONSTRAINT UC_HorarioCursoOptativo_naturalKey UNIQUE (FK_CursoOptativo, dia, horaEntrada),
    CONSTRAINT UC_HorarioCursoOptativo_refsCursoOptativo FOREIGN KEY (FK_CursoOptativo) REFERENCES CursoOptativo(PK_id)
);

CREATE TABLE IF NOT EXISTS EntradaCurso(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    FK_Curso INT NOT NULL,
    horaEntrada TIME NOT NULL,
    horaSalida TIME NOT NULL,
    dia ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes') NOT NULL,
    actividad ENUM('Laboratorio', 'Taller', 'Curricular', 'Ed. Fisica') NOT NULL,
    CONSTRAINT UC_EntradaCurso_naturalKey UNIQUE (FK_Curso, dia, horaEntrada),
    CONSTRAINT FKC_EntradaCurso_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id)
);

CREATE TABLE IF NOT EXISTS EntradaProfesor(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    FK_Profesor VARCHAR(20) NOT NULL,
    horaEntrada TIME NOT NULL,
    dia ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes') NOT NULL,
    CONSTRAINT UC_EntradaProfesor_naturalKey UNIQUE (FK_Profesor, dia, horaEntrada),
    CONSTRAINT FKC_EntradaProfesor_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
);

CREATE TABLE IF NOT EXISTS AsistenciaAlumno(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_EntradaCurso INT NOT NULL,
    FK_Alumno VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE()),
    horaLlegada TIME DEFAULT (CURRENT_TIME()),
    estado ENUM('Presente', 'Ausente', 'Tarde'),
    CONSTRAINT FKC_AsistenciaAlumno_refsEntradaCurso FOREIGN KEY (FK_EntradaCurso) REFERENCES EntradaCurso(PK_id),
    CONSTRAINT FKC_AsistenciaAlumno_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT UC_AsistenciaAlumno_naturalKey UNIQUE (FK_EntradaCurso, fecha, FK_Alumno)
);

CREATE TABLE IF NOT EXISTS AsistenciaProfesor(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    FK_EntradaProfesor INT NOT NULL,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE()),
    horaLlegada TIME DEFAULT (CURRENT_TIME()),
    estado ENUM('Presente', 'Ausente', 'Tarde'),
    CONSTRAINT FKC_AsistenciaProfesor_refsEntradaProfesor FOREIGN KEY (FK_EntradaProfesor) REFERENCES EntradaProfesor(PK_id),
    CONSTRAINT UC_AsistenciaProfesor_naturalKey UNIQUE (FK_EntradaProfesor, fecha)
    -- Professor is already referenced in the 'Horarios' table, there is no need for a FOREING KEY
);

CREATE TABLE IF NOT EXISTS `Alumno/Materia`(
    PK_Materia VARCHAR(50) NOT NULL,
    PK_dniAlumno VARCHAR(20) NOT NULL,
    calificacion TINYINT,
    CONSTRAINT `PKC_Alumno/Materia_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_materia),
    CONSTRAINT `FKC_Alumno/Materia_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Materia_refsMateria` FOREIGN KEY (PK_Materia) REFERENCES Materia(PK_nombre)
);


/*
    `AlumnoOptativas` represents a many to many relationship between `Alumnos` and `CursoOptativo`. Therefore, the usual 
    `table1/table2` naming convention should apply. However, there are certain aspects of this relationship that forced me 
    to make a separate table and use a composite FOREIGN KEY instead of a regular intermediate table.

    A student can only be part of one and only one division, of a given orientation. That is, a student cannot be in 2th 
    'Autocad' and 3th 'Autocad' at the same time. The UC_AlumnoOptativas_naturalKey prevents that from happening.
    Were I to make a FOREIGN KEY referencing the `CursoOptativo`'s surrogate key, I would not be able to make the 
    UC_AlumnoOptativas_naturalKey as I would not have access to the `orientacion` nor `division` fields.

    Futhermore, I need to check if `AlumnoOptativas`'s `orientacion` and `division` fields match those on the 
    `CursoOptativo` table. The only way to do that is by means of a composite FOREIGN KEY.
*/
CREATE TABLE IF NOT EXISTS AlumnoCursoOptativo(
    /* maybe a hash? */
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate Key
    FK_dniAlumno VARCHAR(20) NOT NULL,
    orientacion ENUM('Autocad', 'Aleman') NOT NULL,
    division INT NOT NULL,
    calificacion TINYINT,
    CONSTRAINT UC_AlumnoCursoOptativo_naturalKey UNIQUE (FK_dniAlumno, orientacion),
    CONSTRAINT FKC_AlumnoCursoOptativo_refsAlumno FOREIGN KEY (FK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT FKC_AlumnoCursoOptativo_refsCursoOptativoNaturalKey FOREIGN KEY (division, orientacion) REFERENCES CursoOptativo(division, orientacion) -- Order matters, make sure that the table being referenced has the fields of the unique constraint in the same order
);

CREATE TABLE IF NOT EXISTS `Alumno/Responsable`(
    PK_dniAlumno VARCHAR(20) NOT NULL,
    PK_dniResponsable VARCHAR(20) NOT NULL,
    CONSTRAINT `PKC_Alumno/Responsable_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_dniResponsable),
    CONSTRAINT `FKC_Alumno/Responsable_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Responsable_refsResponsable` FOREIGN KEY (PK_dniResponsable) REFERENCES Responsable(PK_dni)
);