-- 常见的数据类型 创建表的两种方式
USE atguigudb;

SHOW CREATE DATABASE atguigudb;

SHOW TABLES;

-- 创建方式一 使用VARCHAR的时候要制定字符的最大的长度
CREATE TABLE IF NOT EXISTS myTable01(
id INT,
emp_name VARCHAR(15),
hire_data DATE
);

-- 查询表结构
DESC myTable01;

SHOW CREATE TABLE myTable01;



-- 创建表是基于现有的表创建出来的
-- 创建一个employee_copy实现对employee的复制 包含里面的表数据
CREATE TABLE employee_copy
AS
SELECT *
FROM employees;

SHOW CREATE TABLE employee_copy;


SELECT * 
FROM employee_copy;


-- 创建一个employee_copy02实现对employee的复制 不包含里面的表数据
CREATE TABLE employee_copy02
AS
SELECT *
FROM employees
WHERE 1=2;
-- 限制出一个不可能出现的数据 就不会选相互数据 就只有列的名称
SELECT * 
FROM employee_copy02;



-- 修改表
-- 添加一个字段默认添加到最后的一个字段的位置
ALTER TABLE mytable01
ADD salary DOUBLE(10,2);

SELECT * 
FROM employee_copy02;


ALTER TABLE mytable01
ADD phone_number VARCHAR(20) FIRST;

ALTER TABLE mytable01
ADD email VARCHAR(20) AFTER emp_name;

DESC mytable01;

-- 修改一个字段 数据的类型 长度 默认值
ALTER TABLE mytable01
MODIFY emp_name VARCHAR(100);

ALTER TABLE mytable01
MODIFY emp_name VARCHAR(20) DEFAULT '默认值';

--  重命名一个字段
ALTER TABLE mytable01
CHANGE salary monthly_salary DOUBLE(10,2);

-- 删除一个字段
ALTER TABLE mytable01
DROP COLUMN hire_data;

DESC mytable01;


-- 重命名表
-- mthods1
RENAME TABLE mytable01
TO mtb01;

DESC mtb01;


-- methods2 
ALTER TABLE mtb01
RENAME TO mytable01;

DESC mytable01;

-- 删除表
-- 不光是删除表中的数据 表的结构也要删除
DROP TABLE IF EXISTS employee_copy02;

SHOW TABLES


-- 清空表只会清空表中的数据 表格结构还保留好
SELECT *
FROM employee_copy

TRUNCATE TABLE employee_copy;

DESC employee_copy;



-- dcl中的commit 与rollback
# COMMIT:提交数据。一旦执行COMMIT，则数据就被永久的保存在了数据库中，意味着数据不可以回滚。
# ROLLBACK:回滚数据。一旦执行ROLLBACK,则可以实现数据的回滚。回滚到最近的一次COMMIT之后。

#8. 对比 TRUNCATE TABLE 和 DELETE FROM 
# 相同点：都可以实现对表中所有数据的删除，同时保留表结构。
# 不同点：
#	TRUNCATE TABLE：一旦执行此操作，表数据全部清除。同时，数据是不可以回滚的。
#	DELETE FROM：一旦执行此操作，表数据可以全部清除（不带WHERE）。同时，数据是可以实现回滚的。

-- 9. DDL 和 DML 的说明
--   ① DDL的操作一旦执行，就不可回滚。指令SET autocommit = FALSE对DDL操作失效。(因为在执行完DDL
--     操作之后，一定会执行一次COMMIT。而此COMMIT操作不受SET autocommit = FALSE影响的。)
--   
--   ② DML的操作默认情况，一旦执行，也是不可回滚的。但是，如果在执行DML之前，执行了 
--     SET autocommit = FALSE，则执行的DML操作就可以实现回滚。

-- 演示delete from
CREATE TABLE department_copy
AS
SELECT *
FROM departments;


SHOW TABLES

COMMIT;

SELECT *FROM department_copy;

SET autocommit=FALSE;

DELETE FROM department_copy;

ROLLBACK;

-- 还原了删除掉的数据
SELECT *
FROM department_copy;


-- 演示的是truncate table
COMMIT;

SELECT * 
FROM department_copy;

SET autocommit=FALSE;

TRUNCATE TABLE department_copy;

ROLLBACK;

-- 对于ddl语言是无法进行rollback的
SELECT *
FROM department_copy;

-- mysql8的新特性：语句原子化 一个语句必须一气呵成的执行完成








































