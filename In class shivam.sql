use in_class_exercise;

#q1

Select product, price , month, sum(quantity )
from bank_inventory_pricing 
Group by product , month
Having sum(quantity) > 5;

#q2

Select product, quantity , month ,
sum( COALESCE ( estimated_sale_price < purchase_cost , 0, 1 )  ) count_of_trans
from bank_inventory_pricing
group by product , month
having sum( COALESCE ( estimated_sale_price < purchase_cost , 0, 1 )  )  > 0;

#q3

SELECT Estimated_sale_price FROM bank_inventory_pricing ORDER BY Estimated_sale_price DESC LIMIT 2,1;

#q4

SELECT Product, count(Product) FROM bank_inventory_pricing GROUP BY Product HAVING count(Product) > 1;

#q5

CREATE VIEW bank_details1 AS
SELECT Product, Quantity, Price FROM bank_inventory_pricing
WHERE Product = 'PayPoints' AND
Quantity > 2;
SELECT * FROM bank_details1;

#q6

UPDATE bank_details1
   SET Product= 'PayPoints' 
    WHERE Quantity=3 AND Price=410.67;
    
#q7

Select branch, sum(estimated_profit)  , sum(revenue - cost )   
From Bank_branch_PL
Group by branch
having  (sum(estimated_profit)  > sum(revenue - cost ) );

#q8

Select branch, product, cost , min(revenue-cost)
From Bank_branch_pl 
group by  branch, product
having min(revenue-cost) > 0;

#q9

SELECT lpad( convert(quantity , char) , 4, "0")  from Bank_Inventory_pricing;

#q10

SELECT Quantity , Product FROM Bank_Inventory_pricing WHERE Product LIKE '%U%';

#q11

Select branch,product,  sum(estimated_profit)  , sum(revenue- .7*cost)
From Bank_branch_PL
where revenue < cost
group by  branch , product
having sum(revenue- .7*cost) >  sum(estimated_profit);

#q12

SELECT * FROM Bank_Inventory_pricing  
WHERE Product NOT IN ('BusiCard','SuperSave');

#q13

Select * from Bank_Inventory_pricing where price between 220 and 300;

#q14

select distinct product from Bank_Inventory_pricing where product is not null limit 5;

#q15

Update Bank_Inventory_pricing set price = price * 1.15 Where quantity > 3;

#q16

SELECT convert ( price, decimal(5,0) ) as estimated_sale_price FROM Bank_Inventory_pricing;

#q17

Alter table Bank_Inventory_pricing modify Product VARCHAR (30);

#q18

select price + '100' as new_price from Bank_Inventory_pricing where quantity > 3;

#q19

SELECT  
br_1.Account_Number primary_account_number ,
br_1.Account_type primary_account_type,
br_2.Account_Number secondary_account_number,
br_2.Account_type secondary_account_type
from bank_account_relationship_details br_1
JOIN bank_account_relationship_details br_2
on br_1.Account_Number = br_2.Linking_Account_Number
and br_2.Account_type like '%Credit%' ;

#q20

SELECT br1.Account_Number primary_account_number ,
br1.Account_type primary_account_type,
br2.Account_Number secondary_account_number,
br2.Account_type secondary_account_type,  
bt1.Transaction_amount   primary_acct_tran_amount
from bank_account_relationship_details br1
LEFT JOIN bank_account_relationship_details br2
on br1.Account_Number = br2.Linking_Account_Number
LEFT JOIN bank_account_transaction bt1
on br1.Account_Number  = bt1.Account_Number;

#q21

Select
br1.Account_Number Primary_account_number,
br1.Account_type Primary_account_type,
br2.Account_Number Secondary_account_number,
br2.Account_type Secondary_account_type,
sum(bt2.Transaction_amount)  Secondary_account_transaction_amount
FROM bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
ON  br1.Account_Number   = br2.Linking_Account_Number
AND br2.Account_type      = '%Credit%'    
JOIN bank_account_transaction bt2
on bt2.Account_Number = br2.Account_Number
group by
br1.Account_Number,
br1.Account_type,
br2.Account_Number,
br2.Account_type; 


#q22

SELECT
bt1.account_Number  Primary_account_number,
date_format(bt2.Transaction_Date , '%Y-%m') next_month_transaction_date,
sum(bt2.Transaction_amount) current_month_cr_tran,
sum(bt1.Transaction_amount) prev_month_cr_tran,
date_format(bt1.Transaction_Date , '%Y-%m') previous_month_transaction_date
FROM
bank_account_transaction bt2
JOIN
bank_account_transaction bt1
on bt2.Account_Number = bt1.Account_Number
and date_format(bt2.Transaction_Date , '%Y-%m') > date_format(bt1.Transaction_Date , '%Y-%m')
group by
bt2.account_Number,
date_format(bt2.Transaction_Date , '%Y-%m') ,
date_format(bt1.Transaction_Date , '%Y-%m');


#q23

SELECT
bt2.account_Number  Primary_account_number,
sum(bt2.Transaction_amount) current_month_tran,
bt2.Transaction_Date CURRENT_tran_date,
sum(bt1.Transaction_amount) prev_month_tran,
bt1.Transaction_Date prev_tran_date
FROM bank_account_transaction bt2
JOIN bank_account_transaction bt1
on bt2.Account_Number = bt1.Account_Number
and bt2.Transaction_Date > bt1.Transaction_Date
group by 
bt2.account_Number,
bt2.Transaction_Date,
bt1.Transaction_Date
HAVING abs(sum(bt2.Transaction_amount)) > abs(sum(bt1.Transaction_amount));

#q24

SELECT br1.Account_Number credit_card_account_number,
br1.Account_type   credit_card_account_type,
count(bat.transaction_amount) count_of_Transaction_amount
FROM bank_account_relationship_details br1
LEFT JOIN bank_account_relationship_details br2
ON br1.Account_Number     = br2.Linking_Account_Number
JOIN bank_account_transaction bat
ON   br1.Account_Number = bat.Account_Number
and  br1.Account_type   like '%Credit%'
group by br1.Account_Number,br1.Account_type;

#q25

SELECT employee_id , first_name,last_name,phone_number,salary, job_id
FROM employee_details
WHERE DEPARTMENT_ID NOT IN(
SELECT DEPARTMENT_ID FROM Department_Details
WHERE DEPARTMENT_NAME='Contracting');

#q26

SELECT
	ba.Account_Number savings_account_number,
	ba.Account_type   savings_account_type,
	br.Account_Number recurring_deposit_account_number,
	br.Account_type   recurring_deposit_account_type,
	count(bat.transaction_date) transaction_date
FROM bank_account ba
JOIN bank_account_relationship_details br
ON ba.Account_Number = br.Linking_Account_Number
JOIN bank_account_transaction bat
ON   br.Account_Number = bat.Account_Number
and  br.Account_type   = 'RECURRING DEPOSITS'
group by
	ba.Account_Number,
	ba.Account_type  ,
	br.Account_Number,
	br.Account_type  
having count(bat.transaction_date) > 3;

#q27

select employee_id , first_name,last_name,phone_number,email, job_id 
 from employee_details where Job_id = any (select job_id from employee_details where Not Job_id = 'IT_PROG');
 
 #q28
 
 SELECT employee_id , first_name, last_name, salary, job_id
FROM employee_details
WHERE  DEPARTMENT_ID=(
SELECT DISTINCT  DEPARTMENT_ID
FROM employee_details WHERE EMPLOYEE_ID='109');

#q29

SELECT employee_id , first_name,last_name,phone_number,salary, job_id
FROM employee_details
WHERE DEPARTMENT_ID NOT IN(
SELECT DEPARTMENT_ID FROM Department_Details
WHERE MANAGER_ID=60);  

#q30

CREATE TABLE emp_dept AS
SELECT ed.employee_id, ed.first_name, ed.last_name, ed.phone_number, ed.job_id, dept.department_name, dept.location_id
FROM employee_details as ed
INNER JOIN
department_details as dept ON ed.EMPLOYEE_ID = dept.EMPLOYEE_ID;
