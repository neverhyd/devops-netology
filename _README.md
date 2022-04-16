
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

https://hub.docker.com/r/neverhyd/netology

## Задача 2

Сценарий:

- Высоконагруженное монолитное java веб-приложение;   
  Предполагаю тут уместно использовать виртуальную машину, чтобы управлять используемыми ресурсами.  
  
- Nodejs веб-приложение;  
  Предполагаю подходит Docker, для одного приложения выделять виртуальную машину или физический сервер нецелесообразно.    
  
- Мобильное приложение c версиями для Android и iOS;  
  Предполагаю подойдет Docker (несколько версий приложения). 
  
- Шина данных на базе Apache Kafka;  
  Предполагаю подходит Docker потому, что в задачи брокера сообщений входит только обработка сообщений.  
  
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; 
  Предполагаю виртуальные машины с докером.  
  
- Мониторинг-стек на базе Prometheus и Grafana;  
  Предполагаю что подойдет виртуальная машина.  
  
- MongoDB, как основное хранилище данных для java-приложения;  
  Предполагаю нужно использовать физический сервер, чтобы не тратить ресурсы на виртуализацию.  
  
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
  Предполагаю, что подойдет виртуальная машина.  

## Задача 3

```
root@vagrant:~# docker run -v /root/data:/data --name centos3 -d centos sleep 9999
f32acd6dd564bc0d0ccee754f29a323927ef89ed2bc451f6b28796dae4d0ce09
root@vagrant:~# docker run -v /root/data:/data --name debian3 -d debian sleep 9999
3316e52ec74f33027206234091c2226a98dafc507eab4257e5f64123e8c9f75a
root@vagrant:~# docker exec -it centos3 bash
[root@f32acd6dd564 /]# pwd
/
[root@f32acd6dd564 /]# ls
bin  data  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@f32acd6dd564 /]# echo "123" > /data/test.txt
[root@f32acd6dd564 /]# exit
exit
root@vagrant:~# ls data
test.txt
root@vagrant:~# echo "321" > data/q.txt
root@vagrant:~# ls data
q.txt  test.txt
root@vagrant:~# docker exec -it debian3 bash
root@3316e52ec74f:/# ls /data
q.txt  test.txt
root@3316e52ec74f:/# cat /data/q.txt
321
root@3316e52ec74f:/# cat /data/test.txt
123
root@3316e52ec74f:/#
```