-- ============================================================================
-- Alexandria National University - Faculty of Engineering
-- Introduction to Database Systems (Fall 2026) - Lab 3
-- File: problem1_DML.sql
-- Students:
--   1. A'laa Sherif Ibrahim (ID: 2304249)
--   2. Mariam Mohamed Ali   (ID: 2304251)
-- ============================================================================

USE company;

-- Step 1: Insert DEPARTMENT rows first with mgr_ssn temporarily set to NULL
INSERT INTO DEPARTMENT (Dnumber, Dname, mgr_ssn, mgr_start_date) VALUES
(1, 'Research and AI', NULL, '2023-01-15'),
(2, 'Software Engineering', NULL, '2023-06-01'),
(3, 'Cybersecurity', NULL, '2024-02-10'),
(4, 'Cloud Infrastructure', NULL, '2024-09-01');

-- Step 2: Insert EMPLOYEE rows referencing existing DEPARTMENT.Dnumber values
INSERT INTO EMPLOYEE (ssn, fname, lname, bdate, address, gender, salary, Dno) VALUES
(101, 'Alaa', 'Ibrahim', '2004-05-14', 'Smouha, Alexandria', 'F', 28500.00, 1),
(102, 'Mariam', 'Ali', '2004-08-22', 'Gleem, Alexandria', 'F', 29000.00, 2),
(103, 'Omar', 'Hassan', '1999-11-03', 'Stanley, Alexandria', 'M', 24000.00, 3),
(104, 'Nour', 'Khaled', '2001-03-19', 'Louran, Alexandria', 'F', 22500.00, 4);

-- Step 3: Update DEPARTMENT rows to set mgr_ssn now that EMPLOYEE rows exist
UPDATE DEPARTMENT SET mgr_ssn = 101 WHERE Dnumber = 1;
UPDATE DEPARTMENT SET mgr_ssn = 102 WHERE Dnumber = 2;
UPDATE DEPARTMENT SET mgr_ssn = 103 WHERE Dnumber = 3;
UPDATE DEPARTMENT SET mgr_ssn = 104 WHERE Dnumber = 4;

-- Step 4: Insert PROJECT rows referencing existing DEPARTMENT.Dnumber values
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dno) VALUES
(10, 'Autonomous Drone Navigation', 'Alexandria', 1),
(20, 'National University Portal', 'Alexandria', 2),
(30, 'Zero-Trust Banking Firewall', 'Cairo', 3),
(40, 'Distributed Edge Cluster', 'Smart Village', 4);
