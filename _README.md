# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time
import json
import yaml

sjson = 'services.json'
syaml = 'services.yml'
lyml = []

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
    lyml.append({service:services[service]})

  with open(sjson, 'w') as f1:
    f1.write(json.dumps(services))

  with open (syaml, 'w') as f2:
    yaml.dump(lyml, f2)

  lyml.clear()
  time.sleep(15)

#print(services)
```

### Вывод скрипта при запуске при тестировании:
```
<drive.google.com> - 74.125.205.194
<mail.google.com> - 108.177.14.83
<google.com> - 74.125.131.100
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "74.125.205.194", "mail.google.com": "108.177.14.17", "google.com": "74.125.131.102"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- drive.google.com: 74.125.205.194
- mail.google.com: 108.177.14.17
- google.com: 74.125.131.102
```