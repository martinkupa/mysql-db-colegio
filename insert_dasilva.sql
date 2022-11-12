/*
    Tablas:
    Curso
    Materia
    RotacionTaller
    Alumno
*/
Materia:
INSERT INTO materias VALUES ('Lengua y Literatura');
INSERT INTO materias VALUES ('Matematica');
INSERT INTO materias VALUES ('Fisica');
INSERT INTO materias VALUES ('Educacion Fisica');
INSERT INTO materias VALUES ('Historia');
INSERT INTO materias VALUES ('Economia');
INSERT INTO materias VALUES ('Base de datos');
INSERT INTO materias VALUES ('Dibujo Tecnico');
INSERT INTO materias VALUES ('Redes');
INSERT INTO materias VALUES ('Algoritmos');

RotacionTaller:
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000003','4','computacion')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000002','5','automotor')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000001','2','Ciclo basico')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('11001100','1','Ciclo basico')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00110011','6','computacion')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000001','4','automotor')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('50000005','3','Ciclo basico')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000004','2','Ciclo basicor')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000010','1','Ciclo basico')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000009','2','Ciclo basico')
INSERT INTO rotaciontaller(FK_Profesor,año,rotacion) VALUES ('00000008','6','automotor')


Curso:
INSERT INTO curso(año,division,orientacion) VALUES (1°,1°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (1°,2°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (1°,3°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (1°,4°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (1°,5°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (1°,6°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (2°,1°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (2°,2°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (2°,3°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (2°,4°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (2°,5°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (3°,1°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (3°,2°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (3°,3°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (3°,4°,curso basico)
INSERT INTO curso(año,division,orientacion) VALUES (4°,1°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (4°,2°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (4°,1°,automotor)
INSERT INTO curso(año,division,orientacion) VALUES (4°,2°,automotor)
INSERT INTO curso(año,division,orientacion) VALUES (5°,1°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (5°,2°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (5°,1°,automotor)
INSERT INTO curso(año,division,orientacion) VALUES (5°,2°,automotor)
INSERT INTO curso(año,division,orientacion) VALUES (6°,1°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (6°,2°,computacion)
INSERT INTO curso(año,division,orientacion) VALUES (6°,1°,automotor)
INSERT INTO curso(año,division,orientacion) VALUES (6°,2°,automotor)

--Alumno
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54781771','Pablo','Bermudez','19-9-2003','Cullen_2023','pablocapo@gmail.com','543G76A','1','3°','2°','ciclo_basico')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54682333','Anasui','Gutierrez','20-10-2004','Av.Truinvirato 2013','Anasuigutierrez2004@gmail.com','5165D6A','0','4°','1°','Computacion')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('48291924','Astor','Cujoh','31-5-2005','Av Maipú 492','astoretegamer@gmail.com','55345AD','0','2°','1°','ciclo_basico')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('51235361','Ezequiel','Trefiletti','10-3-2001','Av Belgrano Sur 3185','Ezequielelmejor@gmail.com','5df23A','1','6°','1°','Automotor')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('55123123','Jose','Jovin','19-7-2006','Arenales 3648','jojovinpro2006@hotmail.com.ar','649F9D1','0','1°','2°','Ciclo_basico')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54123649','Jorge','Silva','01-08-2004','Florida 700','jorgecolegio@gmail.com','523F2DA','0','3°','4°','ciclo_basico');
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('52354245','Lozano','Valencia','9-12-2002','Av Colón 628','Loza2002@gmail.com','51235fd','1','5°','2°','computacion');
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('54231234','Javier','Garcia','05-01-2003','Av Rivadavia 1291','javielmejor@gmail.com','54f31ad','1','4°','2°','Computacion');
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('53412356','Dante','Sparta','11-3-2004','Av Gaona 2525','dantewahoo@gmail.com','9df2af','0','3°','4°','Ciclo_basico')
INSERT INTO alumno(PK_dni,nombre,apellido,fechaNacimiento,direccion,email,tarjetaId,mayoriaEdad,FK_año,FK_division,FK_rotacion) VALUES ('53474561','Lautaro','Aleta','09-06-2002','Av Corrientes 655','lautarobasado@gmail.com','3254fd1','1','6°','2°','Automotor');

                                                           
                                                                                                                                        

