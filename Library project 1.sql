CREATE DATABASE Library;

CREATE TABLE Library.branch(
    branch_id VARCHAR(50)PRIMARY KEY,
    manager_id VARCHAR(50),
    branch_address VARCHAR(100),
    contact_no VARCHAR(50));

CREATE TABLE Library.employees(
    emp_id VARCHAR(25)PRIMARY KEY,
    emp_name VARCHAR(50),
    position VARCHAR(30),
    salary INT,
    branch_id VARCHAR(50));

CREATE TABLE Library.books(
    isbn VARCHAR(30) PRIMARY KEY,
    book_title VARCHAR(100),
    category VARCHAR(30),
    rental_price FLOAT,
    status VARCHAR(30),
    author VARCHAR(55),
    publisher VARCHAR(75));

CREATE TABLE Library.members(
    member_id VARCHAR(50) PRIMARY KEY,
    member_name VARCHAR(50),
    member_address VARCHAR(100),
    reg_date DATE);

CREATE TABLE Library.issued_status(
    issued_id VARCHAR(30)PRIMARY KEY,
    issued_member_id VARCHAR(30),
    issued_book_name VARCHAR(100),
    issued_date DATE,
    issued_book_isbn VARCHAR(75),
    issued_emp_id VARCHAR(30));


CREATE TABLE Library.return_status(
    return_id VARCHAR(30) PRIMARY KEY,
    issued_id VARCHAR(50),
    return_book_name VARCHAR(100),
    return_date DATE,
    return_book_isbn VARCHAR(50));


-- View data
SELECT * FROM Library.books;
SELECT * FROM Library.branch;
SELECT * FROM Library.employees;
SELECT * FROM Library.issued_status;
SELECT * FROM Library.members;
SELECT * FROM Library.return_status;

-- Project task

-- 1. Create a new book record "'978-1-60129-456-2','To kill a mockingbird','Classic',6.00,'yes','Harper Lee','J.B','Lippincott & Co.'"

INSERT INTO Library.books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2','To kill a mockingbird','Classic',6.00,'yes','Harper Lee','J.B. Lippincott & Co.');

SELECT * FROM Library.books;

-- 2. Update an existing member address
UPDATE Library.members
SET member_address = '125 Main St'
WHERE member_id ='C101';

SELECT * FROM Library.members;

-- 3. Delete a record from the issued_status table; Delete the record with issue_id ='IS121' from issued_status table
DELETE FROM Library.issued_status 
WHERE issued_id = 'IS121';

SELECT * FROM Library.issued_status
WHERE issued_id = 'IS121';
    

-- 4. Retrieve all books issued by a specific employee; select all books issued by employee with emp_id = 'E101'
SELECT * FROM Library.issued_status
WHERE issued_emp_id = 'E101';


-- 5. List members who have issued more than one book; Use group by
SELECT 
   issued_emp_id,
   COUNT(issued_id) AS total_book_issued
FROM Library.issued_status
GROUP BY issued_emp_id 
HAVING COUNT(issued_id) > 1;


-- 7. Retrieve all books in a specific column
SELECT * FROM Library.books 
WHERE category = 'Classic';

-- 8. Find total_rental income by category
SELECT b.category,SUM(b.rental_price),COUNT(*)
FROM Library.books b
JOIN Library.issued_status is2 
ON is2.issued_book_isbn = b.isbn 
GROUP BY 1

-- 10 List employees with their branch manager and branch details
SELECT
    e1.*,
    b.manager_id,
    e2.emp_name as manager

FROM Library.employees as e1
JOIN Library.branch as b
ON b.branch_id = e1.branch_id 
JOIN Library.employees as e2
ON b.manager_id = e2.emp_id

-- 11. Find books that have not been returned
SELECT * FROM Library.issued_status as ist
LEFT JOIN 
Library.return_status as rs
ON ist.issued_id = rs.issued_id 
WHERE rs.return_id IS NULL 

SELECT * FROM Library.return_status;

