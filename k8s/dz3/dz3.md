# Домашнее задание к занятию «Запуск приложений в K8S»

## Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.

[файл-manifest](manifests/nginx_multitool.yaml)

![kubectl get pods](screenshoots/1.png)

2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.

![kubectl get pods](screenshoots/2.png)

4. Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложений из п.1.

![kubectl get svc](screenshoots/3.png)

![kubectl get pods](screenshoots/4.png)
\
\
\
Подключаемся к sh pod multitool-pod

![kubectl exec -ti multitool-pod /bin/bash](screenshoots/5.png)
\
\
\
Тестируем коннект через внутреннюю сеть до nginx

![curl 10.152.183.167:5555](screenshoots/6.png)
\
\
\
Тестируем коннект через внутреннюю сеть до multitool

![curl 10.152.183.167:6666](screenshoots/7.png)


## Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.

[файл-manifest](manifests/nginx_dep.yaml)

![kubectl get pods до создания сервиса](screenshoots/8.png)

3. Создать и запустить Service. Убедиться, что Init запустился.

[файл-manifest-nginxsvc](manifests/nginx_svc.yaml)

4. Продемонстрировать состояние пода до и после запуска сервиса.

![kubectl get pods после создания сервиса](screenshoots/9.png)