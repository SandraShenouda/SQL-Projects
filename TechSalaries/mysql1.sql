create database Salaries;

create table tech_salary(
job_title varchar(50),
seniority varchar(10),
annual_salary int
);

select * from tech_salary;

-- What is the average salary of a Junior-level Product Manager?

select job_title, avg(annual_salary) as average_salary
from tech_salary
where job_title='Product Manager' and
seniority='Junior';


-- Among the jobs that have data on Intern-level positions, which job title has the lowest average salary?

select job_title, min((annual_salary)) as min_salary , avg(annual_salary) as average_salary
from tech_salary
where seniority='Intern'
group by job_title;


-- Which job title has the highest average salary at the Senior level?

select job_title, max(annual_salary) as maximum_salary, avg(annual_salary) as average_salary
from tech_salary
where seniority='Senior'
group by job_title;


-- What is the average salary of a Mid-level Data Scientist?

select job_title, avg(annual_salary)
from tech_salary
where job_title='Data Scientist' and seniority='Mid';


-- What is the average salary of a Mid-level Software Developer?

select job_title, avg(annual_salary)
from tech_salary
where job_title = 'Software Developer' and seniority='Mid';


-- Which job title has the highest average salary at the Mid-level?

select job_title, max(annual_salary) as maximum_salary, avg(annual_salary)
from tech_salary
where seniority='Mid'
group by job_title;


-- Which job title and seniority combination has an average salary of $32,000?

select job_title, seniority
from tech_salary
group by job_title, seniority
having avg(annual_salary)=32000;



-- What is the average salary of a Mid-level QA Engineer?

select job_title, avg(annual_salary)
from tech_salary
where job_title='QA Engineer' and seniority='Mid';


-- Which seniority level for Data Analysts has the highest average salary?

select seniority , max(annual_salary) , avg(annual_salary)
from tech_salary
where job_title='Data Analyst'
group by seniority;


-- Which job title category shows a significant salary increase from Junior to Senior levels?

select job_title,(avg(case when seniority='Senior' then annual_salary end)-avg(case when seniority='Junior' then annual_salary end)) as salary_diff
from tech_salary
group by job_title
having salary_diff > 20000
order by salary_diff desc;