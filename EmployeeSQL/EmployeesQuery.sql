--Importing Tables

-- Employees Table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(50) NOT NULL,
	birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL
);

-- Departments Table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Salaries Table
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE
);

-- Titles Table
CREATE TABLE titles  (
    title_id VARCHAR(50) PRIMARY KEY,
   	title VARCHAR(50)
);

-- Dept_Emp Table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE
);

-- Dept_Manager Table
CREATE TABLE dept_manager (
  dept_no CHAR(4),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE
);

--Importing CSV files
\copy employees FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/employees.csv' DELIMITER ',' CSV HEADER;
\copy departments FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/departments.csv' DELIMITER ',' CSV HEADER;
\copy salaries FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/salaries.csv' DELIMITER ',' CSV HEADER;
\copy titles FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/titles.csv' DELIMITER ',' CSV HEADER;
\copy dept_emp FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/dept_emp.csv' DELIMITER ',' CSV HEADER;
\copy dept_manager FROM 'C:/Users/JJ - School/Documents/GitHub/sql-challenge/data/dept_manager.csv' DELIMITER ',' CSV HEADER;

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development')

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) as count
FROM employees
GROUP BY last_name
ORDER BY count DESC;