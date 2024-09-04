/* 1 */
create database bootcamp_exercise1;
use bootcamp_exercise1;

create table regions (
region_id int primary key , region_name varchar(25) 
);

create table countries (
country_id char(2) primary key, country_name varchar(40), region_id int
, foreign key (region_id) references regions(region_id)
 );

create table locations ( location_id int primary key, street_address varchar(25)
, postal_code varchar(12), city varchar(30), state_province varchar(12), country_id char(2)
, foreign key (country_id) references countries(country_id)
 );
 
create table departments (
department_id int primary key, department_name varchar(30), manager_id int, location_id int,
foreign key (location_id) references locations(location_id)
);

create table jobs (
job_id varchar(10) primary key, job_title varchar(35), min_salary decimal(8,4), max_salary decimal(8,4)
);

create table employees ( 
employee_id int primary key, first_name varchar(20), last_name varchar(25), 
email varchar(25), phone_number varchar(20), hire_date date, job_id varchar(10), salary decimal(10,4), 
commission_pct decimal(10,4), manager_id int, department_id int, 
foreign key (job_id) references jobs(job_id),
foreign key (department_id) references departments(department_id),
);

create table job_history (
employee_id int, start_date date, end_date date, job_id varchar(10), department_id int,
foreign key (employee_id) references job_history(employee_id), 
foreign key (job_id) references jobs(job_id),
foreign key (department_id) references departments(department_id),
primary key (employee_id,start_date)
 );
 
/* alter table job_history add constraint primary key (employee_id,start_date); */
/* alter table job_history drop primary key */


/*
alter table employees modify column salary decimal(10,4)
alter table employees modify column commission_pct decimal(10,4)

create table jobs_grades (
grade_level varchar(2) primary key, lowest_sal decimal(8,4), highest_sal decimal(8,4)
);
*/

/* 2 */
insert into regions value ('4','2015');
insert into regions value ('3','2014');
insert into regions value ('2','2013');
insert into regions value ('1','2012');
insert into countries value ('DE','Germany','1');
insert into countries value ('IT','Italy','1');
insert into countries value ('JP','Japan','3');
insert into countries value ('US','United State','2');
insert into locations value ('1000','1297 Via Cola di Rie','989','Roma','','IT');
insert into locations value ('1100','93091 Calle della Te','10934','Venice','','IT');
insert into locations value ('1200','2017 Shinjuku-ku','1689','Tokyo','Tokyo','JP');
insert into locations value ('1400','2014 Jabberwocky Rd','26192','Southlake','Texas','US');
insert into departments value ('10','Administration','200','1100');
insert into departments value ('20','Marketing','201','1200');
insert into departments value ('30','Purchasing','202','1400');

insert into jobs value ('IT_PROG','','30','0');
insert into jobs value ('MK_REP','','10','0');
insert into jobs value ('ST_CLERK','','10','0');
insert into employees value ('100','Steven','King','SKING','515-1234567','1987-06-17','ST_CLERK','24000.00','0.00','109','10');
insert into employees value ('101','Neena','Kochhar','NOCHHAR','515-1234568','1987-06-18','MK_REP','17000.00','0.00','103','20');
insert into employees value ('102','Lex','De Haan','LDHAAN','515-1234569','1987-06-19','IT_PROG','17000.00','0.00','108','30');
insert into employees value ('103','Alexander','Hunold','AHUNOLD','590-4234567','1987-06-20','MK_REP','9000.00','0.00','105','20');
insert into job_history value ('102','1993-01-13','1998-07-24','IT_PROG','20');
insert into job_history value ('101','1989-09-21','1993-10-27','MK_REP','10');
insert into job_history value ('101','1993-10-28','1997-03-15','MK_REP','30');
insert into job_history value ('100','1996-02-17','1999-12-19','ST_CLERK','30');
insert into job_history value ('103','1998-03-24','1999-12-31','MK_REP','20');



/* insert into jobs_grades value ('4','2015','30'); */

/* 3 */
select location_id, street_address, city, state_province, c.country_name 
from locations l inner join countries c on l.country_id = c.country_id;

/* 4 */
select first_name, last_name, department_id from employees;

/* 5 */
select first_name, last_name, job_id, e.department_id 
from employees e 
inner join departments d on e.department_id = d.department_id 
left join locations l on d.location_id = l.location_id inner join countries c on l.country_id = c.country_id
where country_name in ('japan');

/* 6 */
select e1.employee_id, e1.last_name, e1.manager_id,e2.last_name 
from employees e1 left outer join employees e2 on e1.manager_id = e2.employee_id;

/* 7 */
select first_name,last_name,hire_date from employees
where hire_date > (select hire_date from employees where concat(first_name,' ',last_name) like '%Lex De Haan%')


/* 8 */
select d.department_name,count(employee_id) number 
from employees e inner join departments d on e.department_id = d.department_id
group by d.department_name

/* 9 */
select jh.employee_id, j.job_title,(jh.end_date - jh.start_date) NumberOfDays
from jobs j 
inner join job_history jh on j.job_id = jh.job_id 
left outer join departments d on jh.department_id = d.department_id
where d.department_id = '30';


/* 10 */
select d.department_name,'' as manager_name,l.city, c.country_name,d.manager_id
from departments d inner join employees e on d.department_id = e.department_id
left outer join locations l on d.location_id = l.location_id 
left outer join countries c on l.country_id = c.country_id
group by d.department_name,l.city, c.country_name,d.manager_id;


/* 11 */ 
select d.department_name,avg(e.salary) as AverageSalary
from employees e inner join departments d on e.department_id = d.department_id 
group by d.department_name;






