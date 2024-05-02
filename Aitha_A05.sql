--Drop tables
Drop table Patients;
Drop table MedicalStaff;
Drop table Treatments;
-- Create Tables
CREATE TABLE Patients (
patient_ID NUMBER(3) PRIMARY KEY,
patient_name VARCHAR2(30),
admission_date DATE,
discharge_date DATE
);
CREATE TABLE MedicalStaff (
staff_ID NUMBER PRIMARY KEY,
staff_name VARCHAR2(20),
staff_type VARCHAR2(20)
);
CREATE TABLE Treatments (
treatment_ID NUMBER PRIMARY KEY,
patient_ID NUMBER,
staff_ID NUMBER,
treatment_cost NUMBER(10,2),
FOREIGN KEY (patient_ID) REFERENCES Patients(patient_ID),
FOREIGN KEY (staff_ID) REFERENCES MedicalStaff(staff_ID)
);

INSERT INTO Patients VALUES (001,'Om',TO_DATE ('2001-03-07','YYYY-MM-DD'),TO_DATE ('2001-09-06','YYYY-MM-DD'));
INSERT INTO Patients VALUES (002, 'Jane',TO_DATE ('1995-12-15','YYYY-MM-DD'), TO_DATE ('2002-02-28','YYYY-MM-DD'));
INSERT INTO Patients VALUES (003, 'Michael', TO_DATE ('1988-05-20','YYYY-MM-DD'), TO_DATE ('2003-09-10','YYYY-MM-DD'));
INSERT INTO Patients VALUES (004, 'Emily', TO_DATE ('1976-08-30','YYYY-MM-DD'), TO_DATE ('2004-11-05','YYYY-MM-DD'));
INSERT INTO Patients VALUES (005, 'David', TO_DATE ('1999-02-12','YYYY-MM-DD'), TO_DATE ('2005-07-20','YYYY-MM-DD'));
INSERT INTO Patients VALUES (006, 'Sarah', TO_DATE ('1985-11-03','YYYY-MM-DD'), TO_DATE ('2006-04-15','YYYY-MM-DD'));
INSERT INTO Patients VALUES (007, 'Christopher', TO_DATE ('1979-07-25','YYYY-MM-DD'),TO_DATE ('2007-12-03','YYYY-MM-DD'));
INSERT INTO Patients VALUES (008, 'Jennifer',TO_DATE ('1990-09-18','YYYY-MM-DD'), TO_DATE ('2008-10-28','YYYY-MM-DD'));
INSERT INTO Patients VALUES (009, 'Daniel',TO_DATE ('2000-04-02','YYYY-MM-DD'), TO_DATE ('2009-03-12','YYYY-MM-DD'));
INSERT INTO Patients VALUES (010, 'Jessica', TO_DATE ('1993-01-10','YYYY-MM-DD'), TO_DATE ('2010-08-07','YYYY-MM-DD'));

INSERT INTO MedicalStaff VALUES (101,'Ganesh','Doctor');
INSERT INTO MedicalStaff VALUES (102, 'Mary Johnson', 'Nurse');
INSERT INTO MedicalStaff VALUES (103, 'Michael Brown', 'Surgeon');
INSERT INTO MedicalStaff VALUES (104, 'Emily Davis', 'Nurse');
INSERT INTO MedicalStaff VALUES (105, 'David Wilson', 'Doctor');
INSERT INTO MedicalStaff VALUES (106, 'Sarah Lee', 'Nurse');
INSERT INTO MedicalStaff VALUES (107, 'Christopher Clark', 'Doctor');
INSERT INTO MedicalStaff VALUES (108, 'Jennifer Martinez', 'Nurse');
INSERT INTO MedicalStaff VALUES (109, 'Daniel Taylor', 'Surgeon');
INSERT INTO MedicalStaff VALUES (110, 'Jessica Rodriguez', 'Nurse');

INSERT INTO Treatments VALUES (201, 001, 101, 150.00);
INSERT INTO Treatments VALUES (202, 002, 102, 200.00);
INSERT INTO Treatments VALUES (203, 001, 103, 300.00);
INSERT INTO Treatments VALUES (204, 004, 104, 250.00);
INSERT INTO Treatments VALUES (205, 005, 105, 180.00);
INSERT INTO Treatments VALUES (206, 006, 106, 220.00);
INSERT INTO Treatments VALUES (207, 002, 107, 270.00);
INSERT INTO Treatments VALUES (208, 001, 102, 190.00);
INSERT INTO Treatments VALUES (209, 009, 109, 320.00);
INSERT INTO Treatments VALUES (210, 010, 110, 280.00);

set SERVEROUTPUT on;

CREATE OR REPLACE PROCEDURE updatedisdate 
(
  p_patient_id IN NUMBER
)
AS
  v_discharge_date DATE;

BEGIN
  SELECT discharge_date INTO v_discharge_date
  FROM Patients
  WHERE patient_id = p_patient_id;

  IF v_discharge_date IS NULL THEN
    UPDATE Patients 
    SET discharge_date = SYSDATE
    WHERE patient_id = p_patient_id;

  ELSE
    DBMS_OUTPUT.PUT_LINE('Patient ' || p_patient_id || ' already discharged on ' || v_discharge_date);
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: Invalid patient ID ' || p_patient_id);
    
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
  
END updatedisdate;
/  

EXEC updatedisdate(002);

--own

CREATE OR REPLACE PROCEDURE get_patient_details (
    p_patient_id IN Patients.patient_ID%TYPE
)
AS
    v_patient_name Patients.patient_name%TYPE;
    v_admission_date Patients.admission_date%TYPE;
BEGIN
    -- Fetch patient details based on the provided patient ID
    SELECT patient_name, admission_date
    INTO v_patient_name, v_admission_date
    FROM Patients
    WHERE patient_ID = p_patient_id;

    -- Print out the patient details
    DBMS_OUTPUT.PUT_LINE('Patient ID: ' || p_patient_id);
    DBMS_OUTPUT.PUT_LINE('Patient Name: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('Admission Date: ' || TO_CHAR(v_admission_date, 'DD-MON-YYYY'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid patient ID ' || p_patient_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END get_patient_details;
/
EXEC get_patient_details (001);

--The get_patient_details procedure accepts a patient ID parameter. It fetches the patient's name and admission date based on the ID. If the ID is not found, it prints an error message. Any other exceptions are caught and their messages are printed. Finally, it displays the patient's details, including ID, name, and admission date, using DBMS_OUTPUT.
--Create a cursor to retrieve the total number of treatments performed by each staff member, including those who haven't performed any treatments. Display the staff ID, staff name, and the total number of treatments.
DECLARE
    CURSOR staff_treatment_count IS
        SELECT ms.staff_ID, ms.staff_name, COUNT(t.treatment_ID) AS total_treatments
        FROM MedicalStaff ms
        LEFT JOIN Treatments t ON ms.staff_ID = t.staff_ID
        GROUP BY ms.staff_ID, ms.staff_name;
BEGIN
    FOR staff_rec IN staff_treatment_count LOOP
        DBMS_OUTPUT.PUT_LINE('Staff ID: ' || staff_rec.staff_ID || ', Staff Name: ' || staff_rec.staff_name || ', Total Treatments: ' || staff_rec.total_treatments);
    END LOOP;
END;
/

--Create another cursor of your own using the given database schema and explain it in your own words.
DECLARE
    CURSOR patient_details_cursor IS
        SELECT p.patient_id, p.patient_name, COUNT(t.treatment_id) AS total_treatments
        FROM patients p
        LEFT JOIN treatments t ON p.patient_id = t.patient_id
        GROUP BY p.patient_id, p.patient_name;
BEGIN
    FOR rec IN patient_details_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Patient ID: ' || rec.patient_id || ', Name: ' || rec.patient_name || ', Total Treatments: ' || rec.total_treatments);
    END LOOP;
END;
/

--This PL/SQL block fetches patient details and the total number of treatments they've received. It then prints out this information, including patient ID, name, and total treatments. It's a concise way to summarize patient treatment statistics.

--Create a trigger that updates the 'treatment_cost' in the 'Treatments' table whenever a new treatment is inserted, ensuring that it does not exceed a predefined maximum cost (use your own maximum cost).
CREATE OR REPLACE TRIGGER treatments_cost_trigger
  BEFORE INSERT ON Treatments
  FOR EACH ROW
DECLARE
  max_cost NUMBER := 1000;
BEGIN
  IF :NEW.treatment_cost > max_cost THEN
    :NEW.treatment_cost := max_cost;
  END IF;
END;
/
INSERT INTO Treatments VALUES (211, 010, 110, 1280.00);
select * from Treatments;

--Create another 'Treatment History' table with at least two attributes of your choice and populate it with the history of each insertion whenever an update is performed on the Treatment table.
CREATE TABLE TreatmentHistory (
    treatment_ID NUMBER(2),
    treatment_date DATE,
    treatment_description VARCHAR2(255)
);

--trigger for above table

CREATE OR REPLACE TRIGGER populate_treatment_history
AFTER INSERT OR UPDATE ON Treatments
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO TreatmentHistory (treatment_ID, treatment_date, treatment_description)
        VALUES (:NEW.treatment_ID, :NEW.treatment_date, :NEW.treatment_description);
    ELSIF UPDATING THEN
        INSERT INTO TreatmentHistory (treatment_ID, treatment_date, treatment_description)
        VALUES (:OLD.treatment_ID, :OLD.treatment_date, :OLD.treatment_description);
        
        INSERT INTO TreatmentHistory (treatment_ID, treatment_date, treatment_description)
        VALUES (:NEW.treatment_ID, :NEW.treatment_date, :NEW.treatment_description);
    END IF;
END;
/
select * from TreatmentHistory;
drop table TreatmentHistory;

---Can you create an SQL function named GetTotalPatientsCountFunction to retrieve the total count of patients from the 'Patients' table in a Hospital Management database? Write a procedure to use the function and display it.
CREATE OR REPLACE FUNCTION GetTotalPatientsCountFunction RETURN NUMBER IS
    total_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_count FROM Patients;
    RETURN total_count;
END GetTotalPatientsCountFunction;
/
CREATE OR REPLACE PROCEDURE DisplayTotalPatientsCountProcedure IS
    total_patients_count NUMBER;
BEGIN
    total_patients_count := GetTotalPatientsCountFunction(); -- Call the function to get the total count of patients
    DBMS_OUTPUT.PUT_LINE('Total Patients Count: ' || total_patients_count);
END DisplayTotalPatientsCountProcedure;
/
BEGIN
    DisplayTotalPatientsCountProcedure;
END;
/
--5.Write a subquery to retrieve patients who have been treated by medical staff members with the highest treatment cost.

SELECT * FROM Patients
WHERE patient_ID IN (
    SELECT patient_ID
    FROM Treatments
    WHERE treatment_cost = (
        SELECT MAX(treatment_cost)
        FROM Treatments
    )
);

--6.Write a query to retrieve patients who have been treated by medical staff members of all types available in the MedicalStaff.
SELECT DISTINCT p.patient_name
FROM Patients p 
INNER JOIN Treatments t ON t.patient_id = p.patient_id
INNER JOIN MedicalStaff s ON s.staff_id = t.staff_id
WHERE s.staff_type IN (
  SELECT DISTINCT staff_type 
  FROM MedicalStaff
);
