```
Slave_IO_Running:No
方法1：重置slave
stop slave;
reset slave;
start slave;
方法二重设同步日志及位置
1、查看slave状态
show slave status\G
Relay_Log_Pos: 7459732
Relay_Master_Log_File: mysql-bin.000002
2、暂停slave
stop slave;
3、修改同步日志文件及位置
change master to master_log_file='mysql-bin.000002',master_log_pos=1;
4、启动slave
start slave;
5、确认slave状态
show slave status \G;
```
```
Slave_SQL_Running:No
方法一：忽略错误后继续同步
stop slave;
#表示跳过1步错误，后面数字可变
set global sql_slave_skip_counter=1;
start slave;
show slave status \G;
方式二：跳过指定错误代码，继续同步
主键冲突、表已存在等错误代码如1062、1032、1060等
修改my.cnf
[mysqld]
slave-skip-errors=1062,1032,1060
重启mysql
show slave status \G;
方式三：重新做主从，完全同步
1、进入主库，进行锁表
flush tables with read lock;
#锁定为只读状态
2、数据备份
mysqldump -uroot -p -数据库 > mysql.bak.sql
#mysqldump -uroot -pRU#@xcN1NGSp --lock-all-tables --flush-logs  -etcmj > mysql.bak.sql
unlock tables;
--routines:导出存储过程和函数
--single_transaction:导出开始时设置事务隔离状态，并使用一致性快照开始事务，然后unlocak tables;而lock-tabless是锁住一张表不能写操作，直到dump完毕。
--master-data：默认等于1，将dump起始(change master to)binlog点和pos值写到结果中，等于2是将change master to 写到结果中并注释
3、chakan master状态
show master status;
4、备份从库恢复
stop slave;
reset slave;
#create database 库;
#mysql -uroot -p 库 < mysql.bak.sql
mysql> source /tmp/mysql.bak.sql
5、设置从库同步
show master status \G;
查看binlog和pos值
head -25 mysql.bak.sql 大概22行左右
change master to master_host='IP',master_user='用户',master_port=3306,master_password='',master_log_file='mysql-bin.000001',master_log_pos=3260;
6、重启从同步
start slave;
7、查看同步状态
show slave status \G;
```