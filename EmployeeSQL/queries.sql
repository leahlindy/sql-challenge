-- Database: Employees_db

-- DROP DATABASE "Employees_db";

CREATE DATABASE "Employees_db"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Queries 
--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW Question_1 AS
SELECT 
	employees.emp_no, 
	employees.last_name, 
	employees.first_name, 
	employees.gender,
	salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.emp_no=employees.emp_no;

--2. List employees who were hired in 1986.
CREATE VIEW Question_2 AS
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '1986%';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW Question_3 AS
SELECT 	departments.dept_no, 
		departments.dept_name,
		dept_manager.emp_no, 
		employees.last_name,
		employees.first_name,
		dept_manager.from_date, 
		dept_manager.to_date
FROM departments
INNER JOIN dept_manager ON dept_manager.dept_no=departments.dept_no
JOIN employees ON employees.emp_no=dept_manager.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no,
		employees.last_name,
		employees.first_name,
		departments.dept_name
FROM dept_emp
INNER JOIN employees ON employees.emp_no=dept_emp.emp_no
JOIN departments ON departments.dept_no=dept_emp.dept_no;
		
--5. List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW Question_5 AS
SELECT emp_no,first_name, last_name
FROM employees
WHERE first_name='Hercules' 
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * FROM departments;
SELECT first_name, last_name
FROM employees
WHERE emp_no
IN (
	SELECT emp_no
		FROM dept_emp
		WHERE dept_no
		IN
			(SELECT dept_no
			FROM departments
			WHERE dept_name
			IN(
				SELECT dept_name
				FROM departments
				WHERE dept_name= 'Sales')));

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no
IN (
	SELECT emp_no
		FROM dept_emp
		WHERE dept_no
		IN
			(SELECT dept_no
			FROM departments
			WHERE dept_name
			IN(
				SELECT dept_name
				FROM departments
				WHERE dept_name= 'Sales' OR dept_name= 'Development')));
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE VIEW Question_8 AS
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;

