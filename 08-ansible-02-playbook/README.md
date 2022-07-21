# Домашнее задание к занятию "08.02 Работа с Playbook"
## Основная часть

1. Приготовьте свой собственный inventory файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
root@vagrant:/tmp/playbook# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Install Clickhouse] *************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "vagrant", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] **************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ****************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ****************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *****************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *************************************************************************************************
ok: [vector-01]

TASK [Install vector] *****************************************************************************************************
ok: [vector-01]

PLAY RECAP ****************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
root@vagrant:/tmp/playbook# ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "vagrant", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] **************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ****************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ****************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] *****************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *************************************************************************************************
ok: [vector-01]

TASK [Install vector] *****************************************************************************************************
ok: [vector-01]

PLAY RECAP ****************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
root@vagrant:/tmp/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "vagrant", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] **************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ****************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ****************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *****************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *************************************************************************************************
ok: [vector-01]

TASK [Install vector] *****************************************************************************************************
ok: [vector-01]

PLAY RECAP ****************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
root@vagrant:/tmp/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "vagrant", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] **************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ****************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ****************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *****************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *************************************************************************************************
ok: [vector-01]

TASK [Install vector] *****************************************************************************************************
ok: [vector-01]

PLAY RECAP ****************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---
