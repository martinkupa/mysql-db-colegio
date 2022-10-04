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
*/

CREATE DATABASE IF NOT EXISTS Colegio;

CREATE TABLE IF NOT EXISTS Colegio.Profesor(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    nombre VARCHAR(50) NOT NULL
    -- add more columns
);

CREATE TABLE IF NOT EXISTS Colegio.Curso(
    PK_id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    año TINYINT NOT NULL,
    division TINYINT NOT NULL,
    CONSTRAINT UC_Curso_naturalKey UNIQUE (año, division)
);

CREATE TABLE IF NOT EXISTS Colegio.Materia(
    PK_nombre VARCHAR(50) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Colegio.Alumno(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    FK_Curso INT NOT NULL,
    CONSTRAINT FKC_Alumno_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id)
);

CREATE TABLE IF NOT EXISTS Colegio.Horario(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    FK_Materia VARCHAR(50) NOT NULL,
    FK_Curso INT NOT NULL,
    FK_Profesor INT NOT NULL,
    hora TIME NOT NULL,
    CONSTRAINT FKC_Horario_refsMateria FOREIGN KEY (FK_Materia) REFERENCES Materia(PK_nombre),
    CONSTRAINT FKC_Horario_refsCurso FOREIGN KEY (FK_Curso) REFERENCES Curso(PK_id),
    CONSTRAINT FKC_Horario_refsProfesor FOREIGN KEY (FK_Profesor) REFERENCES Profesor(PK_id),
    CONSTRAINT UC_Horario_naturalKey UNIQUE (FK_Curso, hora)
);

CREATE TABLE IF NOT EXISTS Colegio.Asistencia(
    PK_id INT PRIMARY KEY AUTO_INCREMENT,
    FK_Horario INT NOT NULL,
    FK_Alumno INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME,
    estado ENUM('Presente', 'Ausente', 'Tarde'),
    CONSTRAINT FKC_Asistencia_refsHorario FOREIGN KEY (FK_Horario) REFERENCES Horario(PK_id),
    CONSTRAINT FKC_Asistencia_refsAlumno FOREIGN KEY (FK_Alumno) REFERENCES Alumno(PK_id),
    CONSTRAINT UC_Asistencia_naturalKey UNIQUE (FK_Horario, fecha, FK_Alumno)
);