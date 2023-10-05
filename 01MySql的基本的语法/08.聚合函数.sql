-- 常见的几个聚合函数
-- 1.1avg/   sum（假如里面变成字符串 没有用）
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees;

-- 1.2max/min
SELECT job_id, MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees
GROUP BY job_id;


-- 1.3count

-- 查询指定的字段在该结构中出现的次数
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;


-- group by
-- 查询各个部门的平局工资 最高的工资
SELECT department_id,AVG(salary),SUM(salary)
FROM employees
GROUP BY department_id;

-- 需求查询各个job_id的平均工资
SELECT job_id,AVG(salary)
FROM employees
GROUP BY job_id;

-- 使用多个列进行分组 group by 后面的顺序不影响生成的内容的
-- 查询各个department_id，job_id的平均工资
SELECT job_id,department_id,AVG(salary)
FROM employees
GROUP BY department_id,job_id;

-- tip:select中出现的字段一定是要在group by中 但是group by的字段可以不出现在select 中
-- 操作的出现顺序:select ,from ,where, group by ,limit ,order by


-- having的使用 用于过滤数据group by 之后的数据要筛选出来 要使用having 而不是where 不然得话会报错
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary)>10000;

-- 查询10 20 30 40这几个部门汇总的最高的工资比10000高的信息第一种方法
-- 第一种方法执行效率高一些
SELECT department_id,MAX(salary)
FROM employees
WHERE department_id IN (10,20,30,40)
GROUP BY department_id
HAVING MAX(salary)>7000;

-- 第二种方法
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary)>7000 AND department_id IN (10,20,30,40);
-- tip 当过滤的有聚合函数的时候 过滤条件要声明在having中 假如没有的话 过滤的条件要声明最好在where中



-- sql底层原理 
-- sql92语法
-- select -----------存在聚合函数
-- from------------多表连接的条件 and不包含聚合函数的过滤的条件
-- group by
-- limit


-- SQL99的语法
-- select --------存在聚合函数
-- from ------
-- join ---on----
-- where 多表连接 不包含聚合函数
-- group by-------
-- having 包含聚合函数的条件
-- order  by 
-- limit

-- sql语句的执行的过程
-- （from->where->group by->having->）->(select)->(order by->limit)





































