Create table titulacion (
Idtitulacion varchar2(6) primary key,
Nombre varchar2(30)
);


Create table persona (
dni varchar2(11) primary key,
Nombre varchar2(30),
Apellido varchar2(30),
Ciudad varchar2(15),
Direccioncalle varchar2(30),
Direccionnum number,
Telefono varchar2(9),
Fecha_nacimiento date,
Varon number
);



create table alumno (
idalumno varchar2(7) primary key,
dni varchar2(11),
foreign key (dni) references persona(dni)
);

Create table profesor (
Idprofesor varchar2(4) primary key,
Dni varchar2(11),
Foreign key(dni) references persona(dni)
);

Create table asignatura (
Idasignatura varchar2(6) primary key,
Nombre varchar2(20),
Creditos number,
Cuatrimestre number,
Costebasico number,
Idprofesor varchar2(4),
Idtitulacion varchar2(6),
Curso number,
Foreign key(idprofesor) references profesor(idprofesor),
Foreign key (idtitulacion) references titulacion(idtitulacion)
);

Create table  alumno_asignatura (
Idalumno varchar2(7),
Idasignatura varchar2(6),
Numeromatricula number,
  PRIMARY KEY(idalumno,idasignatura,numeromatricula),
Foreign key(idalumno) references alumno(idalumno),
Foreign key(idasignatura) references asignatura(idasignatura)
);


insert into persona values ('16161616A','Luis','Ramirez','Haro','Pez','34','941111111',to_date('1/1/1969','dd/mm/yyyy'),'1');
insert into persona values ('17171717A','Laura','Beltran','Madrid','Gran Va','23','912121212',to_date('8/8/1974','dd/mm/yyyy'),'0');
insert into persona values ('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313',to_date('2/2/1980','dd/mm/yyyy'),'1');
insert into persona values ('19191919A','Juan','Sanchez','Bilbao','Melancola','7','944141414',to_date('3/2/1966','dd/mm/yyyy'),'1');
insert into persona values ('20202020A','Luis','Jimenez','Najera','Cigea','15','941151515',to_date('3/3/1979','dd/mm/yyyy'),'1');
insert into persona values ('21212121A','Rosa','Garcia','Haro','Alegra','16','941161616',to_date('4/4/1978','dd/mm/yyyy'),'0');
insert into persona values ('23232323A','Jorge','Saenz','Sevilla','Luis Ulloa','17','941171717',to_date('9/9/1978','dd/mm/yyyy'),'1');
insert into persona values ('24242424A','Mara','Gutierrez','Sevilla','Avda. de la Paz','18','941181818',to_date('10/10/1964','dd/mm/yyyy'),'0');
insert into persona values ('25252525A','Rosario','Diaz','Sevilla','Percebe','19','941191919',to_date('11/11/1971','dd/mm/yyyy'),'0');
insert into persona values ('26262626A','Elena','Gonzalez','Sevilla','Percebe','20','941202020',to_date('5/5/1975','dd/mm/yyyy'),'0');


insert into alumno values ('A010101','21212121A');
insert into alumno values ('A020202','18181818A');
insert into alumno values ('A030303','20202020A');
insert into alumno values ('A040404','26262626A');
insert into alumno values ('A121212','16161616A');
insert into alumno values ('A131313','17171717A');


insert into profesor values ('P101','19191919A');
insert into profesor values ('P117','25252525A');
insert into profesor values ('P203','23232323A');
insert into profesor values ('P204','26262626A');
insert into profesor values ('P304','24242424A');


insert into titulacion values ('130110','Matematicas');
insert into titulacion values ('150210','Quimicas');
insert into titulacion values ('160000','Empresariales');


insert into asignatura values ('000115','Seguridad Vial','4','1','30 ','P204',null,null);
insert into asignatura values ('130113','Programacion I', '9','1','60 ','P101','130110','1');
insert into asignatura values ('130122','Analisis II',    '9','2','60 ','P203','130110','2');
insert into asignatura values ('150212','Quimica Fisica','4','2','70','P304','150210','1');
insert into asignatura values ('160002','Contabilidad','6','1','70','P117','160000','1');


insert into alumno_asignatura values('A010101','150212','1');
insert into alumno_asignatura values('A020202','130113','1');
insert into alumno_asignatura values('A020202','150212','2');
insert into alumno_asignatura values('A030303','130113','3');
insert into alumno_asignatura values('A030303','150212','1');
insert into alumno_asignatura values('A030303','130122','2');
insert into alumno_asignatura values('A040404','130122','1');
insert into alumno_asignatura values('A121212','000115','1');
insert into alumno_asignatura values('A131313','160002','4');




-- EJERCICIOS -- 

-- 1 --
SELECT asignatura.idtitulacion,nombre,costebasico 
FROM asignatura
WHERE idtitulacion IS NOT null
GROUP BY idtitulacion,nombre,costebasico 
ORDER BY costebasico DESC, nombre ASC
;
-- 2 --
SELECT nombre,apellido
FROM persona,profesor
WHERE persona.dni = profesor.dni;
-- 3 --
SELECT asignatura.nombre
FROM asignatura,profesor,persona
WHERE persona.ciudad LIKE 'Sevilla' 
AND persona.dni = profesor.dni
AND profesor.idprofesor = asignatura.idprofesor ;
-- 4 --
SELECT nombre,apellido
FROM persona,alumno
WHERE alumno.dni = persona.dni;
-- 5 --
SELECT persona.dni,nombre,apellido
FROM persona,alumno
WHERE alumno.dni = persona.dni
AND persona.ciudad LIKE 'Sevilla';
-- 6 --
SELECT persona.dni,persona.nombre,apellido
FROM persona,alumno,alumno_asignatura,asignatura
WHERE persona.dni = alumno.dni
AND alumno.idalumno = alumno_asignatura.idalumno 
AND alumno_asignatura.idasignatura = asignatura.idasignatura 
AND asignatura.nombre LIKE 'Seguridad Vial';
-- 7 --
SELECT DISTINCT titulacion.idtitulacion
FROM titulacion,alumno_asignatura,alumno,asignatura
WHERE alumno.dni LIKE '20202020A'
AND titulacion.idtitulacion = asignatura.idtitulacion 
AND asignatura.idasignatura = alumno_asignatura.idasignatura 
AND alumno_asignatura.idalumno = alumno.idalumno; 
-- 8 --
SELECT asignatura.nombre
FROM persona,alumno,alumno_asignatura,asignatura
WHERE persona.nombre LIKE 'Rosa'
AND persona.apellido LIKE 'Garcia'
AND persona.dni = alumno.dni
AND alumno.idalumno = alumno_asignatura.idalumno 
AND alumno_asignatura.idasignatura = asignatura.idasignatura ;
-- 9 --
SELECT AL.DNI
FROM asignatura, ALUMNO_ASIGNATURA AA, ALUMNO AL, PROFESOR PR, PERSONA P
WHERE AL.IDALUMNO = AA.IDALUMNO 
AND P.DNI = PR.DNI 
AND PR.IDPROFESOR = asignatura.idprofesor 
AND asignatura.idasignatura = AA.idasignatura 
AND P.NOMBRE = 'Jorge' 
AND P.APELLIDO = 'Saenz';
-- 10 --
SELECT a2.dni,p3.nombre,p3.apellido
FROM persona p,profesor p2,asignatura a,alumno_asignatura aa,persona p3,alumno a2
WHERE p.dni = p2.dni
AND p2.idprofesor = a.idprofesor 
AND a.idasignatura = aa.idasignatura 
AND aa.idalumno = a2.idalumno 
AND a2.dni = p3.dni
AND p.nombre LIKE 'Jorge' 
AND p.apellido LIKE 'Saenz';

-- 11 --
SELECT DISTINCT titulacion.nombre
FROM titulacion,asignatura
WHERE creditos>=4
AND titulacion.idtitulacion = asignatura.idtitulacion;
-- 12 --
SELECT asignatura.nombre, creditos, titulacion.nombre titulacion
FROM asignatura,titulacion
WHERE cuatrimestre=1
AND asignatura.idtitulacion=titulacion.idtitulacion(+);
-- 13 --
SELECT asignatura.nombre,costebasico,persona.nombre,persona.apellido
FROM asignatura,persona,alumno_asignatura,alumno
WHERE creditos>=4.5
AND alumno_asignatura.idasignatura = asignatura.idasignatura
AND alumno.idalumno = alumno_asignatura.idalumno 
AND persona.dni = alumno.dni;
-- 14 --
SELECT persona.nombre
FROM profesor,asignatura,persona
WHERE persona.dni = profesor.dni
AND profesor.idprofesor = asignatura.idprofesor 
AND asignatura.costebasico BETWEEN 25 AND 35;
-- 15 --
SELECT DISTINCT persona.nombre
FROM persona,alumno,asignatura,alumno_asignatura
WHERE alumno_asignatura.idasignatura =150212 
OR alumno_asignatura.idasignatura = 130113 
OR (alumno_asignatura.idasignatura = 150212
AND alumno_asignatura.idasignatura = 130113)
AND alumno_asignatura.idalumno = alumno.idalumno 
AND alumno.dni = persona.dni;
-- 16 --
SELECT asignatura.nombre, titulacion.nombre
FROM asignatura,titulacion
WHERE cuatrimestre=2
AND creditos != 6
AND asignatura.idtitulacion = titulacion.idtitulacion;
-- 17 --
SELECT DISTINCT asignatura.nombre,creditos*10 horas,alumno.dni
FROM persona,asignatura,alumno,alumno_asignatura
WHERE persona.dni = alumno.dni
AND alumno.idalumno = alumno_asignatura.idalumno 
AND alumno_asignatura.idasignatura = asignatura.idasignatura;
-- 18 --
SELECT DISTINCT  persona.nombre
FROM persona,alumno,alumno_asignatura,asignatura
WHERE persona.varon=0
AND persona.ciudad LIKE 'Sevilla'
AND persona.dni = alumno.dni
AND alumno_asignatura.idalumno = alumno.idalumno
;-- 19 --
SELECT nombre
FROM asignatura
WHERE curso=1
AND lower(idprofesor) like 'p101';
-- 20 --
SELECT DISTINCT persona.nombre
FROM alumno_asignatura,alumno,persona
WHERE alumno_asignatura.idalumno = alumno.idalumno
AND persona.dni = alumno.dni
AND numeromatricula >= 3; 