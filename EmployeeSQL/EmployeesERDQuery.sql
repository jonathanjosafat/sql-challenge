Employees
-
emp_no pk INT
emp_title_id VARCHAR(50)
birth_date DATE
first_name VARCHAR(50)
last_name VARCHAR(50)
sex CHAR(1)
hire_date DATE

Departments
-
dept_no pk CHAR(4)
dept_name VARCHAR(50)

Salaries
----
emp_no pk FK >- Employees.emp_no INT
salary INT


Titles
------------
title_id pk VARCHAR(50) FK >- Employees.emp_title_id
title VARCHAR(50)

Dept_Emp
----
emp_no pk FK >- Employees.emp_no INT
dept_no pk FK >- Departments.dept_no CHAR(4),

Dept_Manager
----
dept_no pk FK >- Departments.dept_no CHAR(4)
emp_no pk FK >- Employees.emp_no INT