### Задача 1
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

```shell
mfonarev@zxc-book:~$ docker run --name mysql8 -e MYSQL_ROOT_PASSWORD=pwd123 -d -v volume3:/var/lib/mysql mysql:8
01150be592a7924c9dc72cd3a6c86b43ea22112acf67b028cc2bdbb465470752
mfonarev@zxc-book:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                 NAMES
01150be592a7   mysql:8   "docker-entrypoint.s…"   13 seconds ago   Up 12 seconds   3306/tcp, 33060/tcp   mysql8
```
Изучите бэкап БД и восстановитесь из него.

Создал новую базу test_dump и в нее залил бекап
```shell
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| test_dump          |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

Перейдите в управляющую консоль mysql внутри контейнера.
Используя команду \h получите список управляющих команд.
```shell
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'
```

Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

```shell
mysql> \r from_dump
Connection id:    13
Current database: from_dump

mysql> \s
--------------
mysql  Ver 8.0.31 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		13
Current database:	from_dump
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.31 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			25 min 6 sec

Threads: 2  Questions: 20  Slow queries: 0  Opens: 159  Flush tables: 3  Open tables: 78  Queries per second avg: 0.013
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```shell
mysql> use test_dump;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+---------------------+
| Tables_in_test_dump |
+---------------------+
| orders              |
+---------------------+
1 row in set (0.00 sec)
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.
Приведите в ответе количество записей с price > 300.

```shell
mysql> show tables;
+---------------------+
| Tables_in_test_dump |
+---------------------+
| orders              |
+---------------------+
1 row in set (0.00 sec)
mysql> SELECT * FROM orders WHERE price > 300 ;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.01 sec)
```

---
### Задача 2
Создайте пользователя test в БД c паролем test-pass, используя:\
плагин авторизации mysql_native_password\
срок истечения пароля - 180 дней\
количество попыток авторизации - 3\
максимальное количество запросов в час - 100\
аттрибуты пользователя:\
Фамилия "Pretty"\
Имя "James"
```shell
mysql> CREATE USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass' WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
Query OK, 0 rows affected (0.04 sec)
mysql> ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
```

Предоставьте привелегии пользователю test на операции SELECT базы test_db
```shell
mysql> GRANT select ON test_dump.orders TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.02 sec)
```

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по
пользователю test и приведите в ответе к задаче.

```shell
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```

---

### Задача 3
Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Движок InnoDB 
```shell
mysql> show table status;
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2022-11-26 14:38:28 | 2022-11-26 14:38:28 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+------
```

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

на MyISAM
на InnoDB
```shell
mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> show profiles;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.00031475 | SET profiling = 1                  |
|        2 | 0.01726075 | show table status                  |
|        3 | 0.05529600 | ALTER TABLE orders ENGINE = MyISAM |
|        4 | 0.05561025 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
4 rows in set, 1 warning (0.00 sec)
```

---

### Задача 4

Часть конфига, который был добавлен согласно ТЗ с пояснением
``
innodb_flush_log_at_trx_commit = 0 - максимальная скорость
innodb_file_format=Barracuda - компрессия
innodb_log_buffer_size	= 1M - Размер буффера с незакомиченными транзакциями 1 Мб
key_buffer_size = 4500М 
max_binlog_size	= 100M
``