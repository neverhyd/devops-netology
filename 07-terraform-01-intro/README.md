# Домашнее задание к занятию "7.1. Инфраструктура как код"

## Задача 1. Выбор инструментов. 
 
1. Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
```
Будем использовать оба типа конфигурации.
```
1. Будет ли центральный сервер для управления инфраструктурой?
```
Центрального сервера не будет.
```
1. Будут ли агенты на серверах?
```
Агентов на серверах не будет.
```
1. Будут ли использованы средства для управления конфигурацией или инициализации ресурсов? 
```
Будут использоваться средства для управления конфигурацией и инициализации ресурсов.
```

1. Какие инструменты из уже используемых вы хотели бы использовать для нового проекта? 
```
Terraform, Packer, Ansible, Docker.
```
1. Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта? 
```
На текущий момент нет.
```

## Задача 2. Установка терраформ. 

```
root@vagrant:~# terraform --version
Terraform v1.1.9
on linux_amd64
```

## Задача 3. Поддержка легаси кода. 

```
root@vagrant:~# terraform --version
Terraform v1.1.9
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.2.2. You can update by downloading from https://www.terraform.io/downloads.html
root@vagrant:~# ./terraform_1.2.2 --version
Terraform v1.2.2
on linux_amd64
```

---
