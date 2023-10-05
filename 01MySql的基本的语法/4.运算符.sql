-- 2.运算符 加减乘除 取模 左移右移 与或非运算
USE atguigudb;
-- sql里面+没有拼接字符串的作用 字符串里面假如是数字 会有隐式转换为相加 
-- 假如字符串非数字 就会返回结果是0 null参与运算的结果就是null
-- 在sql里面假如一个数除以0其结果就是null
-- 取模运算的结果的正负号 是和被模数的一致的

SELECT 100+'1',100+'a',100+NULL,100 DIV 0,125%-2,-125%-2,125%2
FROM DUAL;


-- 比较运算符： >=,<= ,= ,== ,!=,  安全等于：<=>  假如运算符的两边都是一个字符串 
-- 就会更具ascll码值进行转换为数值之后在进行比较 只要null参与判断就会返回null
SELECT 1=2,1>2,1<2,1!=2,1='1',1='a','a'='a','a'='a','ab'='a','a'>='b','a'<'b',NULL=NULL,1>=NULL
FROM DUAL;

-- null参与运算不会任何结果 因为会一直返回null
SELECT department_id,last_name
FROM employees
WHERE commission_pct=NULL;

-- <=>安全等于:可以对null进行判断
SELECT 1<=>2,1<=>1,1<=>NULL,NULL<=>NULL
FROM DUAL;

-- null参与运算不会任何结果 因为会一直返回null 但是<=>安全等于可以参与运算
SELECT department_id,last_name,commission_pct
FROM employees
WHERE commission_pct<=>NULL;

-- 对于null参与运算有下面的几种语句可以实现 is null/is not null/ isnull:这种是偏函数的写法

SELECT department_id,last_name,commission_pct
FROM employees
WHERE commission_pct IS NULL;

SELECT department_id,last_name,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;


SELECT department_id,last_name,commission_pct
FROM employees
WHERE ISNULL(commission_pct);


-- 最小值 最大值least(),greatest()
SELECT LEAST(1,'q',2,3,4,5),LEAST('a','b'),LEAST(1,2,3,6,8,9,4),GREATEST('q',2,3,4,'s'),GREATEST('a','b'),GREATEST(1,2,3,4,2,1,5,6,9)
FROM DUAL;

-- 查 （between 下界 and 上界）询区间是包含边界值的
SELECT employee_id,last_name,salary 
FROM employees
WHERE salary BETWEEN 6000 AND 8000;

-- 上面也可以写为：
SELECT employee_id,last_name,salary 
FROM employees
WHERE salary>=6000 && salary<=8000;

-- 不在特定范围的也可写为
SELECT employee_id,last_name,salary 
FROM employees
WHERE salary NOT BETWEEN 6000 AND 8000;

SELECT employee_id,last_name,salary 
FROM employees
WHERE salary<6000 OR salary>8000;


-- in(set)/not in (set)
-- 查询部门的id在10 20 30 的员工
SELECT last_name,department_id
FROM employees
WHERE department_id IN (10,20,30);


SELECT last_name,department_id
FROM employees
WHERE department_id NOT IN (10,20,30);
 
-- like模糊查询  %代表的是不确定的个数字符
-- 查询员工名字包含'a'字符的员工
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE '%a%';


-- 查询员工的信息中以字符a开头的信息
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE 'a%';

-- 查询员工的信息中以字符a结尾的信息
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE '%a';


-- 查询员工的信息中包含a并且包含e字符的信息
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE '%a%' && last_name LIKE '%e%';

-- 还可以写为：
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

-- 查询第二个字符是a的 一个'_'代表一个占位符
SELECT last_name,department_id
FROM employees
WHERE last_name LIKE '_a%';

-- 正则表达式regexp: ^tem:表示以^tem开头的 tem$ 表示以tem结尾的  [abc]只有匹配其中任意的一个字符即可

-- 以a开头的员工的
SELECT last_name,department_id
FROM employees
WHERE last_name REGEXP '^a';


-- 以e结尾的员工的名称

SELECT last_name,department_id
FROM employees
WHERE last_name REGEXP 'e$';

-- 匹配名字包含xvw都可以的员工
SELECT last_name,department_id
FROM employees
WHERE last_name REGEXP '[xvw]';


-- 逻辑运算符 or(||) and(&&) not(!)  xor(异或)相同为0 不同为1  and优先级高于or









