# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1
**Найдите и приведите** управляющие команды для:
- вывода списка БД
```
\l[+]   [PATTERN]      list databases
```
- подключения к БД
```
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
```
- вывода списка таблиц
```
\dt[S+] [PATTERN]      list tables
```
- вывода описания содержимого таблиц
```
\d[S+]  NAME           describe table, view, sequence, or index
```
- выхода из psql
```
\q                     quit psql
```

## Задача 2

```
select max(avg_width) from pg_stats where tablename='orders';
```

## Задача 3

```
test_database=# create table orders_1 ( check ( price > 499)) inherits (orders);
CREATE TABLE
test_database=# create table orders_2 ( check ( price <= 499)) inherits (orders);
CREATE TABLE
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```
Да можно если при изначальном проектировании таблиц сделать ее секционированной.
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
root@97b167253311:/# pg_dump -U admin -d test_database
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```
ALTER TABLE public.orders ADD CONSTRAINT orders_un UNIQUE (title);
```
