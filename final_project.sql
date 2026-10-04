## Q - 1
CREATE DATABASE finallproject;
USE finallproject;
DROP TABLE IF EXISTS students;
CREATE TABLE students(
student_id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
birth_date DATE,
enrollment_date DATE,
dept_id INT,
number_stu INT);
INSERT INTO students (student_id,first_name,last_name,email,birth_date,enrollment_date,dept_id,number_stu)
VALUES 
(1,'john','doe','john.doe@email.com','2000-01-15','2022-08-01',1,1),
(2,'jane','smith','jane.smith@email.com','1999-05-25','2021-08-01',2,2);

SELECT * FROM students;

UPDATE students
SET first_name = 'bob' 
WHERE student_id = 2;

DELETE FROM students WHERE student_id = 2;

DROP TABLE IF EXISTS course;

CREATE TABLE course(
course_id INT,
course_name VARCHAR(50),
dept_id INT,
credits INT);
INSERT INTO course(course_id,course_name,dept_id,credits)
VALUES
(101,'introduction to sql',1,3),
(102,'data structures',2,4);

SELECT * FROM course;

UPDATE course
SET credits = 3
WHERE course_id = 102;

DELETE FROM course WHERE course_id = 1;

DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors(
    instructor_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2));
INSERT INTO instructors(instructor_id,first_name,last_name,email,dept_id,salary) 
VALUES
(1,'alice','johnson','alice.johnson@univ.com',1,200000),
(2,'bob','lee','bob.lee@univ.com',2,30000);

SELECT * FROM instructors;

UPDATE instructors
SET last_name = 'leo'
WHERE instructor_id = 2;

DELETE FROM instructors WHERE instructor_id = 1;
DROP TABLE IF EXISTS department;
CREATE TABLE department(
dept_id INT,
dept_name VARCHAR(50)
);
INSERT INTO department(dept_id,dept_name)
VALUES
(1,'computer_science'),
(2,'mathematics');
SELECT * FROM department;
UPDATE department
SET dept_name = 'IT'
WHERE dept_id = 1;
DELETE FROM department WHERE dept_id = 1;
DROP TABLE IF EXISTS enrollment;
CREATE TABLE enrollment(
enrollment_id INT,
student_id INT,
course_id INT,
enrollment_date DATE
);
INSERT INTO enrollment(enrollment_id,student_id,course_id,enrollment_date)
VALUES
(1,1,101,'2022-08-01'),
(2,2,102,'2021-08-01');

SELECT * FROM enrollment;
UPDATE enrollment 
SET enrollment_date = '2022-09-08'
WHERE enrollment_id = 1;
DELETE FROM enrollment WHERE enrollment_id = 1;

## Q - 2
SELECT student_id
FROM students
WHERE enrollment_date > '2022-12-12';

## Q - 3
SELECT dept_id,course_name 
FROM course
WHERE dept_id IN (SELECT dept_id FROM department WHERE dept_name='mathematics' ) LIMIT 5;
## or
SELECT c.dept_id,c.course_name
FROM course AS c
INNER JOIN department AS d
ON c.dept_id = d.dept_id
WHERE d.dept_name='mathematics' LIMIT 5;

## Q - 4
SELECT  COUNT(student_id) ,course_name
FROM students
JOIN course

GROUP BY course_name
HAVING COUNT(student_id) > 5;

## Q - 5
SELECT student_id
FROM students
JOIN course
WHERE course_name = 'introduction to sql' AND course_name = 'data structures';

## Q - 6
SELECT s.student_id
FROM students AS s
INNER JOIN course AS c
ON c.dept_id = s.dept_id
WHERE course_name = 'introduction to sql' OR course_name = 'data structures';

## Q - 7
SELECT AVG(credits) AS avg_credit,course_name
FROM course
GROUP BY course_name;

## Q - 8
SELECT * FROM instructors;

SELECT instructor_id,dept_id
FROM instructors

WHERE salary = 
(SELECT MAX(salary) FROM instructors WHERE dept_id IN
(SELECT dept_id FROM department WHERE dept_name = 'computer_science'));

## Q - 9

SELECT COUNT(student_id),dept_id
FROM students 
GROUP BY dept_id;

## Q - 10
SELECT student_id,course_name
FROM students AS s
INNER JOIN course AS c
ON s.student_id = c.dept_id;

## Q - 11
SELECT student_id,course_name
FROM students AS s
LEFT JOIN course AS c
ON s.student_id = c.dept_id;

## Q - 12
SELECT student_id 
FROM students 
WHERE dept_id IN 
(SELECT dept_id FROM course WHERE course_id IN 
(SELECT course_id FROM course GROUP BY course_id HAVING COUNT(student_id)>10));

## Q - 13
SELECT s.student_id,YEAR(e.enrollment_date) AS year
FROM students as s
JOIN enrollment AS e;

## Q - 14
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM instructors;

## Q - 15
SELECT student_id,course_id,number_stu,
SUM(number_stu) OVER(ORDER BY student_id ASC) AS running_total FROM students JOIN course;

## Q - 16
SELECT s.student_id,e.enrollment_date,
CASE 
    WHEN (YEAR(CURDATE()) - YEAR(e.enrollment_date)) > 4 THEN 'senior'
    ELSE 'junior'
    END AS label
FROM enrollment AS e
JOIN students AS s;
