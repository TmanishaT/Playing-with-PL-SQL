CREATE OR REPLACE FUNCTION 
	RaiseCalculator(emp_salary MyEmployees.salary%TYPE) RETURN NUMBER
AS
    f_avg_salary NUMBER :=0; --avg emp salary
    f_below_avg NUMBER := 5; --raise % for sal <= avg_sal
    f_above_avg NUMBER :=3; --raise % for sal > avg_sal
    f_raised_salary NUMBER:=0; --total raised salary after raise
BEGIN
    SELECT AVG(e.salary) INTO f_avg_salary FROM MyEmployees e;--get avg emp salary
    
    IF emp_salary <= f_avg_salary THEN
      f_raised_salary := emp_salary*f_below_avg/100;
    ELSE f_raised_salary := emp_salary*f_above_avg/100;
    END IF;
    
    f_raised_salary:=f_raised_salary+ emp_salary;
    RETURN f_raised_salary;
END RaiseCalculator;
