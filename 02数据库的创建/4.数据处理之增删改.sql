--  数据处理增删改
USE atguigudb;

CREATE TABLE IF NOT EXISTS emp1(
id INT,
`name` VARCHAR(19),
hire_date DATE,
salary DOUBLE(10,2)
)

DESC emp1;

SELECT * FROM emp1;

-- 添加一条数据原则是按照声明的字段顺序进行添加 不然会发生错误
INSERT INTO emp1
VALUE(1,'Tom','2009-10-23',9000);

SELECT * FROM emp1;

-- 指明要添加的字段
INSERT INTO emp1(id,`name`,salary)
VALUES
(2,'jim',8000),
(3,'andy',7000);
SELECT * FROM emp1;

-- 将查询加过添加到表格中 tip:查询添加的内容的字段的长度一定
-- 只可以小于等于插入的目标的表的字段 不然就会有添加不成功的风险
INSERT INTO emp1(id,`name`,salary,hire_date)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE department_id IN(60,70);

SELECT * FROM emp1;
DESC emp1;
DESC employees;



-- 修改更新数据update   set   where
UPDATE emp1
SET hire_date=CURDATE()
WHERE id=3;

SELECT * FROM emp1;

-- 同时修改多条数据
UPDATE emp1
SET hire_date=CURDATE(),salary=7800
WHERE id=103;

SELECT * FROM emp1;

-- 将表格中名字包含a的人的工资增加20%
UPDATE emp1
SET salary=salary*1.2
WHERE `name` LIKE '%a%';

SELECT * FROM emp1;


-- 3删除数据delete    from  where
DELETE FROM emp1
WHERE id=1;

SELECT * FROM emp1;

-- 删除的时候会由于约束的影响存在删除不成功的时候
-- DML在操作默认的情况下都是执行完之后自动的提交数据的 假如希望执行之后不提交的话 就要设置 set autocommit=false

-- 4.sql8.0的新特性
-- 1.计算列
USE mytest03;
SHOW TABLES;

CREATE TABLE test01(
a INT,
b INT,
c INT GENERATED ALWAYS AS (a+b) virtual
);


INSERT INTO test01(a,b)
VALUE(10,20);

SELECT * FROM test01;

UPDATE test01
SET a=100;

-- 5.综合案例
CREATE DATABASE IF NOT EXISTS test_library CHARACTER SET 'utf8';

USE test_library;

-- 创建book表
CREATE TABLE IF NOT EXISTS books(
id INT,
`name` VARCHAR(50),
`authors` VARCHAR(100),
price FLOAT,
pubdate YEAR,
note VARCHAR(100),
num INT
);


SELECT * FROM books;
-- 1.向books表中插入数据 不指定字段的名称
INSERT INTO books
VALUE
(1,'tom','andy',22,'1990','novel',3);

-- 2.指定字段的名称插入
INSERT INTO books(id,`name`,`authors`,price,`pubdate`,note,`num`)
VALUE(2,'EmmaT','Jane lura',35,'1993','joke',22);


-- 3.指定的多行的插入
INSERT INTO books(id,`name`,`authors`,price,`pubdate`,note,`num`)
VALUES
(3,'Story of Jane','Jane Tim',40,2001,'novel',0),
(4,'Lovey Day','George Byron',20,2005,'novel',30),
(5,'Old land','Honore Blade',30,2010,'Law',0),
(6,'The Battle','Upton Sara',30,1999,'medicine',40),
(7,'Rose Hood','Richard haggard',28,2008,'cartoon',28);

SELECT * FROM books;

-- 4.将小说的类型的书本的价格涨价5
UPDATE books
SET price=price+5
WHERE note='novel';

-- 5将名称是EmmaT的书的价格改为40 并且类型换位drama
UPDATE books
SET price=40,note='drama'
WHERE `name`='EmmaT';

SELECT * FROM books;


-- 6删除库存为0的书
DELETE FROM books
WHERE num=0;


-- 统计书名中包含a字母的书
SELECT `name`
FROM books
WHERE `name` LIKE '%a%';

# 8、统计书名中包含a字母的书的数量和库存总量
SELECT COUNT(*),SUM(num)
FROM books
WHERE NAME LIKE '%a%';

# 9、找出“novel”类型的书，按照价格降序排列
SELECT NAME ,note,price
FROM books 
WHERE note='novel'
ORDER BY price DESC;

# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT * FROM books
ORDER BY num DESC,note ASC;

# 11、按照note分类统计书的数量
SELECT note,COUNT(*)
FROM books
GROUP BY note;

-- 12、按照note分类统计书的库存量，显示库存量超过30本的
SELECT note,COUNT(*)
FROM books
GROUP BY note
HAVING SUM(num)>30;

# 13、查询所有图书，每页显示5本，显示第二页
SELECT * 
FROM books
LIMIT 5,5;

# 14、按照note分类统计书的库存量，显示库存量最多的
SELECT note,SUM(num) sum_num
FROM books
GROUP BY note
ORDER BY sum_num DESC
LIMIT 0,1;


-- 15、查询书名达到8个字符的书，不包括里面的空格
SELECT CHAR_LENGTH(REPLACE(NAME,' ',''))
FROM books; 

SELECT NAME
FROM books
WHERE CHAR_LENGTH(REPLACE(NAME,' ',''))>=8;

# 16、查询书名和类型，其中note值为novel显示小说，law显示法律，medicine显示医药，
#cartoon显示卡通，joke显示笑话
SELECT `name`,CASE note
		WHEN 'novel' THEN '小说'
		WHEN  'law'  THEN  '法律'
		WHEN  'medicine' THEN '医药'
		WHEN 'cartoon' THEN '笑话'
		ELSE '其他'
		END '类型'
FROM books;


SELECT * FROM books;
# 17、查询书名、库存，其中num值超过30本的，显示滞销，大于0并低于10的，
#显示畅销，为0的显示需要无货
SELECT `name` AS '书名',num AS '库存',CASE 
		WHEN num>30 THEN '滞销'
		WHEN  num>0 AND num<10 THEN  '畅销'
		WHEN  num=0 THEN '无货'
		ELSE '正常'
		END '显示状态'
FROM books;


# 18、统计每一种note的库存量，并合计总量
SELECT IFNULL(note,'合计库存总量') AS note,SUM(num)
FROM books
GROUP BY note WITH ROLLUP;

# 20、统计库存量前三名的图书
SELECT * 
FROM books
ORDER BY num DESC
LIMIT 0,3;

# 21、找出最早出版的一本书
SELECT * 
FROM books
ORDER BY pubdate ASC
LIMIT 0,1;


# 22、找出novel中价格最高的一本书
SELECT * 
FROM books
WHERE note='novel'
ORDER BY price DESC
LIMIT 0,1;


# 23、找出书名中字数最多的一本书，不含空格

SELECT * 
FROM books
ORDER BY CHAR_LENGTH(REPLACE(NAME,' ','')) DESC
LIMIT 0,1;


SELECT * FROM books;












































































