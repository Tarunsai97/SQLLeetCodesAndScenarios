CREATE PROCEDURE updateSalary(emp_id INT, 
         new_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN 

       IF emp_id NOT IN (select id from employees where id = emp_id) THEN 
		   RAISE EXCEPTION 'EMPLOYEE NOT FOUND WITH ID: %', emp_id;
	   END IF;
	   
	   UPDATE employees
	   SET salary = new_salary 
	   WHERE id = emp_id;

       RAISE NOTICE 'Salary updated Successfully ID: %', emp_id;
END;
$$;

call updateSalary(1, 2000000);

select * from employees

call insertNewEmp('Jeevan','Del', 10000)