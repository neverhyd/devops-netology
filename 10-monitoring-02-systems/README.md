# Домашнее задание к занятию "10.02. Системы мониторинга"

1.  
pull:  
 - единая точка настройки;  
 - метрики собираются с известных узлов;  
 - меньше требований к железу;  
 - быстрей понимаем, когда что-то не работает.  
  
push:  
 - тонкое конфигурирование метрик;  
 - нет необходимости устанавливать соединение.  
  
1.   

    - Prometheus - pull(но умеет работать с push)  
    - TICK - push  
    - Zabbix - push(но умеет работать с pull)  
    - VictoriaMetrics - push(vmagent - pull)  
    - Nagios - pull  
  
1.    
```
root@vagrant:/home/vagrant/sandbox# curl http://localhost:8086/ping
root@vagrant:/home/vagrant/sandbox# curl http://localhost:8888
<!DOCTYPE html><html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.fa749080.ico"><link rel="stylesheet" href="/src.9cea3e4e.css"></head><body> <div id="react-root" data-basepath=""></div> <script src="/src.a969287c.js"></script> </body></html>root@vagrant:/home/vagrant/sandbox#
root@vagrant:/home/vagrant/sandbox# curl http://localhost:9092/kapacitor/v1/ping
root@vagrant:/home/vagrant/sandbox#
```  
   
![image скриншот веб-интерфейса ПО chronograf](chronograf.png).   
  
1. ![image скриншот с отображением метрик утилизации места на диске](disk_usage.png)  
  
1. ![image криншот с отображением метрик docker](docker-plug.png).  

---
