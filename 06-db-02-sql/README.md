# Домашнее задание к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```
version: "3"
services:
  postgres:
    image: postgres:latest
    restart: always
    environment:
      POSTGRES_DB: ""
      POSTGRES_USER: "admin"
      POSTGRES_PASSWORD: "admin"
    ports:
      - "5432:5432"
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/backup
```

## Задача 2

- итоговый список БД после выполнения пунктов выше,
```
test_db=# \l
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges
-----------+-------+----------+------------+------------+-------------------
 admin     | admin | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | admin | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | admin | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin         +
           |       |          |            |            | admin=CTc/admin
 template1 | admin | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin         +
           |       |          |            |            | admin=CTc/admin
 test_db   | admin | UTF8     | en_US.utf8 | en_US.utf8 |
(5 rows)
```
- описание таблиц (describe)
```
CREATE TABLE public.clients (
	id serial4 NOT NULL,
	фамилия varchar NULL,
	страна_проживания varchar NULL,
	заказ int4 NULL,
	CONSTRAINT clients_pkey PRIMARY KEY (id),
	CONSTRAINT clients_заказ_fkey FOREIGN KEY (заказ) REFERENCES public.orders(id)
);
CREATE INDEX "idx_страна_проживания" ON public.clients USING btree ("страна_проживания");

CREATE TABLE public.orders (
	id serial4 NOT NULL,
	наименование varchar NULL,
	цена int4 NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (id)
);
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
SELECT table_catalog, table_schema, table_name, privilege_type FROM information_schema.table_privileges WHERE grantee = 'test_simple_user';
```
- список пользователей с правами над таблицами test_db
```
test_db=# SELECT * FROM information_schema.table_privileges where table_name = 'orders' or table_name = 'clients';
 grantor |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
---------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 admin   | admin            | test_db       | public       | orders     | INSERT         | YES          | NO
 admin   | admin            | test_db       | public       | orders     | SELECT         | YES          | YES
 admin   | admin            | test_db       | public       | orders     | UPDATE         | YES          | NO
 admin   | admin            | test_db       | public       | orders     | DELETE         | YES          | NO
 admin   | admin            | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 admin   | admin            | test_db       | public       | orders     | REFERENCES     | YES          | NO
 admin   | admin            | test_db       | public       | orders     | TRIGGER        | YES          | NO
 admin   | test_simple_user | test_db       | public       | orders     | INSERT         | NO           | NO
 admin   | test_simple_user | test_db       | public       | orders     | SELECT         | NO           | YES
 admin   | test_simple_user | test_db       | public       | orders     | UPDATE         | NO           | NO
 admin   | test_simple_user | test_db       | public       | orders     | DELETE         | NO           | NO
 admin   | admin            | test_db       | public       | clients    | INSERT         | YES          | NO
 admin   | admin            | test_db       | public       | clients    | SELECT         | YES          | YES
 admin   | admin            | test_db       | public       | clients    | UPDATE         | YES          | NO
 admin   | admin            | test_db       | public       | clients    | DELETE         | YES          | NO
 admin   | admin            | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 admin   | admin            | test_db       | public       | clients    | REFERENCES     | YES          | NO
 admin   | admin            | test_db       | public       | clients    | TRIGGER        | YES          | NO
 admin   | test_simple_user | test_db       | public       | clients    | INSERT         | NO           | NO
 admin   | test_simple_user | test_db       | public       | clients    | SELECT         | NO           | YES
 admin   | test_simple_user | test_db       | public       | clients    | UPDATE         | NO           | NO
 admin   | test_simple_user | test_db       | public       | clients    | DELETE         | NO           | NO
(22 rows)
```

## Задача 3

Таблица orders
```
insert into orders (наименование, цена) values ('Шоколад', 10); 
insert into orders (наименование, цена) values ('Принтер', 3000);
insert into orders (наименование, цена) values ('Книга', 500); 
insert into orders (наименование, цена) values ('Монитор', 7000);
insert into orders (наименование, цена) values ('Гитара', 4000);
```

Таблица clients

```
insert into clients (фамилия , страна_проживания) values ('Иванов Иван Иванович', 'USA');
insert into clients (фамилия , страна_проживания) values ('Петров Петр Петрович', 'Canada');
insert into clients (фамилия , страна_проживания) values ('Иоганн Себастьян Бах', 'Japan');
insert into clients (фамилия , страна_проживания) values ('Ронни Джеймс Дио', 'Russia');
insert into clients (фамилия , страна_проживания) values ('Ritchie Blackmore', 'Russia');
```

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
```
select count(*) from orders 

5
```

```
select count(*) from clients  

5
```

## Задача 4

Приведите SQL-запросы для выполнения данных операций.
```
update clients set заказ = (select id from orders where наименование = 'Книга') where фамилия = 'Иванов Иван Иванович';
update clients set заказ = (select id from orders where наименование = 'Монитор') where фамилия = 'Петров Петр Петрович';
update clients set заказ = (select id from orders where наименование = 'Гитара') where фамилия = 'Иоганн Себастьян Бах';
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
```
select фамилия from clients where заказ notnull;
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
```
Seq Scan on clients  (cost=0.00..18.10 rows=806 width=32)
  Filter: ("заказ" IS NOT NULL)
```
Планировщик выбрал план простого последовательного сканирования, далее идет приблизтельное время запуска до вывода данных, ожидаемое число строк, ожидаемый средний размер строки.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```
pg_dump -U admin test_db > /backup/test_db.bkp
```

Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
docker-compose stop
```

Поднимите новый пустой контейнер с PostgreSQL.
```
 docker run --name pg -e POSTGRES_PASSWORD=admin -d -p 5432:5432 --rm -v /root/newdb-data:/var/lib/postgresql/data -v /root/backup:/backup postgres
```

Восстановите БД test_db в новом контейнере.
```
docker exec -it pg bash
psql -Upostgres
create database test_db OWNER 'postgres' ENCODING 'UTF8';
exit
psql -Upostgres test_db < /backup/test_db.bkp
```