CREATE DATABASE LIBRARY_MANAGEMENT;
USE LIBRARY_MANAGEMENT;
CREATE TABLE BOOKS(book_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255) , author_id INT, genre VARCHAR(255), published_date DATE);

CREATE TABLE AUTHORS(author_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), birthdate DATE);

CREATE TABLE BORROWERS(borrower_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255));

CREATE TABLE LOANS(loan_id INT AUTO_INCREMENT PRIMARY KEY, book_id INT,borrower_id INT,
 loan_date DATE, return_date DATE, FOREIGN KEY(book_id) REFERENCES BOOKS(book_id), FOREIGN KEY(borrower_id) REFERENCES BORROWERS(borrower_id));

INSERT INTO BOOKS  VALUES(1,'HARRY POTTER AND SORCERERS STONE', 1 ,'FANTASY', '1997-06-26'),
 (2,'1984', 2, 'DYSTOPIAN', '1949-06-08'),
 (3, 'THINK AND GROW RICH', 3, 'MOTIVATION', '1937-05-23'),
 (4,'WINGS OF FIRE', 4, 'FANTASY', '2009-12-15');
 
                        
INSERT INTO AUTHORS VALUES
(1,'J.K. ROWLING','1965-07-31'),
(2, 'GEORGE ORWELL', '1903-06-25'),
(3, 'NAPOLEAN HILL',  '1883-11-26'),
(4, 'APJ ABDUL KALAM','1931-11-15');

INSERT INTO BORROWERS VALUES
(1, 'ALICE SMITH','alice.smith@email.com'),
(2,'BOB JOHNSON', 'bob.johnson@email.com');

INSERT INTO LOANS VALUES
(1,1,1,'2024-12-01','2024-12-15'),
(2,2,2,'2024-12-05','2024-12-19');

SELECT * FROM BOOKS;
SELECT * FROM AUTHORS;
SELECT * FROM BORROWERS;
SELECT * FROM LOANS;

SELECT BOOKS.title, AUTHORS.name 
FROM BOOKS JOIN AUTHORS ON BOOKS.author_id = AUTHORS.author_id;

SELECT BORROWERS.name, LOANS.borrower_id 
FROM BORROWERS JOIN LOANS ON BORROWERS.borrower_id = LOANS.borrower_id;

SELECT borrowers.name, borrowers.email, books.title 
FROM loans
JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
JOIN books ON loans.book_id = books.book_id;

SELECT books.title, borrowers.name, loans.loan_date 
FROM loans
JOIN books ON loans.book_id = books.book_id
JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
WHERE loans.loan_date < CURDATE() AND loans.return_date IS NULL;

SELECT title FROM books 
WHERE book_id NOT IN (SELECT book_id FROM loans WHERE return_date IS NULL);

UPDATE loans 
SET return_date = '2024-12-10' 
WHERE loan_id = 1;
