-- DROP TABLES --
drop type Person_t force
/
drop type CampusClub_t force
/
drop type Faculty_t force
/
drop type Student_t force
/
drop type Department_T force
/
drop table Clubs force
/
drop table Person FORCE
/
drop table CampusClub force
/
drop table Faculty force
/
drop table Student force
/
drop table Department force
/
CREATE OR REPLACE TYPE Person_t AS OBJECT(
    pid VARCHAR(50),
    dob date,
    firstname VARCHAR(20),
    lastName VARCHAR(60)
) NOT FINAL;
/
-- CREATE OR REPLACE EDITIONABLE TYPE Department_t AS OBJECT(
CREATE OR REPLACE TYPE Department_t AS OBJECT(
    code VARCHAR(10),
    name VARCHAR(30)
);
/
CREATE OR REPLACE TYPE Student_t under person_t(
    status VARCHAR(20),
    major ref Department_t
);
/
-- CREATE OR REPLACE EDITIONABLE TYPE Faculty_t under person_t(
CREATE OR REPLACE TYPE Faculty_t under person_t(
    rank VARCHAR(50),
    salaries INT
);
/
CREATE OR REPLACE EDITIONABLE TYPE CampusClub_t AS OBJECT(
    cid VARCHAR(30),
    name VARCHAR(30),
    location VARCHAR(50),
    phone VARCHAR(30),
    advisorof ref Faculty_t
);
/

--CREATE TABLES --
CREATE TABLE  Person OF  Person_t   (
    PRIMARY KEY (pid)
);
/
CREATE TABLE Student of Student_t(
   PRIMARY KEY (pid),
   constraint tipo_status CHECK (status IN ('freshman', 'sophomore', 'junior', 'senior'))
);
/
CREATE TABLE CampusClub of CampusClub_t(
    PRIMARY KEY (cid)
);
/
CREATE TABLE Faculty of Faculty_t  (
    PRIMARY KEY (pid),
    constraint tipo_rank CHECK (rank IN ('Instructor', 'Asistente', 'Asociado', 'Titular'))
);
/
CREATE TABLE Department of Department_t (
    PRIMARY KEY (code)
);
/
CREATE TABLE Clubs (
    pid VARCHAR(30),
    cid VARCHAR(30),
    PRIMARY KEY (pid, cid),
    FOREIGN KEY (pid) REFERENCES  Student(pid),
    FOREIGN KEY (cid) REFERENCES CampusClub(cid)
);