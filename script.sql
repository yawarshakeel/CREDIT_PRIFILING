-- CREATING DATA BASE:
create database loan_default_project;
use loan_default_project;

-- VIEWING TABLES:
show tables;

-- DESCRIBING TABLE STRUCTURE:
describe data;

-- DATA PREVIEW (FIRST 10 ROWS):
select * 
from data
limit 10;

alter table data change `Default` Defaulted int;


						-- ===============================================================================================
																-- EDA --
					    -- ===============================================================================================

-- 1: TOTAL DEFAULT %:

select 
    count(Defaulted) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data;



-- 2: AVERAGE LOAN AMOUNT BY EDUCATION:

select Education, round(avg(LoanAmount),2) as avg_loan_amount
from data
group by Education;



-- 3: TOP 10 HIGHEST INCOME BORROWERS:

select Age, Income, Education, EmploymentType
from data
order by Income desc
limit 10;



-- 4: COUNT OF BORROWERS BY EMPLOYMENT TYPE:

select EmploymentType, count(EmploymentType) as total_borrowers
from data
group by EmploymentType;



-- 5: % OF PEOPLE WITH DEPENDANTS WHO DEFAULTED;

select HasDependents,
 round(100 * sum(case when Defaulted = 1 then 1 else 0 end)/count(HasDependents),2) as percentage
 from data
 group by HasDependents;
 
 
 
 
 -- 6: AVERAGE LOAN AMOUNT BY MARITAL STATUS:
 
 select MaritalStatus, round(avg(LoanAmount),2) as avg_loan_amount
 from data
 group by MaritalStatus;
 
 
 
 -- 7: NUMBER OF DEFAULTS BY AGE GROUPS(CUSTOM AGE RANGES):
 
 select 
	case
		when Age < 25 then 'Below 25'
        when Age between '25' and '34' then '25 - 34'
        when Age between '35' and '44' then '35 - 44'
        when Age between '45' and '54' then '45 - 55'
        else '55 and above'
        end as age_bins,
	count(Defaulted) as total_defaults
    from data
    where Defaulted = 1
    group by age_bins;
    
    
    
-- 8: AVERAGE INCOME AND LOAD AMOUNT FOR DEFAULTERS:

select round(avg(Income),2) as average_income,
	   round(avg(LoanAmount),2) as average_loan_amount
from data where Defaulted = 1;



-- 9: TOP 3 MOST COMMON LOAN PURPOSES:

select LoanPurpose, Count(LoanPurpose) as purpose_count
from data
group by LoanPurpose
order by purpose_count desc
limit 3;



-- 10: NUMBER OF APPLICANTS WITH CO-SIGNER AND THEIR DEFAULT RATE:

SELECT 
    HasCoSigner,
    COUNT(*) AS total_applicants,
    SUM(CASE WHEN Defaulted = 1 THEN 1 ELSE 0 END) AS total_defaults
FROM data
GROUP BY 
    HasCoSigner;      
    
    
    
-- 11: CREDIT SCORE RANGE VS DEFAULT COUNT

select 
    case 
        when CreditScore < 600 then 'Poor (<600)'
        when CreditScore between 600 and 699 then 'Fair (600-699)'
        when CreditScore between 700 and 749 then 'Good (700-749)'
        else 'Excellent (750+)' 
    end as credit_score_range,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by credit_score_range;



-- 12: MONTHS EMPLOYED RANGE VS DEFAULT COUNT:

select 
    case 
        when MonthsEmployed < 12 then 'Less than 1 year'
        when MonthsEmployed between 12 and 60 then '1-5 years'
        when MonthsEmployed between 61 and 120 then '5-10 years'
        else '10+ years'
    end as employment_duration,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by employment_duration;



-- 13: DTI RATIO RANGE VS DEFAULT COUNT:

select 
    case 
        when DTIRatio < 0.2 then 'Low (<0.2)'
        when DTIRatio between 0.2 and 0.35 then 'Moderate (0.2–0.35)'
        else 'High (>0.35)' 
    end as dti_range,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by dti_range;





-- 14: INTEREST RATE RANGE VS DEFAULT COUNT:

select 
    case 
        when InterestRate < 8 then 'Low (<8%)'
        when InterestRate between 8 and 15 then 'Moderate (8–15%)'
        else 'High (>15%)'
    end as interest_rate_range,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by interest_rate_range;



-- 15: NUMBER OF CREDIT LINES VS DEFAULT COUNT:

select 
    NumCreditLines,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by NumCreditLines
order by NumCreditLines;




-- 16: LOAN TERM VS DEFAULT COUNT

select 
    LoanTerm,
    count(*) as total_applicants,
    sum(case when Defaulted = 1 then 1 else 0 end) as total_defaults,
    round(100.0 * sum(case when Defaulted = 1 then 1 else 0 end) / count(*), 2) as default_rate_percent
from data
group by LoanTerm
order by LoanTerm;



-- 17: TOTAL LOAN AMOUNT DISTRIBUTED BY EMPLOYMENT TYPE:

select 
EmploymentType, 
sum(LoanAmount) as total_loan_amount
from data
group by EmploymentType;



-- 18: RANKING OF LOAN PURPOSES BASED ON AVERAGE LOAN AMOUNT:

select LoanPurpose, round(avg(LoanAmount),2) as avg_loan_amount,
rank() over (order by avg(LoanAmount) desc) as loan_amount_rank
from data
group by LoanPurpose;



-- 19: TOP 10 LOAN AMOUNTS WITH APPLICANT INFORMATION:

select * 
from (
    select 
        Age,MaritalStatus, Income, LoanAmount,
        dense_rank() over (order by LoanAmount desc) as rnk
    from data
) as ranked_data
where rnk <= 10;



-- 20: AVERAGAE INCOME OD DEFAULTERS VS NON DEFAULTERS:

select d_status,
		round(avg(Income),2) as average_income
from (select Income,
	case when Defaulted = 1 then 'Defaulter' else 'Non-Defaulter'
    end as d_status
    from data) as income_bins
    group by d_status;
    
    


-- 21: DEFAULTS BY LOAN PURPOSE:

select LoanPurpose, count(LoanPurpose) as total_defaults,
dense_rank() over ( order by count(LoanPurpose) desc) as default_rank
from data
where Defaulted = 1
group by LoanPurpose;



-- 22: % OF APPLICANTS DEFAULTING IN EACH EMPLOYMENT TYPE:

select EmploymentType, 
round(sum(case when Defaulted = 1 then 1 else 0 end ) * 100.0 /count(Defaulted),2) as default_rate_percentage
from data
group by EmploymentType;



-- 23: LOAN AMOUNT STATUS (MIN,MAX,AVG) FOR EACH EDUCATION LEVEL:

select Education,min(LoanAmount),max(LoanAmount),round(avg(LoanAmount),2) as avg_loan_amount
from data
group by Education;



-- 24: APPLICANTS WITH LOAN AMOUNT ABOVE OVERALL AVERAGE:

select Age, Income, LoanAmount
from data
where LoanAmount > (select avg(LoanAmount)
					from data);
                    
                    
                    
-- 25: TOP 5 INCOME APPLICANTS WHO DEFAULTED:

select Age,Income,LoanAmount,EmploymentType
from data
where Defaulted =1	
order by Income desc
limit 5;




-- 26: AVERAGE LOAN TERM EMPLOYMENT TYPE:

select EmploymentType, avg(LoanTerm)
from data
group by EmploymentType;










