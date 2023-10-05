-- 6.多表查询 关联查询


-- 常见的几个表
DESC employees;

DESC departments;

DESC locations;


-- 出现笛卡尔积错误:缺少多表的连接的条件 是的每个员工id都与部门匹配一遍
SELECT employee_id,department_name
FROM employees,departments;#出现2889条记录=27*107

SELECT employee_id
FROM employees;#107条记录

SELECT departments_name
FROM departments;#27条记录


-- 正确的查询方式 添加表的连接条件

SELECT employee_id,department_name
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;

-- 查询语句中出现多个表中都存在的字段必须要指明这个字段是来自于哪一个表

SELECT employee_id,department_name,employees.`department_id`
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;


-- 为了sql的优化 最好每一个字段都指明是来自与哪一个表
SELECT employees.`employee_id`,departments.`department_name`,employees.`department_id`
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;

-- 为了增加可读性 可以给表设置一个别名:假如给表起了一个别
--  在where 与select中就必须使用表的别名 使用表的原来的名称就会导致报错
SELECT dp.department_name,ep.`department_id`
FROM employees ep,departments dp
WHERE ep.`department_id`=dp.`department_id`;


-- 查询员工的employee_id last_name,department_name,city
SELECT e.employee_id,e.last_name,d.department_name,l.city
FROM employees e,departments d,locations l
WHERE e.`department_id`=d.`department_id` AND d.`location_id`=l.`location_id`;
 
-- 有n个表实现查询 至少要提供的关系是n-1个关系



-- 多表查询的分类
-- 1.上述的是等值连接 下面展示的是非等值连接
SELECT e.`last_name`,e.`salary`,j.`grade_level`
FROM employees e,job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;

-- 自连接:查询员工的名字与id 及其管理者的姓名与id  就要给员工表取不同的别名
SELECT emp.`employee_id`,emp.`last_name`,mgr.`employee_id`,mgr.`last_name`
FROM employees emp,employees mgr
WHERE emp.`manager_id`=mgr.`employee_id`;



-- 内连接与外连接
-- 内连接：两个或者是两个以上的表的同一列合并 但是结果集中不包括一个表与另一个表不匹配的行：上面的表的连接都是内连接


-- 外连接 合并具有相同的列的行 结果集中包含一个表与另一个表的匹配的行之外 还包含不匹配的行
-- 外连接的分类:左外连接 右外连接 满外连接
-- 左外连接：合并具有相同的列的行 结果集中包含一个表与另一个表的匹配的行之外 还包含左表不匹配的行
-- 右外连接：合并具有相同的列的行 结果集中包含一个表与另一个表的匹配的行之外 还包含右表不匹配的行
-- 满外连接：全集


-- sql99实现内连接只有106 因为有一行的department_id是null,并且链接一张表就要加上一次join on
SELECT last_name,department_name,city
FROM employees e 
JOIN departments d
ON e.`department_id`=d.`department_id`
JOIN locations l
ON d.`location_id`=l.`location_id`;

-- sql99使用join on实现外连接 将值是null的参数也统计进来

-- 左外连接107行
SELECT last_name,department_name
FROM employees e 
LEFT JOIN departments d
ON e.`department_id`=d.`department_id`

-- 右外连接122行
SELECT last_name,department_name
FROM employees e 
RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`;

-- 全部外连接mysql不支持full outer 使用union 或者是union all实现 union all会将重复的数字去除掉 但是union单独的话就不会去除 
-- 123行
SELECT last_name,department_name
FROM employees e 
RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`
UNION ALL
SELECT last_name,department_name
FROM employees e 
LEFT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE e.`department_id` IS NULL;



-- sql99新特性把natural join 会将自动的查询两张表中的相同的字段并且做等值连接
SELECT employee_id,last_name,department_id
FROM employees e 
NATURAL JOIN departments d;

-- using（）使用特定的字段作为两张表的链接
SELECT employee_id,last_name,department_id
FROM employees e 
JOIN departments d
USING (department_id);

















