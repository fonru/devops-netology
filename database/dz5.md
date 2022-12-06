# Задача 1

>текст Dockerfile манифеста

>ссылку на образ в репозитории dockerhub

>ответ elasticsearch на запрос пути / в json виде

```json
[elasticsearch@d9266f5869ec ~]$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic https://localhost:9200
Enter host password for user 'elastic':
{
  "name" : "netology_test",
  "cluster_name" : "netology",
  "cluster_uuid" : "speGr8sMRA-NkZG3gjJPYw",
  "version" : {
    "number" : "8.0.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "801d9ccc7c2ee0f2cb121bbe22ab5af77a902372",
    "build_date" : "2022-02-24T13:55:40.601285296Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

# Задача 2

> Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:

```json
bash-4.2$ curl -X PUT -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "index": {
>       "number_of_shards": 1,  
>       "number_of_replicas": 0 
>     }
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}
bash-4.2$ curl -X PUT -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "index": {
>       "number_of_shards": 2,  
>       "number_of_replicas": 1
>     }
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}
bash-4.2$ curl -X PUT -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "index": {
>       "number_of_shards": 4,  
>       "number_of_replicas": 2
>     }
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}
```

> Получите список индексов и их статусов, используя API и приведите в ответе на задание.

```shell
bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cat/indices                 
green  open ind-1 eu1r0lDqTMGHWgumx8Ukwg 1 0 0 0 225b 225b
yellow open ind-3 _H0Fh_3LQ4yYb4LrjIRCwA 4 2 0 0 900b 900b
yellow open ind-2 HLWamp-sS4SJALp-5YLzig 2 1 0 0 450b 450b
bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cat/indices?v=true
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 eu1r0lDqTMGHWgumx8Ukwg   1   0          0            0       225b           225b
yellow open   ind-3 _H0Fh_3LQ4yYb4LrjIRCwA   4   2          0            0       900b           900b
yellow open   ind-2 HLWamp-sS4SJALp-5YLzig   2   1          0            0       450b           450b
```

> Получите состояние кластера elasticsearch

```shell
bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```

> Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```shell
bash-4.2$ curl -X GET -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/_cluster/health?filter_path=status,*_shards&pretty"
{
  "status" : "yellow",
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0
}
```

Насколько я понимаю, это из-за того что есть unassigned_shards.

>Удалите все индексы.

```shell
bash-4.2$ curl -X DELETE -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-3?pretty" 
{
  "acknowledged" : true
}
bash-4.2$ curl -X DELETE -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-2?pretty" 
{
  "acknowledged" : true
}
bash-4.2$ curl -X DELETE -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/ind-1?pretty" 
{
  "acknowledged" : true
}
```

# Задача 3

>Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.

```text
пришлось немного подредактировать конфиг elastic, добавив пути до репозиториев
```

```json
bash-4.2$ curl -X PUT -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/home/elasticsearch/elasticsearch-8.5.2/snapshots"
  }
}
'
{
  "acknowledged" : true
}
```

> Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.

```shell
bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cat/indices            
green open test kjEXfxiZRkyikuEHsHiY6A 1 0 0 0 225b 225b
```

>Создайте snapshot состояния кластера elasticsearch

```json
bash-4.2$ curl -X PUT -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/_snapshot/netology_backup/first_snapshot?pretty"
{
  "accepted" : true
}
```

> Приведите в ответе список файлов в директории со snapshotами.

```shell
bash-4.2$ pwd
/home/elasticsearch/elasticsearch-8.5.2/snapshots
bash-4.2$ ls -lh
total 36K
-rw-r--r-- 1 elasticsearch elasticsearch  842 Dec  6 20:07 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 Dec  6 20:07 index.latest
drwxr-xr-x 4 elasticsearch elasticsearch 4.0K Dec  6 20:07 indices
-rw-r--r-- 1 elasticsearch elasticsearch  18K Dec  6 20:07 meta-qJUxJ6VySK-rKTUxOkLuLw.dat
-rw-r--r-- 1 elasticsearch elasticsearch  349 Dec  6 20:07 snap-qJUxJ6VySK-rKTUxOkLuLw.dat
bash-4.2$ 
```

> Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.

```shell
bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cat/indices   
green open test-2 bahcxjfpTaOquYF-xfKZvA 1 0 0 0 225b 225b
```

>Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.\
Приведите в ответе запрос к API восстановления и итоговый список индексов.

```shell
bash-4.2$ curl -X POST -u elastic:87nPIJ-TfkXAZTkDCvGJ "localhost:9200/_snapshot/netology_backup/first_snapshot/_restore?pretty" -H 'Content-Type: application/json' -d'
> {
>   "include_global_state": true                   
> }
> '
{
  "accepted" : true
}

bash-4.2$ curl -u elastic:87nPIJ-TfkXAZTkDCvGJ localhost:9200/_cat/indices 
green open test-2 bahcxjfpTaOquYF-xfKZvA 1 0 0 0 225b 225b
green open test   AF2Nzg9QTPSV3AumyNrBMQ 1 0 0 0 225b 225b

```
