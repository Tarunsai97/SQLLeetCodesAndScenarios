CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	dept VARCHAR(10),
	salary NUMERIC
)

CREATE PROCEDURE insertNewEmp(
	emp_name VARCHAR,
    emp_dept VARCHAR,
    emp_sal NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN 

   INSERT INTO employees(name, dept, salary)
   VALUES(emp_name, emp_dept, emp_sal);
   
END;
$$;

CALL insertNewEmp('Tarun', 'HR', 1500000)

SELECT * FROM employees;