# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

## Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения frontend из образа nginx с количеством реплик 3 шт.

[manifest](manifests/frontended.yaml)

![kubectl get deployments.apps](screenshoots/1.png)

2. Создать Deployment приложения backend из образа multitool.

[manifest](manifests/backend.yaml)

![kubectl get deployments.apps](screenshoots/2.png)

3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера.

[manifest](manifests/front_back_svc.yaml)

![svc](screenshoots/3.png)

4. Продемонстрировать, что приложения видят друг друга с помощью Service.

curl с одного из подов backend
![curl](screenshoots/4.png)

5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

## Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
   
![enable ingress](screenshoots/5.png)

2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался frontend а при добавлении /api - backend.

[manifest](manifests/ingress.yaml)

![ingress](screenshoots/6.png)

3. Продемонстрировать доступ с помощью браузера или curl с локального компьютера.
   
![googlechrome](screenshoots/7.png)
![googlechrome](screenshoots/8.png)
1. Предоставить манифесты и скриншоты или вывод команды п.2.

По заданию предоставил