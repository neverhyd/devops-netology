# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Значение присвоено не будет. (TypeError: unsupported operand type(s) for +: 'int' and 'str')  |
| Как получить для переменной `c` значение 12?  | a = '1'  |
| Как получить для переменной `c` значение 3?  | b = 2  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

path = "C:/PortableGit/devops-netology"
bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(path + '/' + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
C:\PortableGit\devops-netology>python test.py
C:/PortableGit/devops-netology/README.md
C:/PortableGit/devops-netology/branching/merge.sh
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

if len(sys.argv)<2:
    print('Need path!')
    sys.exit()

path = sys.argv[1]
bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(path + '/' + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
C:\PortableGit\devops-netology>python test.py c:\PortableGit\devops-netology
c:\PortableGit\devops-netology/README.md
c:\PortableGit\devops-netology/branching/merge.sh

C:\PortableGit\devops-netology>python test.py c:\PortableGit\
fatal: not a git repository (or any of the parent directories): .git
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time

services = {'drive.google.com': '0.0.0.0', 'mail.google.com':  '0.0.0.0', 'google.com': '0.0.0.0'}

while True:
  for service in services:
    ipaddr = socket.gethostbyname(service)
    if services[service] == '0.0.0.0' or services[service] == ipaddr:
        services[service] = ipaddr
        print(f'<{service}> - {ipaddr}')
    else:
        print(f'[ERROR]<{service}> IP mismatch: <{services[service]}> <{ipaddr}>')
        services[service] = ipaddr
  time.sleep(15)
```

### Вывод скрипта при запуске при тестировании:
```
root@vagrant:~# ./sock.py
<drive.google.com> - 64.233.164.194
<mail.google.com> - 173.194.73.18
<google.com> - 142.251.1.139
<drive.google.com> - 64.233.164.194
[ERROR]<mail.google.com> IP mismatch: <173.194.73.18> <142.251.1.17>
[ERROR]<google.com> IP mismatch: <142.251.1.139> <173.194.222.100>
<drive.google.com> - 64.233.164.194
[ERROR]<mail.google.com> IP mismatch: <142.251.1.17> <142.250.150.83>
<google.com> - 173.194.222.100
```


# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | считает строкой присваеваемое знацение |
| `d`  | 1+2  | вместо переменных подставляет значения в строку |
| `e`  | 3  | $() - заставляет bash произвести операцию над целыми числами |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1))
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
array_ip=("192.168.0.1" "173.194.222.113" "87.250.250.242")  
for ip in ${array_ip[@]}  
do  
        check=0  
        while (($check < 5))  
        do  
                echo http://${ip}:80  
                curl --connect-timeout 5 http://${ip}:80 > log  
                check=$(($check+1))  
                echo $check  
        done  
done  
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
array_ip=("192.168.0.1" "173.194.222.113" "87.250.250.242")  
for ip in ${array_ip[@]}  
do  
        check=0  
        while (($check < 5))  
        do  
                echo http://${ip}:80  
                curl --connect-timeout 5 http://${ip}:80 >> log  
                check=$(($check+1))  
                echo $check  
        done  
done  
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
array_ip=("192.168.0.1" "173.194.222.113" "87.250.250.242")  
for ip in ${array_ip[@]}  
do  
        check=0  
        while (($check < 5))  
        do  
                echo http://${ip}:80  
                curl --connect-timeout 5 http://${ip}:80 >> log  
                check=$(($check+1))  
                if (($? != 0))  
                then  
                        echo $ip >> error  
                        exit  
                fi  
        done  
done  
```