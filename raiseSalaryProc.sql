SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE raiseEmpSalary (
	p_emp_id MyEmployees.employee_id%TYPE,
	p_sal_raise NUMBER
) AS

	v_emp_update_count INTEGER:=0;
BEGIN
	UPDATE	MyEmployees set salary = (salary*p_sal_raise/100)+salary where employee_id = p_emp_id;
	v_emp_update_count := SQL%ROWCOUNT;
	
	IF v_emp_update_count = 0 THEN
	RAISE NO_DATA_FOUND;
	ELSE 
	INSERT INTO HW1Log (message) VALUES ('Employee ' || p_emp_id || ' was raised by  ' || p_sal_raise || ' percent.');
	END IF;
	COMMIT;
	
EXCEPTION
   WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Encountered while trying to give employee '|| p_emp_id ||' a raise.');
WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Some other error.');

        
END raiseEmpSalary;
