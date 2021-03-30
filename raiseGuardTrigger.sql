CREATE OR REPLACE TRIGGER RaiseGuard 
  AFTER UPDATE ON MyEmployees
  FOR EACH ROW 
DECLARE
 t_sal_diff NUMBER:=0;
BEGIN
    t_sal_diff := :new.Salary - :old.Salary;
	IF t_sal_diff > 400 THEN
        t_sal_diff := :old.Salary + 400;
		INSERT INTO HW2Log (Message)
		VALUES('Salary update for employee ' || :new.employee_id || ' modified from ' || :new.Salary || ' to limit of ' || t_sal_diff);
	END IF;
END RaiseGuard;
