use home_assigment;
#Q1
Update property_price_train_new set Sale_Price = Sale_Price * 1.15 Where Sale_condition = "Normal";
#Q2
Alter table  property_price_train_new modify BsmtUnfSF VARCHAR (30);

#Q3
SELECT lpad( convert(Garage_Size , char) , 4, "0")  from property_price_train_new;

#Q4
SELECT Brick_Veneer_Area, Brick_Veneer_Type 
FROM Property_Price_Train_new  
WHERE Brick_Veneer_Type NOT IN ('None','BrkCmn');

#Q5
Select W_Deck_Area from Property_Price_Train_new where W_Deck_Area < 0;

#Q6

select Brick_Veneer_Type from Property_Price_Train_new where Brick_Veneer_Type like '____e';

#Q7
SELECT REPLACE(Pool_Quality,'NA','null') AS Pool_Quality_new 
FROM Property_Price_Train_new;

#Q7
select count(Pool_Quality) from Property_Price_Train_new where Pool_Quality = 'NA';
select count(Miscellaneous_Feature) from Property_Price_Train_new where Miscellaneous_Feature = 'NA';

#Q8

ALTER TABLE Property_Price_Train_new
    DROP COLUMN Pool_Quality,
    DROP COLUMN Miscellaneous_Feature;
    
#Q9

select table_schema 'db_name',
round(((data_length + index_length) / 1024 / 1024), 2) AS  "Size (MB)"
FROM information_schema.TABLES 
GROUP BY table_schema;


#Q10
select Brick_Veneer_Area, Exterior_Material, BsmtFinSF1, Remodel_Year 
from property_price_train_new where Remodel_Year between 1950 and 1976;

#Q11

select Brick_Veneer_Area,Exterior_Material,BsmtFinSF1,Remodel_Year,Sale_Price
       from property_price_train_new where Sale_Price > 
	        (select avg(Sale_Price) from property_price_train_new);

#Q12

create view checkID as
select employee_id, first_name, last_name
from  employee_details
where manager_id between 100 and 114
WITH CHECK OPTION;

#Q13
update checkID
   set employee_id = 113
    where first_name = 'Bob' and last_name = 'Tan';
    
#Q14

delete from checkID
where employee_id = 104;

#Q15

select employee_id , first_name,last_name,phone_number,salary, job_id
from employee_details
where DEPARTMENT_ID NOT IN(
select DEPARTMENT_ID FROM Department_Details
where DEPARTMENT_NAME='Contracting');

#Q16

 select FIRST_NAME, LAST_NAME,DEPARTMENT_ID 
   from employee_details where DEPARTMENT_ID= any
   (select DEPARTMENT_ID from Department_Details where LOCATION_ID=1700);
   
#Q17

select employee_id, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID 
from employee_details E 
where exists (select * from employee_details where MANAGER_ID = E.EMPLOYEE_ID);

#Q18

SELECT email, email REGEXP '^[A-Za-z0-9._%\-+!#$&/=?^|~]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' as valid_email from employee_details;



