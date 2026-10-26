-- ============================================================================
-- Alexandria National University - Faculty of Engineering
-- Introduction to Database Systems (Fall 2026) - Lab 3
-- File: problem2_DML.sql
-- Students:
--   1. A'laa Sherif Ibrahim (ID: 2304249)
--   2. Mariam Mohamed Ali   (ID: 2304251)
-- ============================================================================

USE library;

-- Insert 4 seed authors (Requirement: at least 3 authors)
INSERT INTO AUTHOR (author_id, name, country, photo_path) VALUES
(1, 'Naguib Mahfouz', 'Egypt', '/static/uploads/authors/author_1.png'),
(2, 'Agatha Christie', 'United Kingdom', '/static/uploads/authors/author_2.png'),
(3, 'Ahmed Khaled Tawfik', 'Egypt', '/static/uploads/authors/author_3.png'),
(4, 'Ramez Elmasri', 'United States', '/static/uploads/authors/author_4.png');

-- Insert 8 seed books (Requirement: at least 6 books)
INSERT INTO BOOK (book_id, title, price, author_id, cover_path) VALUES
(101, 'Palace Walk', 18.50, 1, '/static/uploads/covers/book_101.png'),
(102, 'Children of the Alley', 21.00, 1, '/static/uploads/covers/book_102.png'),
(103, 'The Harafish', 19.75, 1, '/static/uploads/covers/book_103.png'),
(201, 'Murder on the Orient Express', 15.99, 2, '/static/uploads/covers/book_201.png'),
(202, 'Death on the Nile', 16.50, 2, '/static/uploads/covers/book_202.png'),
(301, 'Utopia', 12.00, 3, '/static/uploads/covers/book_301.png'),
(302, 'Ma Waraa Al Tabiaa', 14.25, 3, '/static/uploads/covers/book_302.png'),
(401, 'Fundamentals of Database Systems', 45.00, 4, '/static/uploads/covers/book_401.png');
