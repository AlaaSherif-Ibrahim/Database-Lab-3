-- ============================================================================
-- Alexandria National University - Faculty of Engineering
-- Introduction to Database Systems (Fall 2026) - Lab 3
-- File: problem1_DDL.sql
-- Students:
--   1. A'laa Sherif Ibrahim (ID: 2304249)
--   2. Mariam Mohamed Ali   (ID: 2304251)
-- ============================================================================

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- 1. Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    ssn INT NOT NULL,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    bdate DATE,
    address VARCHAR(100),
    gender CHAR(1),
    salary DECIMAL(10,2),
    Dno INT,
    PRIMARY KEY (ssn)
);

-- 2. Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dnumber INT NOT NULL,
    Dname VARCHAR(50) NOT NULL,
    mgr_ssn INT,
    mgr_start_date DATE,
    PRIMARY KEY (Dnumber)
);

-- 3. Create PROJECT table
CREATE TABLE PROJECT (
    Pnumber INT NOT NULL,
    Pname VARCHAR(50) NOT NULL,
    Plocation VARCHAR(50),
    Dno INT,
    PRIMARY KEY (Pnumber)
);

-- 4. Add Foreign Keys using ALTER TABLE to resolve circular references cleanly
ALTER TABLE EMPLOYEE
    ADD FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE PROJECT
    ADD FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE DEPARTMENT
    ADD FOREIGN KEY (mgr_ssn) REFERENCES EMPLOYEE(ssn);
