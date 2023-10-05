-- select where 基本语句的练习题
USE atguigudb;
SELECT *
FROM employees;

-- 1.查询员工的12个月的工资 并且命名我annual salary

-- 计算基本的工资
SELECT employee_id,last_name,salary,commission_pct,salary*12 AS "annual salary"
FROM employees;


-- 计算基本工资加上奖金
SELECT employee_id,last_name,salary,commission_pct,salary*(1+IFNULL(commission_pct,0))*12 AS "annual salary1"
FROM employees;

-- 2.去除重复的job_id以后得数据
SELECT DISTINCT job_id	
FROM employees;

-- 3.查询员工的工资大于12000的员工的姓名与工资
SELECT department_id,last_name,salary 
FROM employees
WHERE salary>=12000;

-- 4显示表的结构 并且查询其中全部的数据
DESCRIBE departments;

SELECT *
FROM departments;









