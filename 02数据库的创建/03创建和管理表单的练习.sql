#练习1：
#1. 创建数据库test01_office,指明字符集为utf8。并在此数据库下执行下述操作
USE atguigudb;

SHOW TABLES;

CREATE DATABASE IF NOT EXISTS test01_office CHARACTER SET 'utf8';

USE test01_office;

创建表dept01；

CREATE TABLE IF NOT EXISTS dept01(
id INT(7),
`name` VARCHAR(25)
);

SHOW TABLES;


#3.将表departments中的数据插入新表dept02中
CREATE TABLE dept02
AS 
SELECT *
FROM atguigudb.`departments`;


SELECT * 
FROM dept02;
SHOW TABLES;


-- 创建表emp01
CREATE TABLE emp01(
id INT(7),
first_name VARCHAR(25),
last_name VARCHAR(25),
dept_id INT(7)
);

DESC emp01;

#5.将列last_name的长度增加到50
ALTER TABLE emp01
MODIFY last_name VARCHAR(50);

#6.根据表employees创建emp02
CREATE TABLE emp02
AS 
SELECT *
FROM
atguigudb.`employees`;

SELECT *
FROM emp02;

SHOW TABLES FROM test01_office;


#8.将表emp02重命名为emp01
RENAME TABLE emp02 TO emp01;


#9.在表dept02和emp01中添加新列test_column，并检查所作的操作

ALTER TABLE emp01 ADD test_column VARCHAR(20);

DESC emp01;

ALTER TABLE emp02 ADD test_column VARCHAR(20);

DESC emp02;

#10.直接删除表emp02中的列 department_id

ALTER TABLE emp02
DROP COLUMN department_id;

DESC emp02;

# 2、创建数据表 customers
CREATE TABLE IF NOT EXISTS customers(
c_num INT,
c_name VARCHAR(50),
c_contact VARCHAR(50),
c_city VARCHAR(50),
c_birth DATE
);


SHOW TABLES;


# 3、将 c_contact 字段移动到 c_birth 字段后面

DESC customers;
ALTER TABLE customers 
MODIFY c_contact VARCHAR(50 AFTER c_birth;


# 5、将c_contact字段改名为c_phone

ALTER TABLE customers
CHANGE c_contact c_phone VARCHAR(20);


# 6、增加c_gender字段到c_name后面，数据类型为char(1)
ALTER TABLE customers
ADD c_gender CHAR(1) AFTER c_name;

DESC customers;


# 7、将表名改为customers_info
RENAME TABLE customers
TO customers_info;

SHOW TABLES;

# 8、删除字段c_city
ALTER TABLE customers_info
DROP COLUMN c_city;

DESC customers_info;






























