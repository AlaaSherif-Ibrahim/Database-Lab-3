-- ============================================================================
-- Alexandria National University - Faculty of Engineering
-- Introduction to Database Systems (Fall 2026) - Lab 3
-- File: problem2_DDL.sql
-- Students:
--   1. A'laa Sherif Ibrahim (ID: 2304249)
--   2. Mariam Mohamed Ali   (ID: 2304251)
-- ============================================================================

DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

-- 1. Create AUTHOR table
-- Primary key: author_id
-- Bonus column: photo_path stores the uploaded author photo filename/URL
CREATE TABLE AUTHOR (
    author_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    photo_path VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (author_id)
);

-- 2. Create BOOK table
-- Primary key: book_id
-- Foreign key: author_id references AUTHOR(author_id) ON DELETE CASCADE
-- Bonus column: cover_path stores the uploaded book cover filename/URL
CREATE TABLE BOOK (
    book_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    author_id INT NOT NULL,
    cover_path VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id) ON DELETE CASCADE
);
