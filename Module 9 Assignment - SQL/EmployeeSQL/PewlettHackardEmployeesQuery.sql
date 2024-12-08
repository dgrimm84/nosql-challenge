-- Delete tables if they already exist to start from proper initial data
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;

-- Create dept_manager table with a composite primary key to load dept_manager csv
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);

-- Create employees table with a primary key to load employees csv
CREATE TABLE employees (
	emp_no INTEGER NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCE dept_emp(emp_no)
);

--create departments table to load departments csv 
CREATE TABLE departments (
	FOREIGN KEY (dept_no) REFERENCES dept_manager(dept_no),
	dept_name VARCHAR NOT NULL
);

select * from departments

--create salaries table to load salaries csv
CREATE TABLE salaries (
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INTEGER NOT NULL
);

--create titles table to load titles csv
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL
);

--create dept_emp table to load dept_cmp csv
CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL
	PRIMARY KEY (emp_no, dept_no)
);

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
	e.emp_no as "Employee ID", 
	e.last_name as "Last Name", 
	e.first_name as "First Name", 
	e.sex as "Sex", 
	s.salary as "Salary"
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no 

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
	e.first_name as "First Name", 
	e.last_name as "Last Name",  
	e.hire_date as "Date Hired"
FROM employees e
WHERE e.hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT 
	dm.dept_no as "Department ID", 
	d.dept_name as "Department Name", 
	dm.emp_no as "Employee ID", 
	e.last_name as "Last Name", 
	e.first_name as "First Name"
		FROM dept_manager dm
			INNER JOIN salaries s
				ON dm.emp_no = s.emp_no
				INNER JOIN employees e
					ON dm.emp_no = e.emp_no
					INNER JOIN departments d
						ON dm.dept_no = d.dept_no;

--List the department number for each employee along with that 
--employee’s employee number, last name, first name, and department name
SELECT 
	d.dept_no as "Department ID",  
	e.emp_no as "Employee ID",
	e.last_name as "Last Name", 
	e.first_name as "First Name", 
	d.dept_name as "Department Name"
		FROM departments d
			INNER JOIN dept_emp de
				ON d.dept_no = de.dept_no
				INNER JOIN employees e
					ON e.emp_no = de.emp_no;

--List first name, last name, and sex of each employee whose first name 
--is Hercules and whose last name begins with the letter B.
SELECT 
	first_name as "First Name", 
	last_name as "Last Name", 
	sex as "Sex"
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

--List each employee in the Sales department, including their 
--employee number, last name, and first name.
SELECT 
	emp_no as "Employee ID", 
	last_name as "Last Name", 
	first_name as "First Name"
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
	(
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
	)
);
	
--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT 
    e.emp_no as "Employee ID", 
    e.last_name as "Last Name", 
    e.first_name as "First Name", 
    d.dept_name as "Department Name"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
SELECT 
last_name as "Last Name", COUNT(*) AS frequency
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC;
