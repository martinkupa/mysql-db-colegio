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
