-- 单行函数：操作数据对象
-- 接受参数返回一个结果
-- 只对一行进行变换
-- 每行返回一个结果
-- 可以嵌套
-- 参数可以是一列或一个值


-- 1.数值函数SIGN(X) 返回X的符号。正数返回1，负数返回-1，0返回0 floor就是以0作为地板向下拉
SELECT
ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),
FLOOR(-43.23),MOD(12,5)
FROM DUAL;

-- 2。随机数函数 不带参数随机返回一个小数 带参数就是有一个种子 参数相同的情况下 返回的随机数是一样的
SELECT RAND(),RAND(),RAND(10),RAND(10),RAND(-1),RAND(-1)
FROM DUAL;


-- 3.四舍五入round 第二个参数正数表示从小数才是舍入 为负数的时候表示正数位数开始舍 . 截断truncate
SELECT
ROUND(12.33),ROUND(12.343,2),ROUND(12.324,-1),TRUNCATE(12.66,1),TRUNCATE(12.66,-1)
FROM DUAL;


-- 4.嵌套
SELECT
ROUND(12.33),ROUND(ROUND(12.33),2),ROUND(12.324,-1),TRUNCATE(12.66,1),TRUNCATE(ROUND(12.33),-1)
FROM DUAL;


-- 5.三角函数
-- RADIANS(x) 将角度转化为弧度，其中，参数x为角度值
-- DEGREES(x) 将弧度转化为角度，其中，参数x为弧度值
SELECT RADIANS(30),RADIANS(60),RADIANS(90),DEGREES(2*PI()),DEGREES(RADIANS(90))
FROM DUAL;

SELECT
SIN(RADIANS(30)),DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1)),DEGREES(ATAN2(1,1))
FROM DUAL;

-- 6.指数与对数LN表示的是以e为底exp(n):表示的是返回e的n次方
SELECT POW(2,5),POWER(2,4),EXP(2),LN(10),LOG10(10),LOG2(4)
FROM DUAL;

-- 7.进制之间的转换分别是 二 十六 八进制 conv表示将10从2进制转化为8进制
SELECT BIN(10),HEX(10),OCT(10),CONV(110,2,8)
FROM DUAL;


-- 8.字符串函数
SELECT ASCII('懒洋洋'),CHAR_LENGTH('holle'),LENGTH('hello'),
CONCAT('you and','me'),CONCAT_WS('*','you','and','me'),INSERT('hello',1,2,'xx'),
FROM DUAL;


SELECT REPLACE('hello','l','*'),UPPER('aaaaa'),LOWER('AAAAbbbBBB'),UCASE('AAAAbbbBBB'),LCASE('AAAAbbbBBB'),LEFT('123345',3),RIGHT('1234567',3)
FROM DUAL;


SELECT LPAD('you',6,'*'),RPAD('you',6,'-'),LTRIM('      hahahah      '),RTRIM('      hahahah      '),TRIM('     hahahah   hahha   hahha   ')
FROM DUAL;



-- 9.时间函数

-- 返回当前的年月日
SELECT CURDATE(),CURTIME(),NOW(),UTC_DATE(),UTC_TIME()
FROM DUAL;


-- 日期与时间戳的转换以unix的形式返回当前的时间
SELECT UNIX_TIMESTAMP(),FROM_UNIXTIME(UNIX_TIMESTAMP()),UNIX_TIMESTAMP(CURTIME())
FROM DUAL;

SELECT YEAR(NOW()),MONTH(NOW()),DAY(NOW()),HOUR(NOW()),MINUTE(NOW()),MONTHNAME(NOW()),DAYNAME(NOW()),WEEKDAY(NOW()),QUARTER(NOW()),DAYOFMONTH(NOW()),DAYOFMONTH(NOW()),DAYOFWEEK(NOW())
FROM DUAL;

-- 计算时间与日期函数
SELECT ADDDATE('2021-10-21 23:32:12',INTERVAL 1 SECOND) AS col3,
DATE_ADD('2021-10-21 23:32:12',INTERVAL '1_1' MINUTE_SECOND) AS col4,
DATE_ADD(NOW(), INTERVAL -1 YEAR) AS col5, #可以是负数
DATE_ADD(NOW(), INTERVAL '1_1' YEAR_MONTH) AS col6 #需要单引号
FROM DUAL;


SELECT DATE_SUB('2021-01-21',INTERVAL 31 DAY) AS col1,
SUBDATE('2021-01-21',INTERVAL 31 DAY) AS col2,
DATE_SUB('2021-01-21 02:01:01',INTERVAL '1 1' DAY_HOUR) AS col3
FROM DUAL


SELECT
ADDTIME(NOW(),20),SUBTIME(NOW(),30),SUBTIME(NOW(),'1:1:3'),DATEDIFF(NOW(),'2021-10-
01'),
TIMEDIFF(NOW(),'2021-10-25 22:10:10'),FROM_DAYS(366),TO_DAYS('0000-12-25'),
LAST_DAY(NOW()),MAKEDATE(YEAR(NOW()),12),MAKETIME(10,21,23),PERIOD_ADD(20200101010101,
10)
FROM DUAL;


-- 时间的格式化
SELECT STR_TO_DATE('09/01/2009','%m/%d/%Y')
FROM DUAL;

SELECT STR_TO_DATE('20140422154706','%Y%m%d%H%i%s')
FROM DUAL;

SELECT STR_TO_DATE('2014-04-22 15:47:06','%Y-%m-%d %H:%i:%s')
FROM DUAL;

SELECT DATE_FORMAT(NOW(),GET_FORMAT(DATE,'USA'))
FROM DUAL;


-- 流程控制控制函数
-- 类似于三目运算符
SELECT last_name,salary,IF(salary>8000,'高薪','低薪') 'detailsofsalary'
FROM employees;

SELECT last_name,commission_pct,IF(commission_pct IS NOT NULL,commission_pct,0) 'detailsofcommission_pct'
FROM employees;



SELECT last_name,commission_pct,IFNULL(commission_pct,0)'detailsofcommission_pct'
FROM employees
ORDER BY detailsofcommission_pct DESC;

-- case when then 不加参数
SELECT last_name,salary,CASE 
WHEN salary>=15000 THEN 'talent'
WHEN salary>=10000 THEN 'lucky'
WHEN salary>=8000 THEN 'good'
ELSE 'study' END 'details'
FROM employees
ORDER BY salary DESC;

-- case when then加上参数
-- case when then 不加参数
SELECT last_name,salary,department_id,CASE department_id
WHEN salary>=15000 THEN 'talent'
WHEN salary>=10000 THEN 'lucky'
WHEN salary>=8000 THEN 'good'
ELSE 'study' END 'details'
FROM employees
ORDER BY salary DESC;


SELECT last_name,salary,department_id,
CASE department_id
WHEN salary>=15000 THEN 'talent'
WHEN salary>=10000 THEN 'lucky'
WHEN salary>=8000 THEN 'good'
ELSE 'study' END 'details'
FROM employees
WHERE department_id IN(10,90,100)
ORDER BY salary DESC;


-- 加密与解密函数
SELECT MD5('thisismypossaord'),SHA('thisismydecondpossword')
FROM DUAL;

-- 解密函数
SELECT 
FROM DUAL;

-- 信息函数
SELECT VERSION(),CONNECTION_ID(),DATABASE(),SCHEMA(),
USER(),CURRENT_USER(),CHARSET('懒洋洋'),COLLATION('懒洋洋')
FROM DUAL;


-- 练习
-- 1.显示系统的时间
SELECT NOW(),CURDATE(),CURTIME()
FROM DUAL;

-- 2.将员工的姓名按照首字母排序 并且写出姓名的长度
SELECT last_name,LENGTH(last_name) 'len_ofname'
FROM employees
ORDER BY len_ofname ASC;

-- 3.查询员工的id name salary 作为一输出
SELECT last_name,salary,CONCAT(last_name,'-',employee_id,'-',salary) 'output'
FROM employees;

-- 4.查询公司的员工的工作的年数天数并按照年数进行排序
SELECT employee_id,last_name,hire_date,DATEDIFF(CURDATE(),hire_date)/365 'workyear',DATEDIFF(CURDATE(),hire_date) 'workday'
FROM employees
ORDER BY 'workday' ASC;

-- # 6.查询员工姓名，hire_date , department_id，满足以下条件：雇用时间在1997年之后，department_id
-- 为80 或 90 或110, commission_pct不为空
SELECT last_name,hire_date,department_id,commission_pct
FROM employees
WHERE department_id IN (80,90,110)
AND commission_pct IS NOT NULL
AND hire_date>=STR_TO_DATE('1997-01-01','%Y-%m-%d') 
ORDER BY hire_date;

-- 7查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name,hire_date
FROM employees
WHERE DATEDIFF(CURDATE(),hire_date)>=10000;
























