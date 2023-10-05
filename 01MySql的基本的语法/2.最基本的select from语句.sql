USE atguigudb;
#1*表示查询的目标的表中所有的字段、
SELECT *
FROM employees;

SELECT employee_id,last_name,salary
FROM employees;

#2给列起一个别名：oldname as newname 其中的as可以省略 newname可以使用一个双引号括起来
SELECT employee_id,last_name AS lname
FROM employees;

#3去重
-- 没有去重的时候就会打印多条数据
 SELECT department_id 
 FROM employees;
 
--  去重的情况
SELECT DISTINCT department_id
FROM employees;
 
 
-- 4 空值null参与运算还是null 这里的null 不是0 不是“” 不是“null” 表示的就是一个未知的数值
SELECT employee_id,salary AS "月工资",salary*(1+commission_pct)*12 "年工资",commission_pct
FROM employees;

-- 将null替换为特定的数值参加运算 下面的额案例就是将null替换为0参与计算
SELECT employee_id,salary AS "月工资",salary*(1+IFNULL(commission_pct,0))*12 "年工资",commission_pct
FROM employees;

-- 5着重号``：当起名与关键字冲突的时候就可以将起名用``保护起来
SELECT *
FROM `order`;

-- 6查询常数 就是在select的后面加上一个常数 这个常数会被添加到所有的字段里面
SELECT '查询常数',123,employee_id,last_name
FROM employees;

--7 显示表结构 显示的是表中的字段的详细的信息
DESCRIBE employees;

-- 8过滤数据 where
SELECT *
FROM employees
WHERE department_id=95;

-- mysql在window的环境下是不会区分大小写的 包括引号里面的内容

 



