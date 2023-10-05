-- 如何cmd控制面板打开mysql
-- 1.复制mysqlserver到bin位置的文件目录到cmd中： cd 路径名跳转到mysql的路径位置
-- 2.之后就是输入mysql -u root -p 
-- 跟着提示输入密码即可


#1.sql的分类：
#1.1 DDL数据定义语言 create/alter/drop就是创建不同的对象
#1.2 DML数据操作语言 insert/delete 就是对创建出来的对象的数据进行增删改查等操作
#1.3 DCL数据控制语言 commit、rollback 就是对总体的数据的控制


#数据的导入 方法有两种：
#1、source 文件的路径    仅限于在命令行中使用
#2. 工具-执行sql脚本-选择目标的脚本即可