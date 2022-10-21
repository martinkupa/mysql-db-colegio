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
);

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
    CONSTRAINT UC_Curso_naturalKey UNIQUE (año, division)
);

CREATE TABLE IF NOT EXISTS Materia(
    PK_nombre VARCHAR(50) 
        PRIMARY KEY
        CHECK (PK_nombre != "")
);

CREATE TABLE IF NOT EXISTS Taller(
    PK_nombre VARCHAR(50) 
        PRIMARY KEY
        CHECK (PK_nombre != ""),
    FK_Profesor VARCHAR(20)
        NOT NULL,
    CONSTRAINT FKC_Taller_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni)
);

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
);

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
);

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
);

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
    mayoriaEdad BIT 
        NOT NULL,
    FK_año TINYINT 
        NOT NULL,
    FK_division TINYINT 
        NOT NULL,
    FK_rotacion TINYINT 
        NULL,
    CONSTRAINT FKC_Alumno_refsCursoNaturalKey FOREIGN KEY (FK_año, FK_division) REFERENCES Curso(año, division),
    CONSTRAINT FKC_Alumno_refsRotacionTallerNaturalKey FOREIGN KEY (FK_año, FK_rotacion) REFERENCES RotacionTaller(año, rotacion)
);

CREATE TABLE IF NOT EXISTS Horario(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_Curso INT 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    hora TIME 
        NOT NULL,
    FK_Materia VARCHAR(50) 
        NOT NULL,
    FK_Profesor VARCHAR(20) 
        NOT NULL,
    CONSTRAINT FKC_Horario_refsMateria FOREIGN KEY (FK_Materia) REFERENCES Materia(PK_nombre),
    CONSTRAINT FKC_Horario_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT FKC_Horario_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_dni),
    CONSTRAINT UC_Horario_naturalKey UNIQUE (FK_Curso, dia, hora)
);

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
    CONSTRAINT UC_HorarioCursoOptativo_refsCursoOptativo FOREIGN KEY (FK_CursoOptativo) REFERENCES CursoOptativo(PK_id)
);

CREATE TABLE IF NOT EXISTS EntradaCurso(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_Curso INT 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    actividad ENUM("Laboratorio", "Curricular", "Ed. Fisica") 
        NOT NULL,
    CONSTRAINT UC_EntradaCurso_naturalKey UNIQUE (FK_Curso, dia, horaEntrada),
    CONSTRAINT FKC_EntradaCurso_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id)
);

CREATE TABLE IF NOT EXISTS EntradaRotacionTaller(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_RotacionTaller INT 
        NOT NULL,
    horaEntrada TIME 
        NOT NULL,
    horaSalida TIME 
        NOT NULL,
    dia ENUM("Lunes", "Martes", "Miercoles", "Jueves", "Viernes") 
        NOT NULL,
    CONSTRAINT UC_EntradaRotacionTaller_naturalKey UNIQUE (FK_RotacionTaller, dia, horaEntrada),
    CONSTRAINT FKC_EntradaRotacionTaller_refsRotacionTaller FOREIGN KEY (FK_RotacionTaller) REFERENCES RotacionTaller(PK_id)
);

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
        NOT NULL 
        DEFAULT (CURRENT_TIME()),
    estado ENUM("Presente", "Ausente", "Tarde")
        NOT NULL,
    CONSTRAINT UC_AsistenciaRotacionTaller_naturalKey UNIQUE (FK_EntradaRotacionTaller, fecha, FK_Alumno),
    CONSTRAINT FKC_AsistenciaRotacionTaller_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT FKC_AsistenciaRotacionTaller_refsEntradaRotacionTaller FOREIGN KEY (FK_EntradaRotacionTaller) REFERENCES EntradaRotacionTaller(PK_id)
);

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
);

CREATE TABLE IF NOT EXISTS AsistenciaAlumno(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT, -- Surrogate key
    FK_EntradaCurso INT 
        NOT NULL,
    FK_Alumno VARCHAR(20) 
        NOT NULL,
    fecha DATE 
        NOT NULL 
        DEFAULT (CURRENT_DATE()),
    horaLlegada TIME 
        NOT NULL 
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
    CONSTRAINT UC_AsistenciaAlumno_naturalKey UNIQUE (FK_EntradaCurso, fecha, FK_Alumno)
);

CREATE TABLE IF NOT EXISTS AsistenciaProfesor(
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
    -- Professor is already referenced in the 'Horarios' table, there is no need for a FOREING KEY
);

CREATE TABLE IF NOT EXISTS ExcepcionDia(
    fecha DATE 
        PRIMARY KEY,
    descripcion VARCHAR(200)
        NULL
        CHECK (descripcion != "")
);

CREATE TABLE IF NOT EXISTS ExcepcionEntrada(
    PK_id INT 
        PRIMARY KEY 
        AUTO_INCREMENT,
    FK_EntradaCurso INT 
        NOT NULL,
    fecha DATE 
        NOT NULL,
    horaEntrada TIME
        NOT NULL,
    descripcion VARCHAR(200)
        NULL
        CHECK (descripcion != ""),
    CONSTRAINT FKC_ExcepcionEntrada_refsEntradaCurso FOREIGN KEY (FK_EntradaCurso) REFERENCES EntradaCurso(PK_id),
    CONSTRAINT UC_ExcepcionEntrada_naturalKey UNIQUE (FK_EntradaCurso, fecha)
);

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
);

CREATE TABLE IF NOT EXISTS `Alumno/Responsable`(
    PK_dniAlumno VARCHAR(20) 
        NOT NULL,
    PK_dniResponsable VARCHAR(20) 
        NOT NULL,
    CONSTRAINT `PKC_Alumno/Responsable_compositeKey` PRIMARY KEY (PK_dniAlumno, PK_dniResponsable),
    CONSTRAINT `FKC_Alumno/Responsable_refsAlumno` FOREIGN KEY (PK_dniAlumno) REFERENCES Alumno(PK_dni),
    CONSTRAINT `FKC_Alumno/Responsable_refsResponsable` FOREIGN KEY (PK_dniResponsable) REFERENCES Responsable(PK_dni)
);

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
);

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
    CONSTRAINT `FKC_Taller/RotacionTaller_refsRotacionTaller` FOREIGN KEY (PK_RotacionTaller) REFERENCES RotacionTaller(PK_id)
);