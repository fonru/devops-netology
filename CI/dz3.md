
# Основная часть
>1,2,3,4

[playbook](08-ansible-02-playbook/playbook/site.yml)

[invetory](08-ansible-02-playbook/playbook/inventory/prod.yml)

[clickhouse_vars](08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml)

[vector_vars](08-ansible-02-playbook/playbook/group_vars/vector/vars.yml)

[lighthouse_vars](08-ansible-02-playbook/playbook/group_vars/lighthouse/vars.yml)

>5 Проверил линтом

```shell
fon@fons-Mac-mini 08-ansible-02-playbook % ansible-lint playbook/site.yml 
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: playbook/site.yml

Passed with production profile: 0 failure(s), 0 warning(s) on 1 files.
```

>6,7,8,10 Запуск плейбука 

```shell
fon@fons-Mac-mini 08-ansible-02-playbook % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml

PLAY [Install Clickhouse] ********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ****************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "admin", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "admin", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ****************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***********************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] ************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download and install vector packages] **************************************************************************************************************************************************************************
ok: [vector-01]

PLAY [Install Lighthouse] ********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Install epel-release] ******************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Install git] ***************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Install nginx] *************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Clean html directory] ******************************************************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [Copy-lighthouse] ***********************************************************************************************************************************************************************************************
changed: [lighthouse-01]

RUNNING HANDLER [Restart nginx] **************************************************************************************************************************************************************************************
changed: [lighthouse-01]

PLAY RECAP ***********************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

![screenshoot_lighthouse](Screenshot%202023-01-30%20at%2016.13.50.png)

> Задание 9

[README - описание playbook](08-ansible-02-playbook/README.md)