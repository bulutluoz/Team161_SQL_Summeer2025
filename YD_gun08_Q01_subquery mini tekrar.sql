
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    department_id INT
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    head_of_department VARCHAR(50)
);

-- Departments verileri
INSERT INTO Departments VALUES
(1, 'Computer Science', 'Dr. Smith'),
(2, 'Mathematics', 'Dr. Allen'),
(3, 'Physics', 'Dr. Johnson'),
(4, 'Chemistry', 'Dr. Brown'),
(5, 'Biology', 'Dr. White');

-- Students verileri
INSERT INTO Students VALUES
(101, 'Alice', 20, 1),
(102, 'Bob', 22, 2),
(103, 'Charlie', 21, 1),
(104, 'David', 23, 3),
(105, 'Eva', 20, 2),
(106, 'Frank', 24, 4),
(107, 'Grace', 22, 5),
(108, 'Helen', 21, 3),
(109, 'Ian', 19, 4),
(110, 'Jack', 25, 1);

SELECT * 
FROM departments;


SELECT * 
FROM students;


-- department_name değeri 'Computer Science' olan öğrencilerin 
-- isimlerini listele.


-- once department_name değeri 'Computer Science' olan bolumun
-- departman_id'sini bulalim
SELECT department_id
FROM Departments
WHERE department_name = 'Computer Science';

-- 1

-- students tablosunda department_id 1 olan ogrencilerin
-- isimlerini listele.

SELECT student_name
FROM Students
WHERE department_id = 1;


-- dinamik olmasi icin birlikte kullanalim

SELECT student_name
FROM Students
WHERE department_id = ( SELECT department_id
						FROM Departments
						WHERE department_name = 'Computer Science');




-- Bölüm başkanı 'Dr. Allen' olan bölümde okuyan öğrencilerin yaşlarını getir.


SELECT age
FROM students
WHERE department_id = ( SELECT department_id
						FROM departments
                        WHERE head_of_department = 'Dr. Allen') ;


-- Her öğrencinin ismini ve bölüm adını listeleyin.

SELECT student_name, (  SELECT department_name
						FROM Departments
                        WHERE Departments.department_id = Students.department_id) AS department_name 
FROM students;


-- Her bölümun adini, başkanını ve bolumdeki ogrenci sayisini listeleyin.




