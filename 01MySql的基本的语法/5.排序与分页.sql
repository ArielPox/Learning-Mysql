-- 排序与分页

-- 1.排序
SELECT * 
FROM employees;


-- 使用order by进行排序 降序ascend 升序asc   不添加升序还是降序的字段的 就默认的是升序的排序
-- 按照员工的工资从高到低显示员工的姓名与部分
SELECT employee_id,last_name,salary
FROM employees	
ORDER BY salary ASC;

-- 降序排序
SELECT employee_id,last_name,salary
FROM employees	
ORDER BY salary DESC;

-- 可以使用列的别名进行排序 并且列的别名只可以在order by中使用 其他的不可以
SELECT employee_id,last_name,salary*12 annual_salary
FROM employees	
ORDER BY annual_salary DESC;

-- where需要声明在from前面 order by之前


-- 多级排序：二级排序 按照员工的department id进行降序排序 在个根据salary进行升序排序
SELECT employee_id,last_name,salary
FROM employees	
ORDER BY department_id DESC,salary ASC;



-- 分页查询：查询的数据太多 需要一页一页的进行显示 再去查询每一页
-- 需求：每页20条记录 显示第一页 第一个数是偏移量 第二个数是每页的数据的条数
SELECT employee_id,last_name,salary
FROM employees	
LIMIT 0,20;

-- 需求：每页20条记录 显示第二页 
SELECT employee_id,last_name,salary
FROM employees	
LIMIT 20,20;

-- 公式：limit pageSize*(pagenumber-1),pagesize;


-- where -----order by ------limit 的声明的顺序是：
SELECT employee_id,last_name,salary
FROM employees	
ORDER BY salary ASC
LIMIT 0,20;


-- 需求：只显示32，33条数据

SELECT employee_id,last_name,salary
FROM employees	
LIMIT 31,2;


-- mysql8.0版本的新特性：limit 数据的条数 offset 偏移量
SELECT employee_id,last_name,salary
FROM employees	
LIMIT 2 OFFSET 31;





