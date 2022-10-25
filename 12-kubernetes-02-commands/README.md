# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"

## Задание 1: Запуск пода из образа в деплойменте

![image](1.png)

## Задание 2: Просмотр логов для разработки
  
![image](2.png)  
![image](3.png)  
Процесс создания пользователя:  
```
kubectl create serviceaccount logreader

kubectl create clusterrolebinding logreader --serviceaccount=default:logreader --clusterrole=view

kubectl create token logreader

kubectl config set-credentials logreader --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IkZvZDJzWEIweHpkaUpPTklxcjhENmRxM29YRFF1eERJU1c0N2xvUk9pMWcifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNjY2NjE3NjU0LCJpYXQiOjE2NjY2MTQwNTQsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImxvZ3JlYWRlciIsInVpZCI6IjMzNjlkMTU2LTZiZTUtNDQwMS1iOGViLTg4M2UxZjI0M2UyZCJ9fSwibmJmIjoxNjY2NjE0MDU0LCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpsb2dyZWFkZXIifQ.zbeT9mRkfxfKO9crlBjjF0Z3VfOOD96s6zXLgCzV_bvBJrgzcHOPGdCbjOfr7lvuLAarrkVDzE_TRDab_A2HuTQbb0m2W5eRrP9U5QWSCjdzVnwfGFc7Os1uRAOl5dKnzFfb2uJQT46BUvO58ybI_RF1stiOqiLJ8mEF5VtNZetXRzO2x2JGoVbHHVSTvsaBW_XVabGXEv50CL8hq1DFtPlB5PJU9SEvAL3Grqi6jnAVlFoZe4RN61sFEk6Xpnt4-TcP3nI5kIX7nZ8Ws8g3Nt8W9c9CUMsQr19f9F2g9TmUOK6zJ8rswSoP_CoLt_DABApbsULaSafau9-W4J4GCw
```  
Что может и не может пользователь:  
![image](4.png)  
![image](5.png)  
  
## Задание 3: Изменение количества реплик 
  
![image](6.png)  
  