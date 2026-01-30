-- CREATE DATABASE loan_analysis;
--  USE loan_analysis;
-- CREATE TABLE loan_data (
--     id INT,
--     address_state VARCHAR(10),
--     application_type VARCHAR(20),
--     emp_length VARCHAR(20),
--     emp_title VARCHAR(100),
--     grade CHAR(2),
--     home_ownership VARCHAR(20),
--     issue_date DATE,
--     last_credit_pull_date DATE,
--     last_payment_date DATE,
--     loan_status VARCHAR(30),
--     next_payment_date DATE,
--     member_id INT,
--     purpose VARCHAR(50),
--     sub_grade VARCHAR(5),
--     term VARCHAR(20),
--     verification_status VARCHAR(30),
--     annual_income DECIMAL(12,2),
--     dti DECIMAL(6,4),
--     installment DECIMAL(10,2),
--     int_rate DECIMAL(6,4),
--     loan_amount INT,
--     total_acc INT,
--     total_payment DECIMAL(12,2)
-- );
-- LOAD DATA INFILE
-- 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/financial_loan.csv'
-- INTO TABLE loan_data
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (
--  id,
--  address_state,
--  application_type,
--  emp_length,
--  emp_title,
--  grade,
--  home_ownership,
--  @issue_date,
--  @last_credit_pull_date,
--  @last_payment_date,
--  loan_status,
--  @next_payment_date,
--  member_id,
--  purpose,
--  sub_grade,
--  term,
--  verification_status,
--  annual_income,
--  dti,
--  installment,
--  int_rate,
--  loan_amount,
--  total_acc,
--  total_payment
-- )
-- SET
--  issue_date = STR_TO_DATE(@issue_date, '%d-%m-%Y'),
--  last_credit_pull_date = STR_TO_DATE(@last_credit_pull_date, '%d-%m-%Y'),
--  last_payment_date = STR_TO_DATE(@last_payment_date, '%d-%m-%Y'),
--  next_payment_date = STR_TO_DATE(@next_payment_date, '%d-%m-%Y');

-- ALTER TABLE loan_data
-- ADD PRIMARY KEY (id);
-- ALTER TABLE loan_data
-- MODIFY emp_title VARCHAR(100) NULL;

select * from loan_data;

-- A.DashBoard 1 - Summary
-- (I)KPIs

-- -- 1.Total loan  application
-- select count(id) as Total_Loan_Applications from loan_data ;

-- -- MTD Aplications(month  to date)
-- select count(id) as MTD_Total_Loan_Applications from loan_data
-- where Month(issue_date)=12 and Year(issue_date) =2021;

-- -- PMTD Aplications( Previous month  to date)
-- select count(id) as PMTD_Total_Loan_Applications from loan_data
-- where Month(issue_date)=11 and Year(issue_date) =2021;

-- -- MOM(month of month) Loan Applications ( MOM = (MTD - PMTD) / PMTD )
-- select Round(((MTD-PMTD)/PMTD*100),2) as Mom_Percentage
-- from(select 
-- (select count(id)  from loan_data
-- where Month(issue_date)=12 and Year(issue_date) =2021) as MTD,
-- (select count(id) from loan_data
-- where Month(issue_date)=11 and Year(issue_date) =2021) as PMTD )
-- as t;


-- -- 2. Total Funded Amount

-- select Sum(loan_amount) as Total_Funded_Amount from loan_data;

-- -- MTD Total Funded Amount
-- select Sum(loan_amount) as MTD_Total_Funded_Amount from loan_data
-- where Month(issue_date)=12 And Year(Issue_date)=2021;

-- -- PMTD Total Funded Amount
-- select Sum(loan_amount) as PMTD_Total_Funded_Amount from loan_data
-- where Month(issue_date)=11 And Year(Issue_date)=2021;

-- -- MOM Total Funded Amount
-- select round(((MTD-PMTD)/PMTD)*100,2) as MOM_Total_Funded_Amount
-- from (select
-- (select Sum(loan_amount) from loan_data
-- where Month(issue_date)=12 And Year(Issue_date)=2021)as MTD,
-- (select Sum(loan_amount)  from loan_data
-- where Month(issue_date)=11 And Year(Issue_date)=2021) as PMTD)
-- as t;


-- -- 3.Total Amount Received
--  select Sum(total_payment) As Total_Amount_Received  from loan_data;
--  
-- --  MTD Total Amount Received
-- select Sum(total_payment) As MTD_Total_Amount_Received  from loan_data
-- where month(issue_date)=12 and Year(issue_date)=2021;

-- -- PMTD Total Amount Received
-- select Sum(total_payment) As PMTD_Total_Amount_Received  from loan_data
-- where month(issue_date)=11 and Year(issue_date)=2021;

-- -- MOM Total Amount Received
-- select (MTD-PMTD)/PMTD*100  as MOM_Total_Amount_Received 
-- from (select
-- (select Sum(total_payment)  from loan_data
-- where month(issue_date)=12 and Year(issue_date)=2021) as MTD,
-- (select Sum(total_payment)  from loan_data
-- where month(issue_date)=11 and Year(issue_date)=2021)PMTD)
-- as t;
--  
 

-- -- 4. Average Interest Rate

-- select Avg(int_rate)*100  as "Average Interest Rate Percentage " from loan_data;

-- --  MTD Average Interest Rate
-- select Avg(int_rate)*100  as " MTD Average Interest Rate Percentage " from loan_data
-- where month(issue_date)=12 and Year(issue_date)=2021;

-- -- PMTD Average Interest Rate
-- select Avg(int_rate)*100  as "PMTD Average Interest Rate Percentage " from loan_data
-- where month(issue_date)=11 and Year(issue_date)=2021;

-- -- MOM Average Interest Rate
-- select round(((MTD-PMTD)/PMTD)*100,2)  as "MOM Average Interest Rate Percentage " from 
-- (select
-- (select Avg(int_rate)*100  from loan_data
-- where month(issue_date)=12 and Year(issue_date)=2021)as MTD,
-- (select Avg(int_rate)*100  from loan_data
-- where month(issue_date)=11 and Year(issue_date)=2021) as PMTD)
-- as t;


-- -- 5. Average DTI (debt to income ratio) Percentage

-- select  round(avg(dti)*100,2) as Average_DTI from loan_data;

-- --  MTD Average DTI
select  round(avg(dti)*100,2) as MTD_Average_DTI from loan_data
where month(issue_date)=12 and year(issue_date)=2021;

-- --  PMTD Average DTI
select  round(avg(dti)*100,2) as PMTD_Average_DTI from loan_data
where month(issue_date)=11 and year(issue_date)=2021;

-- -- MOM Average DTI
select (MTD-PMTD)/PMTD*100 as MOM_Average_DTI 
from(select 
(select avg(dti)*100 from loan_data
where month(issue_date)=12 and year(issue_date)=2021) as MTD,
(select  avg(dti)*100 from loan_data
where month(issue_date)=11 and year(issue_date)=2021) as PMTD)
as t;


-- select  distinct loan_status from loan_data;

--  6. Good Loan 

-- Good Loan Application Percentage
-- select ((select count(id) from loan_data where loan_status IN ('Fully Paid', 'Current'))/count(id)*100) as Good_loan_percentage
-- from loan_data;

-- select count(case when loan_status = "Fully Paid" or Loan_status ="Current" then id end)/count(id) 
-- from loan_data;

-- -- No of Good Loan Applications
-- select Count(id) as No_of_GOOD_LOANS from loan_data
-- where loan_status in("Fully Paid","Current");

-- Good Loan Funded Amount
-- select Sum(loan_amount) as Funded_Amount  
-- from loan_data
-- where loan_status in("Fully Paid","Current");

-- -- Good Loan Total Amount received
-- select sum(total_payment) as Total_Amount_Received
-- from loan_data
-- where loan_status in("Fully Paid","Current");


-- 7.Bad Loan
---- --  Bad Loan Application Percentage
-- select ((select count(id) from loan_data where loan_status="Charged Off")/count(id)*100) as Bad_loan_percentage
-- from loan_data;

-- -- No of Bad Loan Applications
-- select Count(id) as No_of_Bad_LOANS from loan_data
-- where loan_status="Charged Off";

-- -- Bad Loan Funded Amount
-- select Sum(loan_amount) as Funded_Amount  
-- from loan_data
-- where loan_status="Charged Off";

-- -- Bad Loan Total Amount received
-- select sum(total_payment) as Total_Amount_Received
-- from loan_data
-- where loan_status="Charged Off";


-- -- 8. Loan status Grid View
-- select 
-- distinct loan_status ,
-- count(id) as Total_Loan_Applications,
-- sum(loan_amount) as Total_Funded_Amount,
-- sum(total_payment) as Total_Amount_Received,
-- Avg(int_rate)*100 as Average_Interest_Rate,
-- Avg(dti)*100 as Average_DTI
-- from loan_data
-- group by loan_status;

-- -- 9.Loan status Grid Viwe with MTD
-- select 
-- distinct loan_status,
-- sum(total_payment) as MTD_Total_Amount_Received,
--  sum(loan_amount) as MTD_Total_Funded_Amount
--  from loan_data
--  where Month(issue_date) =12
--  group by loan_status;

-- -- Loan status Grid Viwe with PMTD
-- select 
-- distinct loan_status,
-- sum(total_payment) as PMTD_Total_Amount_Received,
--  sum(loan_amount) as PMTD_Total_Funded_Amount
--  from loan_data
--  where Month(issue_date) =11
--  group by loan_status;


-- --  MOM of Total amount Received by Loan Status
-- SELECT
--     loan_status,
--     ROUND(
--         (SUM(CASE WHEN MONTH(issue_date) = 12 THEN total_payment ELSE 0 END) -
--          SUM(CASE WHEN MONTH(issue_date) = 11 THEN total_payment ELSE 0 END))
--         /
--         NULLIF(SUM(CASE WHEN MONTH(issue_date) = 11 THEN total_payment ELSE 0 END), 0)
--         * 100,
--         2
--     ) AS MOM_Total_Amount_Received
-- FROM loan_data
-- WHERE YEAR(issue_date) = 2021
-- GROUP BY loan_status;


-- -- MOM of Total Amount funded by Loan status

-- SELECT 
--     loan_status,
--     ROUND(
--         (
--             SUM(CASE WHEN MONTH(issue_date) = 12 THEN loan_amount ELSE 0 END)
--           - SUM(CASE WHEN MONTH(issue_date) = 11 THEN loan_amount ELSE 0 END)
--         )
--         / NULLIF(
--             SUM(CASE WHEN MONTH(issue_date) = 11 THEN loan_amount ELSE 0 END),
--             0
--         ) * 100,
--         2
--     ) AS MOM_Total_Funded_Amount
-- FROM loan_data
-- WHERE YEAR(issue_date) = 2021
-- GROUP BY loan_status;
--  



-- B. Overview 
 
 -- 1.Monthly trends by issue date
 select 
 month(Issue_date) as Month_Number,
 monthname(issue_date)as Month_Name,
 count(id) as Total_Loan_Applications,
 sum(loan_amount) as Total_Funded_Amount,
 sum(total_payment) as Total_Received_Amount
 from loan_data
 group by Month_Name,Month_Number
 order by Month_Number;
 
--  2. Regional Analysis By state
select
 address_state as State,
 count(id) as Total_Loan_Applications,
 sum(loan_amount) as Total_Funded_Amount,
 sum(total_payment) as Total_Received_Amount
 from loan_data
 group by State
 order by State;
 
 
 -- 3.Loan Term Analysis
select 
term  as Loan_Term,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Received_Amount
from loan_data
group by term;


-- 4.Employement Length Analysis

select
emp_length as Employement_length,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Received_Amount
from loan_data
group by emp_length
order by emp_length;


-- 5.Loan Purpose Breakdown
select 
 purpose As Purpose,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Received_Amount
from loan_data
group by purpose
order by purpose;


-- 6.Home Ownership Analysis
select 
home_ownership as Home_Ownership,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Received_Amount
from loan_data
group by Home_Ownership
order by Home_Ownership;



-- C. Grid  View
select * from loan_data;

-- See the results when we hit the Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;




 







