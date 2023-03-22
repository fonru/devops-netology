# Основная часть

>Задания 1,2,3,4 через общий плейбук clickhouse + vector .

[playbook](08-ansible-02-playbook/playbook/site.yml)

[invetory](08-ansible-02-playbook/playbook/inventory/prod.yml)

[clickhouse_vars](08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml)

[vector_vars](08-ansible-02-playbook/playbook/group_vars/vector/vars.yml)

```shell
fon@fons-Mac-mini CI % ansible-playbook -i 08-ansible-02-playbook/playbook/inventory/prod.yml 08-ansible-02-playbook/playbook/site.yml --extra-vars "ansible_sudo_pass=admin1"

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "admin", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "admin", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] *********************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download and install vector packages] ***********************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ********************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

> Задания 5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.

```shell
fon@fons-Mac-mini playbook % ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml

Passed with production profile: 0 failure(s), 0 warning(s) on 1 files.
```

> Задание 6. Попробуйте запустить playbook на этом окружении с флагом --check

```shell
fon@fons-Mac-mini CI % ansible-playbook -i 08-ansible-02-playbook/playbook/inventory/prod.yml 08-ansible-02-playbook/playbook/site.yml --extra-vars "ansible_sudo_pass=admin1" --check

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "admin", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "admin", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ********************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install vector] *********************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download and install vector packages] ***********************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP ********************************************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
vector-01                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

> Задание 7,8.

```shell
fon@fons-Mac-mini CI % ansible-playbook -i 08-ansible-02-playbook/playbook/inventory/prod.yml 08-ansible-02-playbook/playbook/site.yml --extra-vars "ansible_sudo_pass=admin1" --check

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "admin", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "admin", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ********************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install vector] *********************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download and install vector packages] ***********************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP ********************************************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
vector-01                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

fon@fons-Mac-mini CI % ansible-playbook -i 08-ansible-02-playbook/playbook/inventory/prod.yml 08-ansible-02-playbook/playbook/site.yml --extra-vars "ansible_sudo_pass=admin1" --diff 

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "admin", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "admin", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ********************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] *********************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download and install vector packages] ***********************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP ********************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

> Задание 9

[README - описание playbook](08-ansible-02-playbook/README.md)