# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

---

## Задача 1

Основными преимуществами применения на практике подхода Инфраструктура как сервис по моему мнению явлеются:  
 - ускорение развертывания виртуальных машин c настройкой под конкретные задачи;  
 - получение ожидаемо одинаковых результатов от повтороного развертывания.
Основополагющим является принцип - идемпотетнтность.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
  Ansible выгодно отличается использованием, имеющейся на управляемых объектах, инфраструктурой PKI ssh.
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
  На мой взгляд применение наиболее надежным будет использование обоих методов.

## Задача 3

Установить на личный компьютер:

- VirtualBox
```
c:\Program Files\Oracle\VirtualBox>vbox-img.exe -version
6.1.32r149290
```
- Vagrant
```
c:\vm>vagrant version
Installed Version: 2.2.19
Latest Version: 2.2.19

You're running an up-to-date version of Vagrant!
```
- Ansible
```
root@vagrant:~# ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]
```
