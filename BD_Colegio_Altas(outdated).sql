-- Dasilva Materia:
INSERT INTO materia VALUES ('Lengua y Literatura');
INSERT INTO materia VALUES ('Matematica');
INSERT INTO materia VALUES ('Fisica');
INSERT INTO materia VALUES ('Educacion Fisica');
INSERT INTO materia VALUES ('Historia');
INSERT INTO materia VALUES ('Economia');
INSERT INTO materia VALUES ('Base de datos');
INSERT INTO materia VALUES ('Dibujo Tecnico');
INSERT INTO materia VALUES ('Redes');
INSERT INTO materia VALUES ('Algoritmos');

-- Laje Profesor:
INSERT INTO profesor VALUES ('00110011', 'Elmer', 'Galaga', '133713371337', '00022', '0765 Sancho Pac-Man', 'galaga@namco.com', '1981-9-20');
INSERT INTO profesor VALUES ('11001100', 'María', 'Mappy', '12341234123', '00011', '1122 Tito Faez', 'mappy@colegior, eal.gov.ar', '1983-5-15');
INSERT INTO profesor VALUES ('00000001', 'Martín', 'Kupa', '432143214321', '10000', '0001 Obelisco', 'kupa@colegioreal.gov.ar', '0001-1-01');
INSERT INTO profesor VALUES ('00000002', 'Joaquín', 'Da Silva', '3333333333', '00002', '0002 Av Siempreviva', 'dasilva@colegiofalso.gov.ar', '2004-4-2');
INSERT INTO profesor VALUES ('00000003', 'Nehuen', 'Laje', '222222222222', '00003', '0004 Carlos Garío', 'laje@colegiofalso.gov.ar', '2004-11-7');
INSERT INTO profesor VALUES ('00000004', 'Takumi', 'Fujiwara', '11111111111', '00086', '1234 Mt. Akina', 'takumi@speedstars.gov.ar', '1984-10-2');
INSERT INTO profesor VALUES ('50000005', 'Homero', 'Simpson', '232232222322', '00005', '0784 Avenida Siempreviva', 'homero@plantanuclear.gov.ar', '1968-1-20');
INSERT INTO profesor VALUES ('00000008', 'Mario', 'Mario', '322262222223', '10302', '1921 Calle Champiñón', 'mario@reinochmp.gov.ar', '1983-9-4');
INSERT INTO profesor VALUES ('00000009', 'Simón', 'Nombrefalso', '123456789101', '12345', '4321 Calle Nombrecreativo', 'simon@mequedesinideas.gov.ar', '2000-1-1');
INSERT INTO profesor VALUES ('00000010', 'Carlos', 'Carlíos', '022222222222', '00009', '6789 Carlos Carío', 'carlos@colegioficticio.gov.ar', '1999-12-30');

-- Laje Taller:
INSERT INTO taller VALUES ('Soldadura', '00110011');
INSERT INTO taller VALUES ('Fundición', '11001100');
INSERT INTO taller VALUES ('Electrónica', '00000001');
INSERT INTO taller VALUES ('Carpentería', '00000002');
INSERT INTO taller VALUES ('Automotores 1', '00000003');
INSERT INTO taller VALUES ('Automotores 2', '00000004');
INSERT INTO taller VALUES ('Automotores 3', '50000005');
INSERT INTO taller VALUES ('Computación 1', '00000008');
INSERT INTO taller VALUES ('Computación 2', '00000009');
INSERT INTO taller VALUES ('Computación 3', '00000010');


-- Laje CursoOptativo:
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('1',  '00110011', '1', 'Aleman');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('2',  '11001100', '2', 'Aleman');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('3',  '00000001', '3', 'Aleman');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('4',  '00000002', '4', 'Aleman');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('5', '00000003', '5', 'Aleman');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('6',  '00000004', '1', 'Autocad');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('7', '50000005', '2', 'Autocad');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('8',  '00000008', '3', 'Autocad');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('9',  '00000009', '4', 'Autocad');
INSERT INTO cursooptativo (PK_id, FK_profesor, division, orientacion) VALUES ('10', '00000010', '5', 'Autocad'); 


-- Dasilva RotacionTaller:
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000003','4',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000002','5',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000001','2',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('11001100','1',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00110011','6',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000001','4',2);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('50000005','3',1);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000004','2',2);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000010','1',2);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000009','2',3);
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000008','6',2);


-- Dasilva Curso:
INSERT INTO curso(año,division,orientacion) VALUES (1,1,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (1,2,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (1,3,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (1,4,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (1,5,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (1,6,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (2,1,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (2,2,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (2,3,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (2,4,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (2,5,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (3,1,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (3,2,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (3,3,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (3,4,'curso basico');
INSERT INTO curso(año,division,orientacion) VALUES (4,1,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (4,2,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (4,3,'automotor');
INSERT INTO curso(año,division,orientacion) VALUES (4,4,'automotor');
INSERT INTO curso(año,division,orientacion) VALUES (5,1,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (5,2,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (5,3,'automotor');
INSERT INTO curso(año,division,orientacion) VALUES (5,4,'automotor');
INSERT INTO curso(año,division,orientacion) VALUES (6,1,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (6,2,'computacion');
INSERT INTO curso(año,division,orientacion) VALUES (6,3,'automotor');
INSERT INTO curso(año,division,orientacion) VALUES (6,4,'automotor');

-- Dasilva Alumno:
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54781771','Pablo','Bermudez','2003-9-19','Cullen_2023','pablocapo@gmail.com','543G76A','1','3','2',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54682333','Anasui','Gutierrez','2004-10-20','Av.Truinvirato 2013','Anasuigutierrez2004@gmail.com','5165D6A','0','4','1',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('48291924','Astor','Cujoh','2005-5-31','Av Maipú 492','astoretegamer@gmail.com','55345AD','0','2','1',2);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('51235361','Ezequiel','Trefiletti','2001-3-10','Av Belgrano Sur 3185','Ezequielelmejor@gmail.com','5df23A','1','6','1',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('55123123','Jose','Jovin','2006-7-19','Arenales 3648','jojovinpro2006@hotmail.com.ar','649F9D1','0','1','2',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54123649','Jorge','Silva','2004-08-01','Florida 700','jorgecolegio@gmail.com','523F2DA','0','3','4',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('52354245','Lozano','Valencia','2002-12-9','Av Colón 628','Loza2002@gmail.com','51235fd','1','5','2',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54231234','Javier','Garcia','2003-01-05','Av Rivadavia 1291','javielmejor@gmail.com','54f31ad','1','4','2',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('53412356','Dante','Sparta','2004-3-11','Av Gaona 2525','dantewahoo@gmail.com','9df2af','0','3','4',1);
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('53474561','Lautaro','Aleta','2002-06-09','Av Corrientes 655','lautarobasado@gmail.com','3254fd1','1','6','2',2);

-- Kupa Alumno/Materia
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '54781771', 9);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '54781771', 7);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '54781771', 5);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '54781771', 4);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '54781771', 2);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '54781771', 4);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '54781771', 9);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '54781771', 9);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '54781771', 3);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '54781771', 1);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '54682333', 8);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '54682333', 4);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '54682333', 5);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '54682333', 8);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '54682333', 9);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '54682333', 4);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '54682333', 6);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '54682333', 2);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '54682333', 8);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '54682333', 8);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '48291924', 1);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '48291924', 1);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '48291924', 5);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '48291924', 8);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '48291924', 8);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '48291924', 4);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '48291924', 3);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '48291924', 7);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '48291924', 1);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '48291924', 8);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '51235361', 3);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '51235361', 9);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '51235361', 3);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '51235361', 9);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '51235361', 5);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '51235361', 7);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '51235361', 1);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '51235361', 7);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '51235361', 6);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '51235361', 2);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '55123123', 3);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '55123123', 3);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '55123123', 2);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '55123123', 2);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '55123123', 4);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '55123123', 1);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '55123123', 5);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '55123123', 4);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '55123123', 1);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '55123123', 1);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '54123649', 8);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '54123649', 3);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '54123649', 3);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '54123649', 2);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '54123649', 3);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '54123649', 7);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '54123649', 4);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '54123649', 5);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '54123649', 9);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '54123649', 9);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '52354245', 1);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '52354245', 9);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '52354245', 6);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '52354245', 5);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '52354245', 7);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '52354245', 6);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '52354245', 4);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '52354245', 2);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '52354245', 8);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '52354245', 2);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '54231234', 7);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '54231234', 5);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '54231234', 7);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '54231234', 8);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '54231234', 6);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '54231234', 4);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '54231234', 8);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '54231234', 7);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '54231234', 8);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '54231234', 4);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '53412356', 5);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '53412356', 6);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '53412356', 9);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '53412356', 8);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '53412356', 4);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '53412356', 3);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '53412356', 1);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '53412356', 2);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '53412356', 1);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '53412356', 7);
INSERT INTO `Alumno/Materia` VALUES ('Matematica', '53474561', 6);
INSERT INTO `Alumno/Materia` VALUES ('Fisica', '53474561', 3);
INSERT INTO `Alumno/Materia` VALUES ('Historia', '53474561', 1);
INSERT INTO `Alumno/Materia` VALUES ('Economia', '53474561', 6);
INSERT INTO `Alumno/Materia` VALUES ('Redes', '53474561', 4);
INSERT INTO `Alumno/Materia` VALUES ('Algoritmos', '53474561', 3);
INSERT INTO `Alumno/Materia` VALUES ('Lengua y Literatura', '53474561', 2);
INSERT INTO `Alumno/Materia` VALUES ('Base de datos', '53474561', 2);
INSERT INTO `Alumno/Materia` VALUES ('Educacion Fisica', '53474561', 3);
INSERT INTO `Alumno/Materia` VALUES ('Dibujo Tecnico', '53474561', 6);

-- Laje Responsable:
INSERT INTO responsable VALUES ('00100100', 'Marge', 'Simpson', '990900909090', '0784 Av Siempreviva', 'Marge@gmail.com', '1974-02-05');
INSERT INTO responsable VALUES ('10200200', 'Filiberto', 'Fitzergard', '880800808080', '6789 Calle Fantástica', 'Filiberto@ymail.com', '1980-11-13');
INSERT INTO responsable VALUES ('30030030', 'Luis', 'Spinaca', '777700707070', '5467 Coronel Cobayo', 'Spinaca@gmail.com', '1965-01-23');
INSERT INTO responsable VALUES ('04040040', 'Ying', 'Zakama', '111121113111', '5545  Calle Azul', 'Ying@Minimazaibatsu.com', '1998-07-18');
INSERT INTO responsable VALUES ('50505050', 'Sonia', 'Topper', '432123432123', '4321  Boulevard Equitativo', 'Sonia@aol.com', '1980-06-20');
INSERT INTO responsable VALUES ('66600616', 'Lucifer', 'Infernus', '123454321234', '6666 Infierno', 'satan@hellmail.com', '0666-06-16');
INSERT INTO responsable VALUES ('07047070', 'William', 'Wakesphere', '6789235678910', '8768 Villa Nacimiento', 'wakesphere@jamlet.com', '1978-02-19');
INSERT INTO responsable VALUES ('02345090', 'Rezz', 'Sableponso', '6729436688212', '1111 Calle Responsable', 'Rezz@ponsabilidad.com', '1980-06-11');
INSERT INTO responsable VALUES ('27017376', 'Esteban', 'Quito', '1227265574410', '0001 Juegode Palabras', 'armandoesteban@quito.com', '2000-01-12');
INSERT INTO responsable VALUES ('11114444', 'Franco', 'Francostino', '5322212476910', '2345 Calle Genérica', 'Franco@franmail.com', '1960-01-29');

-- Laje Horario:
INSERT INTO horario VALUES (1, 1, 'Lunes', '03:00', '03:45', 'Matematica', '00110011');
INSERT INTO horario VALUES (2, 2, 'Lunes', '12:00', '12:45', 'Fisica', '11001100');
INSERT INTO horario VALUES (3, 3, 'Martes', '14:00', '14:45', 'Historia', '00000001');
INSERT INTO horario VALUES (4, 4, 'Martes', '13:30', '13:45', 'Economia', '00000002');
INSERT INTO horario VALUES (5, 5, 'Miércoles', '11:45', '11:50', 'Redes', '00000003');
INSERT INTO horario VALUES (6, 6, 'Miércoles', '20:00', '20:15', 'Algoritmos', '00000004');
INSERT INTO horario VALUES (7, 7, 'Jueves', '08:45', '09:30', 'Lengua y Literatura', '50000005');
INSERT INTO horario VALUES (8, 8, 'Jueves', '15:00', '15:45', 'Educacion Fisica', '00000008');
INSERT INTO horario VALUES (9, 9, 'Viernes', '02:15', '03:00', 'Base de datos', '00000009');
INSERT INTO horario VALUES (10, 10, 'Viernes', '17:30', '19:00', 'Dibujo Tecnico', '00000010');

-- Laje HorarioCursoOptativo:
INSERT INTO horariocursooptativo VALUES (1, 1, 'Lunes', '01:00', '01:10');
INSERT INTO horariocursooptativo VALUES (2, 2, 'Lunes', '17:00', '17:10');
INSERT INTO horariocursooptativo VALUES (3, 3, 'Martes', '18:00', '18:10');
INSERT INTO horariocursooptativo VALUES (4, 4, 'Martes', '13:00', '13:10');
INSERT INTO horariocursooptativo VALUES (5, 5, 'Miércoles', '12:45', '12:50');
INSERT INTO horariocursooptativo VALUES (6, 6, 'Miércoles', '19:15', '19:20');
INSERT INTO horariocursooptativo VALUES (7, 7, 'Jueves', '12:00', '12:10');
INSERT INTO horariocursooptativo VALUES (8, 8, 'Jueves', '13:15', '13:30');
INSERT INTO horariocursooptativo VALUES (9, 9, 'Viernes', '05:00', '05:30');
INSERT INTO horariocursooptativo VALUES (10, 10, 'Viernes', '11:15', '11:20');

-- Zelada EntradaCurso:

insert into entradacurso Values('01','1','14:34','14:40','Lunes','Laboratorio');
insert into entradacurso Values('02','2','15:30','15:40','Martes','Curricular');
insert into entradacurso Values('03','3','15:40','15:50','Martes','Curricular');
insert into entradacurso Values('04','4','16:00','16:10','Miercoles','Ed, Fisica');
insert into entradacurso Values('05','5','17:20','17:30','Jueves','Laboratorio');
insert into entradacurso Values('06','6','17:40','17:50','Jueves','Laboratorio');
insert into entradacurso Values('07','1','18:30','18:40','Jueves','Laboratorio');
insert into entradacurso Values('08','2','18:00','18:10','Viernes','Ed, Fisica');
insert into entradacurso Values('09','3','18:20','18:30','Viernes','Ed, Fisica');
insert into entradacurso Values('10','4','18:40','20:30','Viernes','Ed, Fisica');

-- Zelada EntradaRotacionTaller:

insert into entradarotaciontaller Values('01','01','13:00','15:00','Lunes');
insert into entradarotaciontaller Values('02','02','13:10','15:10','Lunes');
insert into entradarotaciontaller Values('03','03','13:20','15:20','Martes');
insert into entradarotaciontaller Values('04','04','14:00','16:00','Miercoles');
insert into entradarotaciontaller Values('05','05','14:10','16:10','Miercoles');
insert into entradarotaciontaller Values('06','06','14:20','16:20','Miercoles');
insert into entradarotaciontaller Values('07','07','15:00','17:00','Jueves');
insert into entradarotaciontaller Values('08','08','15:10','17:10','Jueves');
insert into entradarotaciontaller Values('09','09','15:20','17:20','Viernes');
insert into entradarotaciontaller Values('10','10','16:00','18:00','Viernes');

-- Kupa AsistenciaAlumno:
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (1, '54781771', '2022-09-23', '04:30:43', 'Presente', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (2, '54682333', '2022-09-11', '18:25:36', 'Tarde', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (3, '48291924', '2022-09-13', '12:38:37', 'Tarde', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (4, '51235361', '2022-10-06', '09:07:02', 'Tarde', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (5, '55123123', '2022-08-31', '09:23:29', 'Tarde', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (6, '54123649', '2022-10-27', '20:21:20', 'Tarde', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (7, '52354245', '2022-11-08', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (8, '54231234', '2022-09-21', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (9, '53412356', '2022-09-30', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaAlumno(FK_EntradaCurso, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (10, '53474561', '2022-11-04', null, 'Ausente', NULL, NULL);


-- Kupa AsistenciaRotacionTaller:
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (1, '54781771', '2022-08-23', '21:22:14', 'Presente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (2, '54682333', '2022-10-10', '21:33:11', 'Presente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (3, '48291924', '2022-09-16', '03:16:40', 'Presente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (4, '51235361', '2022-11-10', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (5, '55123123', '2022-09-12', '18:42:52', 'Presente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (6, '54123649', '2022-09-28', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (7, '52354245', '2022-09-26', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (8, '54231234', '2022-11-16', '11:08:07', 'Presente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (9, '53412356', '2022-09-18', null, 'Ausente', NULL, NULL);
INSERT INTO AsistenciaRotacionTaller(FK_EntradaRotacionTaller, FK_Alumno, fecha, horaLlegada, estado, horaRetiro, FK_Responsable_firmaRetiro) VALUES (10, '53474561', '2022-09-28', '06:33:00', 'Presente', NULL, NULL);