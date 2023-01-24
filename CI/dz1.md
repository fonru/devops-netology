# Основная часть

 > 1. Попробуйте запустить playbook на окружении из test.yml, зафиксируйте какое значение имеет факт some_fact для указанного хоста при выполнении playbook'a.

 ```sh
 fon@fons-Mac-mini playbook % ansible-playbook -i inventory/test.yml site.yml 

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
[WARNING]: Platform darwin on host localhost is using the discovered Python interpreter at /usr/local/bin/python3.11, but future installation of another Python interpreter could change the meaning
of that path. See https://docs.ansible.com/ansible-core/2.14/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "MacOSX"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ******************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

some_fact == 12

> 2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.

```text
В каталоге playbook/group_vars/all/examp.yml. Заменил на 'all default fact'

fon@fons-Mac-mini playbook % cat group_vars/all/examp.yml 
---
  some_fact: all default fact
```

> 3,4. Проведите запуск playbook на окружении из prod.yml. Зафиксируйте полученные значения some_fact для каждого из managed host.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

> 5,6 Добавьте факты в group_vars каждой из групп хостов так, чтобы для some_fact получились следующие значения: для deb - 'deb default fact', для el - 'el default fact'.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

>7. При помощи ansible-vault зашифруйте факты в group_vars/deb и group_vars/el с паролем netology.

```sh
fon@fons-Mac-mini 08-ansible-01-base % cat playbook/group_vars/el/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
33383933393561313430373438636137626462353065653632383761313332336532663739623739
6564383032613831393234333235646533343264336565630a326132333432623833646136346231
37643238633833653361303366343365326535313563633234316136626365633063636461393261
3639623664333961650a323139313063373039326630666235313230306630656265313531373634
38376532366634323839666232316335383032656638333132663634343433303937326163323439
6637646562643936333331303133353966333164363833613930
fon@fons-Mac-mini 08-ansible-01-base % cat playbook/group_vars/deb/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
32386462343865386131653136376265613837346231616433393430366438633166396133323763
6231616437646236643065613461373438353336373838640a323966653735363834316435613936
63373065323764333737373438376664643039636264636631626432633066396165366334616261
3263666563326135340a316462306361633530376263373466383436656630633763356539646264
33653062396632626337336439643064336439316339373138343630636162326566623562393839
3636376639363766353962343663383135346365633062363034
fon@fons-Mac-mini 08-ansible-01-base % 
```

>8. Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь в работоспособности.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

>9. Посмотрите при помощи ansible-doc список плагинов для подключения. Выберите подходящий для работы на control node.

```text
Не особо понял что от меня хотят в этом задании. Командой ansible-doc -l можно вывести список всех доступных плагинов, а дальше погрепать. 
```

>10, 11.Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь что факты some_fact для каждого из хостов определены из верных group_vars.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]
[WARNING]: Platform darwin on host localhost is using the discovered Python interpreter at /usr/local/bin/python3.11, but future installation of another Python interpreter could change the meaning
of that path. See https://docs.ansible.com/ansible-core/2.14/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "MacOSX"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Необязательная часть

>1. При помощи ansible-vault расшифруйте все зашифрованные файлы с переменными.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-vault decrypt playbook/group_vars/deb/examp.yml 
Vault password: 
Decryption successful
fon@fons-Mac-mini 08-ansible-01-base % ansible-vault decrypt playbook/group_vars/el/examp.yml 
Vault password: 
Decryption successful
```

>2. Зашифруйте отдельное значение PaSSw0rd для переменной some_fact паролем netology. Добавьте полученное значение в group_vars/all/exmp.yml.

```sh
fon@fons-Mac-mini 08-ansible-01-base % ansible-vault encrypt_string
New Vault password: 
Confirm New Vault password: 
Reading plaintext input from stdin. (ctrl-d to end input, twice if your content does not already have a newline)
PaSSw0rd
Encryption successful
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          63643262653937353638623562326466636166616465636465663262633536396561336361343266
          3337313364623562613033396431646434626130303336300a656233643262663237666664316164
          39376236373561343232376361343533393736353466376131323130626633363836396335646330
          3637306564386439340a306432636262646438613364323636613435303561643434346562353263
          3938%


fon@fons-Mac-mini 08-ansible-01-base % cat playbook/group_vars/all/examp.yml
---
  some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          63643262653937353638623562326466636166616465636465663262633536396561336361343266
          3337313364623562613033396431646434626130303336300a656233643262663237666664316164
          39376236373561343232376361343533393736353466376131323130626633363836396335646330
          3637306564386439340a306432636262646438613364323636613435303561643434346562353263
          3938%


fon@fons-Mac-mini 08-ansible-01-base % ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]
[WARNING]: Platform darwin on host localhost is using the discovered Python interpreter at /usr/local/bin/python3.11, but future installation of another Python interpreter could change the meaning
of that path. See https://docs.ansible.com/ansible-core/2.14/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "MacOSX"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}

[WARNING]: 
There was a vault format error: Vault format unhexlify error: Odd-length string

The error appears to be in '/Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/group_vars/all/examp.yml': line 2, column 14, but may
be elsewhere in the file depending on the exact syntax problem.

The offending line appears to be:

---
  some_fact: !vault |
             ^ here
ok: [ubuntu] => {
    "msg": "deb default fact"
}
fatal: [localhost]: FAILED! => {"msg": "Vault format unhexlify error: Odd-length string\n\nThe error appears to be in '/Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/group_vars/all/examp.yml': line 2, column 14, but may\nbe elsewhere in the file depending on the exact syntax problem.\n\nThe offending line appears to be:\n\n---\n  some_fact: !vault |\n             ^ here\n"}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

>4,5 Скрипт

```shell
#!/bin/bash

echo "Start centos7 container"
docker run -ti -d --name centos7 centos sh

echo "Start ubuntu container"
docker run -ti -d --name ubuntu ubuntu sh

echo "Start ubuntu container"
docker run -ti -d --name fedora fedora sh

sleep 15

echo "Run ansible playbook"
ansible-playbook -i /Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/inventory/prod.yml /Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/site.yml
```