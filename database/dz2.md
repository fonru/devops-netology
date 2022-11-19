# Задача 1
>Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.\
Приведите получившуюся команду или docker-compose манифест
```bash
root@ubuntu2204:/home/vagrant# docker volume create vol1
root@ubuntu2204:/home/vagrant# docker volume create vol2
root@ubuntu2204:/home/vagrant# docker volume ls
DRIVER    VOLUME NAME
local     vol1
local     vol2
~
root@ubuntu2204:/home/vagrant# docker run -d --name postgres -v volume1:/var/lib/postgresql -v volume2:/var/lib/postgresql/data -e POSTGRES_PASSWORD=pwd123 postgres:12
~
root@ubuntu2204:/home/vagrant# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS      NAMES
89702eee735b   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute   5432/tcp   postgres
```

---

# Задача 2
В БД из задачи 1:

> создайте пользователя test-admin-user и БД test_db
```postgres
  postgres=# CREATE USER "test-admin-user";
  postgres=# CREATE DATABASE test_db;
  ~
  ~
  postgres=# \l test_db
                              List of databases
  Name   |  Owner   | Encoding |  Collate   |   Ctype    | Access privileges
  ---------+----------+----------+------------+------------+-------------------
  test_db | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
  ~
  ~
  postgres=# \du test-admin-user
  List of roles
  Role name    | Attributes | Member of
  -----------------+------------+-----------
  test-admin-user |            | {}
  ~
  ~
  ```

> в БД test_db создайте таблицу orders и clients
```postgres
postgres=# \c test_db
CREATE TABLE orders (id SERIAL PRIMARY KEY, наименование VARCHAR NOT NULL, цена INT NOT NULL);
REATE TABLE clients (id SERIAL PRIMARY KEY, ФИО VARCHAR NOT NULL, "Страна проживания" VARCHAR NOT NULL, заказ INT REFERENCES orders (id));
test_db=# \dt+
                       List of relations
 Schema |  Name   | Type  |  Owner   |    Size    | Description 
--------+---------+-------+----------+------------+-------------
 public | clients | table | postgres | 8192 bytes | 
 public | orders  | table | postgres | 8192 bytes | 
```

> предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```postgres
test_db=# GRANT ALL PRIVILEGES ON orders, clients TO "test-admin-user";
```

> создайте пользователя test-simple-user
```postgres
test_db=# CREATE USER "test-simple-user";
```

> предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```postgres
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON orders, clients TO "test-simple-user";
```

Приведите:
> итоговый список БД после выполнения пунктов выше
```postgres
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
```

> описание таблиц (describe)
```postgres
test_db=# \dt+
                     List of relations
 Schema |  Name   | Type  |  Owner   | Size  | Description 
--------+---------+-------+----------+-------+-------------
 public | clients | table | postgres | 16 kB | 
 public | orders  | table | postgres | 16 kB | 
```


> SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
cписок пользователей с правами над таблицами test_db

```postgres
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON orders, clients TO "test-simple-user";
GRANT
test_db=# SELECT table_name,grantee,privilege_type 
FROM information_schema.table_privileges
WHERE table_schema NOT IN ('information_schema','pg_catalog');
 table_name |     grantee      | privilege_type 
------------+------------------+----------------
 orders     | postgres         | INSERT
 orders     | postgres         | SELECT
 orders     | postgres         | UPDATE
 orders     | postgres         | DELETE
 orders     | postgres         | TRUNCATE
 orders     | postgres         | REFERENCES
 orders     | postgres         | TRIGGER
 clients    | postgres         | INSERT
 clients    | postgres         | SELECT
 clients    | postgres         | UPDATE
 clients    | postgres         | DELETE
 clients    | postgres         | TRUNCATE
 clients    | postgres         | REFERENCES
 clients    | postgres         | TRIGGER
 orders     | test-admin-user  | INSERT
 orders     | test-admin-user  | SELECT
 orders     | test-admin-user  | UPDATE
 orders     | test-admin-user  | DELETE
 orders     | test-admin-user  | TRUNCATE
 orders     | test-admin-user  | REFERENCES
 orders     | test-admin-user  | TRIGGER
 clients    | test-admin-user  | INSERT
 clients    | test-admin-user  | SELECT
 clients    | test-admin-user  | UPDATE
 clients    | test-admin-user  | DELETE
 clients    | test-admin-user  | TRUNCATE
 clients    | test-admin-user  | REFERENCES
 clients    | test-admin-user  | TRIGGER
 orders     | test-simple-user | INSERT
 orders     | test-simple-user | SELECT
 orders     | test-simple-user | UPDATE
 orders     | test-simple-user | DELETE
 clients    | test-simple-user | INSERT
 clients    | test-simple-user | SELECT
 clients    | test-simple-user | UPDATE
 clients    | test-simple-user | DELETE
```

# Задача 3
> Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:
```postgres
test_db=# SELECT * FROM orders;
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000

test_db=# SELECT * FROM clients;
  1 | Иванов Иван Иванович | USA               |      
  2 | Петров Петр Петрович | Canada            |      
  3 | Иоганн Себастьян Бах | Japan             |      
  4 | Ронни Джеймс Дио     | Russia            |      
  5 | Ritchie Blackmore    | Russia            |      

test_db=# SELECT COUNT(*) FROM clients;
     5
  
test_db=# SELECT COUNT(*) FROM orders;
     5
```

```postgres
UPDATE clients
SET заказ = 3 
WHERE ФИО = 'Иванов Иван Иванович';

UPDATE clients
SET заказ = 4
WHERE ФИО = 'Петров Петр Петрович';

UPDATE clients
SET заказ = 5
WHERE ФИО = 'Иоганн Себастьян Бах';

test_db=# SELECT * FROM clients;
  4 | Ронни Джеймс Дио     | Russia            |      
  5 | Ritchie Blackmore    | Russia            |      
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5

# Задача 4
>Используя foreign keys свяжите записи из таблиц
```postgres
UPDATE clients
SET заказ = 3 
WHERE ФИО = 'Иванов Иван Иванович';

UPDATE clients
SET заказ = 4
WHERE ФИО = 'Петров Петр Петрович';

UPDATE clients
SET заказ = 5
WHERE ФИО = 'Иоганн Себастьян Бах';
```

>Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

```postgres
test_db=# SELECT * FROM clients WHERE заказ IS NOT NULL;
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
```
# Задача 5
>Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).\
Приведите получившийся результат и объясните что значат полученные значения.

```postgres
test_db=# EXPLAIN SELECT * FROM clients WHERE заказ IS NOT NULL;
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
```
cost=0.00 - Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных\

cost..458.00 - общая стоймость\

rows=806 - ожидаемое число строк, которое должно быть выведено\

width=72 - ожидаемый средний размер строк (в байтах)


# Задача 6
>Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```bash
root@89702eee735b:/#  pg_dump -U postgres test_db > /var/lib postgresql/data/test_db.dump
```

>Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```bash
root@ubuntu2204:/home/vagrant# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED       STATUS       PORTS      NAMES
89702eee735b   postgres:12   "docker-entrypoint.s…"   3 hours ago   Up 3 hours   5432/tcp   postgres
root@ubuntu2204:/home/vagrant# docker stop postgres
postgres
root@ubuntu2204:/home/vagrant# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

>Поднимите новый пустой контейнер с PostgreSQL.

```bash
root@ubuntu2204:/home/vagrant# docker run -d --name postgres2 -v volume2:/var/lib/postgresql/data -e POSTGRES_PASSWORD=pwd321 postgres:12
~
root@ubuntu2204:/home/vagrant# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS      NAMES
8c8685c491b2   postgres:12   "docker-entrypoint.s…"   35 seconds ago   Up 34 seconds   5432/tcp   postgres2
~
root@8c8685c491b2:/var/lib/postgresql/data# psql -U postgres
~

пришлось удалить базу, потому что volume сделал в data (но суть бекапа ясна)

postgres=# CREATE DATABASE test_db;

root@8c8685c491b2:/var/lib/postgresql/data# psql -U postgres test_db < /var/lib/postgresql/data/test_db.dump
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval 
--------
      5
(1 row)

 setval 
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
```
