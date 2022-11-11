/*
    Tablas:
    Profesor
    Taller
    CursoOptativo
    Responsable
*/
INSERT INTO profesor VALUES ('00110011', 'Elmer', 'Galaga', '133713371337', '00022', '0765 Sancho Pac-Man', 'galaga@namco.com', '1981-9-20');
INSERT INTO profesor VALUES ('11001100', 'María', 'Mappy', '12341234123', '00011', '1122 Tito Faez', 'mappy@colegioreal.gov.ar', '1983-5-15');
INSERT INTO profesor VALUES ('00000001', 'Martín', 'Kupa', '432143214321', '10000', '0001 Obelisco', 'kupa@colegioreal.gov.ar', '0001-1-01');
INSERT INTO profesor VALUES ('00000002', 'Joaquín', 'Da Silva', '3333333333', '00002', '0002 Av Siempreviva', 'dasilva@colegiofalso.gov.ar', '2004-4-2');
INSERT INTO profesor VALUES ('00000003', 'Nehuen', 'Laje', '222222222222', '00003', '0004 Carlos Garío', 'laje@colegiofalso.gov.ar', '2004-11-7');
INSERT INTO profesor VALUES ('00000004', 'Takumi', 'Fujiwara', '11111111111', '00086', '1234 Mt. Akina', 'takumi@speedstars.gov.ar', '1984-10-2');
INSERT INTO profesor VALUES ('50000005', 'Homero', 'Simpson', '232232222322', '00005', '0784 Avenida Siempreviva', 'homero@plantanuclear.gov.ar', '1968-1-20');
INSERT INTO profesor VALUES ('00000008', 'Mario', 'Mario', '322262222223', '10302', '1921 Calle Champiñón', 'mario@reinochmp.gov.ar', '1983-9-4');
INSERT INTO profesor VALUES ('00000009', 'Simón', 'Nombrefalso', '123456789101', '12345', '4321 Calle Nombrecreativo', 'simon@mequedesinideas.gov.ar', '2000-1-1');
INSERT INTO profesor VALUES ('00000010', 'Carlos', 'Carlíos', '022222222222', '00009', '6789 Carlos Carío', 'carlos@colegioficticio.gov.ar', '1999-12-30');

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

Da el error "Entrada duplicada '1' para la clave 'PRIMARY'"
INSERT INTO cursooptativo VALUES ('01', '00110011', '1°', 'Aleman');
INSERT INTO cursooptativo VALUES ( '11001100', '2°', 'Aleman');
INSERT INTO cursooptativo VALUES ( '00000001', '3°', 'Aleman');
INSERT INTO cursooptativo VALUES ( '00000002', '4°', 'Aleman');
INSERT INTO cursooptativo VALUES ('00000003', '5°', 'Aleman');
INSERT INTO cursooptativo VALUES ( '00000004', '1°', 'Autocad');
INSERT INTO cursooptativo VALUES ('50000005', '2°', 'Autocad');
INSERT INTO cursooptativo VALUES ( '00000008', '3°', 'Autocad');
INSERT INTO cursooptativo VALUES ( '00000009', '4°', 'Autocad');
INSERT INTO cursooptativo VALUES ('00000010', '5°', 'Autocad'); 