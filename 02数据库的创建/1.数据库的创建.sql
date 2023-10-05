SELECT *
FROM `order`;

-- 创建数据库 
-- 1.直接创建
CREATE DATABASE myTest01;

-- 2.创建的时候制定要使用的字符集
CREATE DATABASE myTest02 CHARACTER SET 'utf8';

-- 3.创建的时候指定字符集 并且重复的创建存在的表创建失败 并且不会报错
CREATE DATABASE IF NOT EXISTS myTest03 CHARACTER SET 'gbk';

-- 查看当前的连接中的数据库有哪一些
SHOW DATABASES;

-- 切换数据库
USE myTest01;

-- 查看当前的数据库中都保存哪些数据表
USE atguigudb;

SHOW TABLES;

-- 查看当前使用的数据库
SELECT DATABASE() FROM DUAL;

-- 查看指定的数据库中有哪些表
SHOW TABLES FROM atguigudb;



-- 数据库的修改

-- 修改数据库的字符集
SHOW CREATE DATABASE myTest02;

ALTER DATABASE myTest02 CHARACTER SET 'gbk';


-- 删除库

DROP DATABASE myTest01;
-- 重复删除会报错
SHOW DATABASES;
-- 推荐使用下面的这个不会报错
DROP DATABASE IF EXISTS myTest02;































