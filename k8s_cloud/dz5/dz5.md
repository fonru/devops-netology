# Домашнее задание к занятию Troubleshooting

### Цель задания

Устранить неисправности при деплое приложения.

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.

### Решение

`Данный манифест не запустится с ходу, потому что нет ns-ов data и web`

`Добавили через kubectl create ns два ns)`

![ns-status](screenshoots/1.png)

`Все создалось)`

![check-deployment](screenshoots/2.png)