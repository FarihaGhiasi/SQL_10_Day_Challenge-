-- Active: 1682426661408@@127.0.0.1@3306

CREATE TABLE IF NOT EXISTS Departments (
  Code INTEGER,
  Name TEXT NOT NULL,
  Budget decimal NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE IF NOT EXISTS Employees (
  SSN INTEGER,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  PRIMARY KEY (SSN)   
);

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

--Questions

-- 2.1 Select the last name of all employees.
select lastname
from employees;

-- 2.2 Select the last name of all employees, without duplicates.
select DISTINCT lastname
from employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
select * 
from employees 
where lastname = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select *
from employees 
where lastname = 'Smith' or 'Doe';

-- 2.5 Select all the data of employees that work in department 14.
select * 
from employees 
where department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select *
from employees 
where department = 37 or 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
select *
from employees
where lastname like 'S%';

-- 2.8 Select the sum of all the departments' budgets.
select sum(budget)
from departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and 
--the number of employees).
select count(department), department
from employees
group by department;

-- 2.10 Select all the data of employees, including each employee's department's data.
select *
from employees e
join departments as d
on e.department = d.code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the 
--employee's department.
select e.name, e.lastname, d.name, d.budget
from employees as e 
join departments as d 
on e.department = d.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than 
--$60,000.
select e.name, e.lastname, d.budget
from employees as e 
join departments as d
on e.department = d.code
where d.budget >60000;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select name, budget
from departments
where budget > (select avg(budget)
                from departments);

-- 2.14 Select the names of departments with more than two employees.
select name 
from departments
where code in (select department
                from employees
                group by department
                having count(*) > 2);

-- 2.15 Select the name and last name of employees working for the two departments with lowest budget.
select e.name, e.lastname
from employees as e
join (
    select code
    from departments
    order by budget
    limit 2
) as d
on e.department = d.code;

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
insert into departments (code, name, budget) values (11, 'Quality Assurance', 40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into employees (ssn, name, lastname, department) values (847-21-9811, 'Mary', 'Moore', 11);

-- 2.17 Reduce the budget of all departments by 10%.
update departments
set budget = budget - (budget*10/100);

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees 
set department = 14
where department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
delete 
from employees
where department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees 
where department in (select code
                    from departments
                    where budget >= 60000 );

-- 2.21 Delete from the table all employees.
delete 
from employees;
   


  
     