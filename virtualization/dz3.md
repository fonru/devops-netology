### Задача 1

https://hub.docker.com/repository/docker/fonru/netology

---

### Задача 2

- Высоконагруженное монолитное java веб-приложение - т.к. предпологается, что и фронтэнд и бекенд будут в одном
месте, то контейнеры не подойдут, т.к. они предполагают поднятие одного сервиса в рамках одного контейнера.
Размещение на физическом сервере мне кажется оптимальным решением, для высоконагруженного приложения.


- Nodejs веб-приложение - мне кажется подойдет докер контейнер, т.к. по сути необходимо запустить окружение для
js приложения.


- Мобильное приложение c версиями для Android и iOS  - т.к. предпологается разная версионность, то думаю контейнеры
не подайдут т.к. необходимы разные компоненты\модули, а оптимальным решением будет использование различных VM.


- Шина данных на базе Apache Kafka - брокер сообщений, который спокойно можно разместить в контейнере.
Часто применяется для обмена сообщениями между приложениями в микросервисной архитектуре.


- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;-
 мне кажется оптимальным решением будет использование VM, так как решение будет достаточно нагруженным.


- Мониторинг-стек на базе Prometheus и Grafana - думаю можно использовать контейнеризацию.
Тем более сам производитель рекоммендует использовать данное решение для удобства развертования и масштабирования.


- MongoDB, как основное хранилище данных для java-приложения - мне кажется все зависит от нагруженности сервиса.
Если сервис высоконагруженный то лучше использовать VM.


- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - я думаю из-за удобства обновления
масштабирования контейнериация оптимальна.


### Задача 3

- Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей 
директории на хостовой машине в /data контейнера;
```
root@server1:/home/vagrant# docker pull centos:7.9.2009
7.9.2009: Pulling from library/centos
2d473b07cdd5: Pull complete 
Digest: sha256:c73f515d06b0fa07bb18d8202035e739a494ce760aa73129f60f4bf2bd22b407
Status: Downloaded newer image for centos:7.9.2009
docker.io/library/centos:7.9.2009


root@server1:/home/vagrant# docker run -it -v /home/vagrant/data:/data centos:7.9.2009


[root@d20c785c99f9 /]# ls -lh
total 60K
-rw-r--r--   1 root root  12K Nov 13  2020 anaconda-post.log
lrwxrwxrwx   1 root root    7 Nov 13  2020 bin -> usr/bin
drwxr-xr-x   2 root root 4.0K Nov  3 11:13 data
drwxr-xr-x   5 root root  360 Nov  3 11:15 dev
drwxr-xr-x   1 root root 4.0K Nov  3 11:15 etc
drwxr-xr-x   2 root root 4.0K Apr 11  2018 home
lrwxrwxrwx   1 root root    7 Nov 13  2020 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Nov 13  2020 lib64 -> usr/lib64
drwxr-xr-x   2 root root 4.0K Apr 11  2018 media
drwxr-xr-x   2 root root 4.0K Apr 11  2018 mnt
drwxr-xr-x   2 root root 4.0K Apr 11  2018 opt
dr-xr-xr-x 175 root root    0 Nov  3 11:15 proc
dr-xr-x---   2 root root 4.0K Nov 13  2020 root
drwxr-xr-x  11 root root 4.0K Nov 13  2020 run
lrwxrwxrwx   1 root root    8 Nov 13  2020 sbin -> usr/sbin
drwxr-xr-x   2 root root 4.0K Apr 11  2018 srv
dr-xr-xr-x  13 root root    0 Nov  3 11:15 sys
drwxrwxrwt   7 root root 4.0K Nov 13  2020 tmp
drwxr-xr-x  13 root root 4.0K Nov 13  2020 usr
drwxr-xr-x  18 root root 4.0K Nov 13  2020 var

```

- Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории 
на хостовой машине в /data контейнера;
```
root@server1:/home/vagrant# docker pull debian:bookworm
bookworm: Pulling from library/debian
3721e3e25958: Pull complete 
Digest: sha256:48b28b354484a7f0e683e340fa0e6e4c4bce3dc3aa0146fc2f78f443fde2c55d
Status: Downloaded newer image for debian:bookworm
docker.io/library/debian:bookworm

root@server1:/home/vagrant# docker run -it -v /home/vagrant/data:/data debian:bookworm

root@b237026ba35e:/# ls -lh
total 52K
lrwxrwxrwx   1 root root    7 Oct 24 00:00 bin -> usr/bin
drwxr-xr-x   2 root root 4.0K Oct  3 21:30 boot
drwxr-xr-x   2 root root 4.0K Nov  3 11:13 data
drwxr-xr-x   5 root root  360 Nov  3 11:19 dev
drwxr-xr-x   1 root root 4.0K Nov  3 11:19 etc
drwxr-xr-x   2 root root 4.0K Oct  3 21:30 home
lrwxrwxrwx   1 root root    7 Oct 24 00:00 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct 24 00:00 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct 24 00:00 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct 24 00:00 libx32 -> usr/libx32
drwxr-xr-x   2 root root 4.0K Oct 24 00:00 media
drwxr-xr-x   2 root root 4.0K Oct 24 00:00 mnt
drwxr-xr-x   2 root root 4.0K Oct 24 00:00 opt
dr-xr-xr-x 179 root root    0 Nov  3 11:19 proc
drwx------   2 root root 4.0K Oct 24 00:00 root
drwxr-xr-x   3 root root 4.0K Oct 24 00:00 run
lrwxrwxrwx   1 root root    8 Oct 24 00:00 sbin -> usr/sbin
drwxr-xr-x   2 root root 4.0K Oct 24 00:00 srv
dr-xr-xr-x  13 root root    0 Nov  3 11:19 sys
drwxrwxrwt   2 root root 4.0K Oct 24 00:00 tmp
drwxr-xr-x  14 root root 4.0K Oct 24 00:00 usr
drwxr-xr-x  11 root root 4.0K Oct 24 00:00 var

```

```
root@server1:/home/vagrant# docker ps
CONTAINER ID   IMAGE             COMMAND       CREATED          STATUS          PORTS     NAMES
609c848f54fc   debian:bookworm   "bash"        11 seconds ago   Up 10 seconds             elastic_bhabha
803c0e1b799b   centos:7.9.2009   "/bin/bash"   28 seconds ago   Up 28 seconds             quizzical_solomon

```


- Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;

```
root@server1:/home/vagrant# docker exec practical_gould ls -lh /data
total 0
-rw-r--r-- 1 root root 0 Nov  3 11:44 file_1
```

- Добавьте еще один файл в папку /data на хостовой машине

```
root@server1:/home/vagrant# cat /home/vagrant/data/host_file 
blablalblablablabal
```

- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
```
root@server1:/home/vagrant# docker exec magical_blackburn ls -lh /data && docker exec magical_blackburn cat /data/host_file
total 4.0K
-rw-r--r-- 1 root root  0 Nov  3 11:44 file_1
-rw-r--r-- 1 root root 20 Nov  3 11:50 host_file
blablalblablablabal
```

### Задача 4

https://hub.docker.com/repository/docker/fonru/netology