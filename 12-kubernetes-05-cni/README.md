# Домашнее задание к занятию "12.5 Сетевые решения CNI"

## Задание 1: установить в кластер CNI плагин Calico
  
kubespary использую из прошлого задания.  
в нём развернут под hello-node  
![image](1.png)  
настроил политику Default deny all ingress traffic  
```
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```
![image](2.png)  

## Задание 2: изучить, что запущено по умолчанию

![image](3.png)  
