# Домашнее задание к занятию "08.03 Использование Yandex Cloud"

9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
```
playbook делает:
 На узел clickhouse:
  1. Скачивает дистибутивы clickhouse.
  2. Устанавливает скаченные дистрибутивы.
  3. Запускает clickhouse.
  4. Создает базу данных log.
 На узел vector:
  1. Скачивает дистрибутив vector на узел vector.
  2. Устанавливает vector из скаченного дистрибутива.
  3. Запускает vector.
 На узел vector:
  4. Устанавливает nginx.
  5. Копирует шаблон конфигурации nginx.
  6. Устанваливает Git на lighthouse.
  7. Клонирует репозиторий lighthouse.
  8. Запускает nginx.

Параметры:
 для clickhouse:
  clickhouse_version
  clickhouse_packages
 для vector:
  vector_version
 для lighthouse:
  lighthouse_repo
  lighthouse_root

Тэги:
 clickhouse
 vector
 lighthouse
```
