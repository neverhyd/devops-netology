# Домашнее задание к занятию "6.3. MySQL"

## Задача 1


Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.
```
mysql> \s
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)
```

**Приведите в ответе** количество записей с `price` > 300.
```
mysql> select count(*) from orders where price>300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.02 sec)
```


## Задача 2

```
create user test IDENTIFIED WITH mysql_native_password BY 'test-pass' WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 ATTRIBUTE '{"fname": "James", "lname": "Pretty"}';
grant select on test_db.* to test;
select * from INFORMATION_SCHEMA.USER_ATTRIBUTES where user='test';
+------+------+---------------------------------------+
| USER | HOST | ATTRIBUTE                             |
+------+------+---------------------------------------+
| test | %    | {"fname": "James", "lname": "Pretty"} |
+------+------+---------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
```
SELECT ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db';
+--------+
| ENGINE |
+--------+
| InnoDB |
+--------+
1 row in set (0.01 sec)
```

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`
```
 ALTER TABLE orders ENGINE=myisam;
Query OK, 5 rows affected (0.16 sec)
Records: 5  Duplicates: 0  Warnings: 0

 ALTER TABLE orders ENGINE=innodb;
Query OK, 5 rows affected (0.08 sec)
Records: 5  Duplicates: 0  Warnings: 0
```

## Задача 4 

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

innodb_buffer_pool_size = 300M
nnodb_log_file_size = 100M
innodb_flush_method = O_DSYNC
nnodb_flush_log_at_trx_commit = 2
innodb_log_buffer_size=1
innodb_file_per_table = ON

# Custom config should go here
!includedir /etc/mysql/conf.d/
```
