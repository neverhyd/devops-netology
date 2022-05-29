# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```
FROM centos:7
EXPOSE 9200
RUN yum install wget -y
RUN yum install perl-Digest-SHA -y
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512
RUN shasum -a 512 -c elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
 tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN yum upgrade -y
RUN groupadd elasticsearch && useradd -g elasticsearch elasticsearch
ENV ES_JAVA_HOME=/elasticsearch-8.2.2/jdk
ADD elasticsearch.yml /elasticsearch-8.2.2/config/
RUN chown -R elasticsearch:elasticsearch /elasticsearch-8.2.2/
RUN chown -R elasticsearch:elasticsearch /var/lib/
USER elasticsearch
CMD [ "/elasticsearch-8.2.2/bin/elasticsearch" ]
```
- [ссылка на образ](https://hub.docker.com/layers/222489055/neverhyd/netology/latest/images/sha256-f41de785bfdbe0cead0aa95fe3f915c7828cc51653f727027217bc40d0233d90?context=repo)
- ответ `elasticsearch` на запрос пути `/` в json виде
```
curl -X GET 'http://localhost:9200/'
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "3Ob2hwbGTwGZJhnq3GmT0Q",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.
```
[elasticsearch@3c3ac99d61a8 /]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 caZa-I54QT2clBkKe3N9ZQ   1   0          0            0       225b           225b
yellow open   ind-2 hiCUNnfLRCS8hKMWy9kWJg   2   1          0            0       450b           450b
yellow open   ind-3 h4eT0vD6RZq2Z4bQuZtoGQ   4   2          0            0       900b           900b
```
```
[elasticsearch@3c3ac99d61a8 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
[elasticsearch@3c3ac99d61a8 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
[elasticsearch@3c3ac99d61a8 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```
Получите состояние кластера `elasticsearch`, используя API.
```
[elasticsearch@3c3ac99d61a8 /]$ curl -X GET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
```
Потомучто у индексов указано больше 1 реплики, а по факту их нет.
```
Удалите все индексы.
```
curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}
$ curl -X DELETE 'http://localhost:9200/ind-2?pretty'
{
  "acknowledged" : true
}
$ curl -X DELETE 'http://localhost:9200/ind-3?pretty'
{
  "acknowledged" : true
}
```

## Задача 3

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.
```
[elasticsearch@561e2f43c3e9 /]$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
> {
>   "type": "fs",
>   "settings": {
>     "location": "netology_backup"
>   }
> }
> '

{
  "acknowledged" : true
}
```
Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.
```
[elasticsearch@561e2f43c3e9 /]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  e1JKbu8PRruby92mZXhfOA   1   0          0            0       225b           225b
```
[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

```
[elasticsearch@561e2f43c3e9 /]$ ll /elasticsearch-8.2.2/snapshots/netology_backup/
total 36
-rw-r--r-- 1 elasticsearch elasticsearch   598 May 29 14:01 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 May 29 14:01 index.latest
drwxr-xr-x 3 elasticsearch elasticsearch  4096 May 29 14:01 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18095 May 29 14:01 meta-HDpoo3RTQXCXTnpsPu9wsA.dat
-rw-r--r-- 1 elasticsearch elasticsearch   312 May 29 14:01 snap-HDpoo3RTQXCXTnpsPu9wsA.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.
```
[elasticsearch@561e2f43c3e9 /]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 S3SuCxdDQX-S6JXS11LCIg   1   0          0            0       225b           225b
```
[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.
```
[elasticsearch@561e2f43c3e9 /]$ curl -X POST localhost:9200/_snapshot/netology_backup/my_snapshot_2022.05.29/_restore?pretty -H 'Content-Type: application/json' -d'{"include_global_state":true}'
{
  "accepted" : true
}
[elasticsearch@561e2f43c3e9 /]$ curl -X GET 'http://localhost:9200/_cat/indices?v'                                                            health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 S3SuCxdDQX-S6JXS11LCIg   1   0          0            0       225b           225b
green  open   test   sb2Lavy8S3qj7kmjSPujpA   1   0          0            0       225b           225b
```
