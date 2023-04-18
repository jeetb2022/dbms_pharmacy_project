CREATE TABLE Department(
    Deptno INT PRIMARY KEY,
    Deptname VARCHAR
);
INSERT INTO Department(Deptno, Deptname) VALUES (1, 'Purchase');
INSERT INTO Department(Deptno, Deptname) VALUES (2, 'HR');
INSERT INTO Department(Deptno, Deptname) VALUES (3, 'HR');
INSERT INTO Department(Deptno, Deptname) VALUES (4, 'Purchase');

CREATE TABLE Designation(
    Designation_code INT PRIMARY KEY,
    Designation_name VARCHAR 
);
INSERT INTO Designation(Designation_code, Designation_name) VALUES (1, 'Senior Manager');
INSERT INTO Designation(Designation_code, Designation_name) VALUES (2, 'Junior Manager');
INSERT INTO Designation(Designation_code, Designation_name) VALUES (3, 'Clerk');
INSERT INTO Designation(Designation_code, Designation_name) VALUES (4, 'Janitor');

CREATE TABLE Emp(
    Empno INT PRIMARY KEY,
    First_name VARCHAR,
    Last_name VARCHAR,
    Deptno INT,
    Designation_id INT,
    Gender VARCHAR,
    FOREIGN KEY (Deptno) REFERENCES Department(Deptno),
    FOREIGN KEY (Designation_id) REFERENCES Designation(Designation_code)
);
INSERT INTO Emp(Empno, First_name, Last_name, Deptno, Designation_id, Gender) VALUES(1, 'Anil', 'Patel', 1, 2, 'Male');
INSERT INTO Emp(Empno, First_name, Last_name, Deptno, Designation_id, Gender) VALUES(2, 'Neel', 'Shah', 2, 1, 'Male');
INSERT INTO Emp(Empno, First_name, Last_name, Deptno, Designation_id, Gender) VALUES(3, 'Kushal', 'Patel', 1, 3, 'Female');
INSERT INTO Emp(Empno, First_name, Last_name, Deptno, Designation_id, Gender) VALUES(4, 'Zenil', 'Patel', 3, 2, 'Male');
INSERT INTO Emp(Empno, First_name, Last_name, Deptno, Designation_id, Gender) VALUES(5, 'Jeet', 'Patel', 2, 2, 'Male');

CREATE TABLE leave_taken(
    Empno INT,
    Leave_code VARCHAR(2),
    From_date date,
    To_date date,
    FOREIGN KEY (Empno) REFERENCES Emp(Empno)
);
INSERT INTO leave_taken(Empno, Leave_code, From_date, To_date) VALUES (1, 'CL', '2019-07-23', '2019-08-03');
INSERT INTO leave_taken(Empno, Leave_code, From_date, To_date) VALUES (2, 'CL', '2023-07-23', '2024-09-03');
INSERT INTO leave_taken(Empno, Leave_code, From_date, To_date) VALUES (3, 'CL', '2023-07-23', '2024-09-03');


CREATE TABLE leave_eligibilty(
    Designation_id INT,
    Leave_code VARCHAR,
    Gender VARCHAR,
    Max_leave_allowed INT,
    FOREIGN KEY (Designation_id) REFERENCES Designation(Designation_code)
);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'CL', 'Male', 20);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(2, 'CL', 'Female', 20);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'ML', 'Male', 20);

CREATE FUNCTION emp_max_leaves(IN _dept_name VARCHAR, IN _des_name VARCHAR)
RETURNS VARCHAR as $leaves$
DECLARE 
    emp_name VARCHAR;
    _dept_no INT;
    _desg_no INT;
    _emp_no INT;
BEGIN
    SELECT Deptno INTO _dept_no FROM Department WHERE Deptname = _dept_name;
    SELECT Designation_code INTO _desg_no FROM Designation WHERE Designation_name = _des_name;
    RETURN First_name FROM Emp, leave_taken WHERE Emp.Empno = leave_taken.Empno and 
    Emp.Empno = (SELECT Empno FROM Emp WHERE Deptno = _dept_no and Designation_id = _desg_no) 
    order by (leave_taken.To_date - leave_taken.From_date) desc;
END;
$leaves$
LANGUAGE plpgsql;
SELECT emp_max_leaves('Purchase', 'Junior Manager');


CREATE FUNCTION insert_leave() RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.Leave_code = 'ML' and NEW.Gender = 'Male') THEN
    RAISE EXCEPTION 'Leave Code "ML" is not available for Male employees';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_leave_constraint BEFORE INSERT OR UPDATE ON leave_eligibilty
  FOR EACH ROW EXECUTE FUNCTION insert_leave();

INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'CL', 'Male', 20);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'ML', 'Male', 20);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'CL', 'Female', 20);
INSERT INTO leave_eligibilty(Designation_id, Leave_code, Gender, Max_leave_allowed) VALUES(1, 'ML', 'Female', 20);

