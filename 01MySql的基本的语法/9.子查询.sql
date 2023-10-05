-- 1.基本的使用
-- 题目：查询工资大于149号员工工资的员工的信息--
SELECT last_name 
FROM employees
WHERE salary>
             (SELECT salary
             FROM employees
             WHERE employee_id=149
             ) ;
             
-- 题目：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT last_name 
FROM employees
WHERE job_id=
              (SELECT job_id
              FROM employees
              WHERE employee_id=141
              )
AND salary>
(SELECT salary
FROM employees
WHERE employee_id=143);

-- 2.case的查询子句
-- 题目：显式员工的employee_id,last_name和location。其中，若员工department_id与location_id为1800
-- 的department_id相同，则location为’Canada’，其余则为’USA’。
SELECT employee_id,last_name,
(CASE department_id
WHEN 
    (SELECT department_id
    FROM departments
    WHERE location_id=1800)
THEN 'Canada' ELSE 'USA' END
)  location
FROM employees;

-- 3.子查询的空值查询的问题 子查询就不会返回行
SELECT last_name,job_id
FROM employees
WHERE job_id=
		(
		SELECT job_id
		FROM employees
		WHERE last_name='小猪佩奇'
		);

-- 多行子查询
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE salary<ANY
                (
                SELECT salary
                FROM employees
                WHERE job_id='IT_PROG'
                )
AND             job_id<>'IT_PROG';


-- 题目：查询平均工资最低的部门id
SELECT department_id
FROM employees	
GROUP BY department_id
HAVING AVG(salary)<=ALL(
                     SELECT AVG(salary) avg_sal
                     FROM employees
                     GROUP BY department_id
                     );


-- 空值查询
SELECT last_name
FROM employees
WHERE employee_id NOT IN (
                          SELECT manager_id
                          FROM employees			
			);
			
			
-- 如果子查询的执行依赖于外部查询，通常情况下都是因为子查询中的表用到了外部的表，并进行了条件
-- 相关子查询按照一行接一行的顺序执行，主查询的每一行都执行一次子查询。

-- 题目：查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
SELECT last_name,salary,e1.department_id
FROM employees e1,(
SELECT department_id,AVG(salary) dept_avg_sal 
FROM employees
GROUP BY department_id
)e2
WHERE e1.`department_id`=e2.department_id
AND e2.dept_avg_sal<e1.`salary`;


-- 题目：查询员工的id,salary,按照department_name 排序
SELECT employee_id,salary
FROM employees e
ORDER BY(SELECT department_name
         FROM departments d
         WHERE e.`department_id`=d.`department_id`
	);

-- 题目：若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同
-- id的员工的employee_id,last_name和其job_id
SELECT e.employee_id,last_name,e.job_id
FROM employees e
WHERE 2<=(
          SELECT COUNT(*)
          FROM job_history j
          WHERE j.`employee_id`=e.`employee_id`        
          );


-- 4.3 EXISTS 与 NOT EXISTS关键字
-- 关联子查询通常也会和 EXISTS操作符一起来使用，用来检查在子查询中是否存在满足条件的行。
-- 如果在子查询中不存在满足条件的行：
-- 条件返回 FALSE
-- 继续在子查询中查找
-- 如果在子查询中存在满足条件的行：
-- 不在子查询中继续查找
-- 条件返回 TRUE
-- NOT EXISTS关键字表示如果不存在某种条件，则返回TRUE，否则返回FALSE。

-- 查询公司管理者的employee_id，last_name，job_id，department_id信息
SELECT employee_id,last_name,job_id,department_id
FROM employees e1
WHERE EXISTS (
SELECT *
FROM employees e2
WHERE e2.`manager_id`=e1.`employee_id`
);

-- 方法二自连接
SELECT DISTINCT e1.`employee_id`,e1.`last_name`,e1.`department_id`
FROM employees e1 JOIN employees e2
WHERE e1.`employee_id`=e2.`employee_id`;


-- method3
SELECT employee_id, last_name, job_id, department_id
FROM employees e1
WHERE employee_id IN(
SELECT DISTINCT manager_id
FROM employees)


-- 查询departments表中，不存在于employees表中的部门的department_id and department_name
SELECT department_id,department_name
FROM departments d
WHERE NOT EXISTS(
SELECT 'X'
FROM employees
WHERE department_id=d.department_id
)

-- 使用相关子查询依据一个表中的数据更新另一个表的数据。
-- 题目：在employees中增加一个department_name字段，数据为员工对应的部门名称

-- 题目：在employees中增加一个department_name字段，数据为员工对应
UPDATE employees e
SET department_name=(SELECT department_name
FROM departments d
WHERE e.department_id=d.`department_id`
);


-- 删除emplyees中的与emp_history表都有的数据
DELETE FROM employees e
WHERE employee_id IN(SELECT employee_id
FROM job_history j
WHERE j.`department_id`=e.
);

























