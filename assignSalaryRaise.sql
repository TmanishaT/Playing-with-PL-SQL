CREATE OR REPLACE PROCEDURE assignRaises(
    	p_emp_raise_percent NUMBER ,
    	p_emp_raise_budget  MyEmployees.salary%TYPE )
    AS
            p_emp_count NUMBER:=0;--keep track of total employee
	p_total_emp_budget NUMBER:= p_emp_raise_budget;
    	p_raise_received_count NUMBER:=0;--keep track of employee who get raise
            v_emp_raise NUMBER:=0;--calculate raise
            
    	CURSOR emp_priority IS
		SELECT * FROM MyEmployees e ORDER BY e.salary ASC ,e.hire_date ASC;
  BEGIN
SELECT COUNT(e.employee_id) INTO p_emp_count FROM MyEmployees e;--get total unique emp count
			
	FOR v_emp in emp_priority
	LOOP
		v_emp_raise:=v_emp.salary*p_emp_raise_percent/100;

		IF p_total_emp_budget>=0 AND p_total_emp_budget>=v_emp_raise THEN
            	raiseEmpSalary(v_emp.employee_id,p_emp_raise_percent);
            	p_raise_received_count := p_raise_received_count +1;
            	p_total_emp_budget := p_total_emp_budget - v_emp_raise;
        	ELSE
            INSERT INTO HW1Log (Message) VALUES ('Not enough money left to give a raise to employee ' || v_emp.employee_id || '.');
        	END IF;
    	END LOOP;

p_emp_count := p_emp_count - p_raise_received_count;--update employee who didn’t receive raise
    	DBMS_OUTPUT.put_line('Number of employees who received raises: '|| p_raise_received_count);
    	dbms_output.put_line('Number of employees who did not receive raises: '|| p_emp_count);
 DBMS_OUTPUT.PUT_LINE('Amount of money left unused in the raise budget: '|| p_total_emp_budget);

    	COMMIT;

END assignRaises;
