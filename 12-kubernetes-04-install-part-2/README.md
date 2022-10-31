# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
  
## Задание 1: Подготовить инвентарь kubespray

```
git clone https://github.com/kubernetes-sigs/kubespray.git

cd kubespray

cp -rfp inventory/sample inventory/mykube

declare -a IPS=(192.168.34.252 192.168.34.251 192.168.34.250 192.168.34.249)

CONFIG_FILE=inventory/mykube/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
  
Сагласно тербованиям изменил [hosts.yaml](hosts.yaml).  
  
```
ansible-playbook -i inventory/mykube/hosts.yaml  --become --become-user=root cluster.yml
```

![image](1.png)  

Скоировал к себе config с master-node для подключения.
И проверил.

![image](2.png)


  