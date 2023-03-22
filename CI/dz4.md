# Основная часть 

>1,2. Создаем файлик requirements.yml и скачиваем роль с git-репозитория.

```sh
fon@fons-Mac-mini playbook % ansible-galaxy install -r requirements.yml -p ansible-clickhouse                
Starting galaxy role install process
- extracting clickhouse to /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/ansible-clickhouse/clickhouse
- clickhouse (1.11.0) was installed successfully
fon@fons-Mac-mini playbook % ls -la 
total 24
drwxr-xr-x  8 fon  admin   272 Feb  7 11:23 .
drwxr-xr-x  4 fon  admin   136 Feb  7 10:32 ..
-rw-r--r--  1 fon  admin     7 Feb  7 10:32 .gitignore
drwxr-xr-x  3 fon  admin   102 Feb  7 11:23 ansible-clickhouse
drwxr-xr-x  5 fon  admin   170 Feb  7 10:32 group_vars
drwxr-xr-x  3 fon  admin   102 Feb  7 10:32 inventory
-rw-r--r--  1 fon  admin   122 Feb  7 11:23 requirements.yml
-rwxr-xr-x  1 fon  admin  2988 Feb  7 10:32 site.yml
```

### Vector

>3. Инициализируем директорию под роль vector-role

```sh
fon@fons-Mac-mini playbook % ansible-galaxy role init vector-role
- Role vector-role was created successfully
fon@fons-Mac-mini playbook % ls -la
total 24
drwxr-xr-x   9 fon  admin   306 Feb  7 11:26 .
drwxr-xr-x   4 fon  admin   136 Feb  7 10:32 ..
-rw-r--r--   1 fon  admin     7 Feb  7 10:32 .gitignore
drwxr-xr-x   3 fon  admin   102 Feb  7 11:23 ansible-clickhouse
drwxr-xr-x   5 fon  admin   170 Feb  7 10:32 group_vars
drwxr-xr-x   3 fon  admin   102 Feb  7 10:32 inventory
-rw-r--r--   1 fon  admin   122 Feb  7 11:23 requirements.yml
-rwxr-xr-x   1 fon  admin  2988 Feb  7 10:32 site.yml
drwxr-xr-x  11 fon  admin   374 Feb  7 11:26 vector-role
```

>4,5 Переносим tasks/handlers/vars из старого playbook в таски новой роли.

[tasks/main.yml]

```yml
---
- name: Download and install vector packages
  become: true
  ansible.builtin.apt:
    deb: "https://packages.timber.io/vector/{{ vector_version }}/vector_{{ vector_version }}-1_amd64.deb"
  notify: Start Vector service
```

[handlers/main.yml]

```yml
---
- name: Start Vector service
  become: true
  ansible.builtin.service:
    name: vector
    state: restarted
```

[defaults/main.yml]

```yml
---
vector_version: "0.27.0"
```

>6 README

[README](CI/08-ansible-02-playbook-with-roles/playbook/vector-role/README.md)

### Lighthouse

>3. Инициализируем директорию под роль lighthouse 

```sh
fon@fons-Mac-mini playbook % ansible-galaxy role init lighthouse                             
- Role lighthouse was created successfully
fon@fons-Mac-mini playbook % ls -la
total 24
drwxr-xr-x  10 fon  admin   340 Feb  7 12:38 .
drwxr-xr-x   4 fon  admin   136 Feb  7 10:32 ..
-rw-r--r--   1 fon  admin     7 Feb  7 10:32 .gitignore
drwxr-xr-x   3 fon  admin   102 Feb  7 11:23 ansible-clickhouse
drwxr-xr-x   5 fon  admin   170 Feb  7 10:32 group_vars
drwxr-xr-x   3 fon  admin   102 Feb  7 10:32 inventory
drwxr-xr-x  11 fon  admin   374 Feb  7 12:38 lighthouse
-rw-r--r--   1 fon  admin   122 Feb  7 11:23 requirements.yml
-rwxr-xr-x   1 fon  admin  2988 Feb  7 10:32 site.yml
drwxr-xr-x  11 fon  admin   374 Feb  7 11:26 vector-role
```

>4,5 Переносим tasks/handlers/vars из старого playbook в таски новой роли.

[handlers/main.yml]

```yml
---
- name: Restart nginx
  become: true
  ansible.builtin.service:
    name: nginx
    state: reloaded
```

[tasks/main.yml]

```yml
---
- name: Install epel-release
  become: true
  ansible.builtin.yum:
    name:
      - epel-release
- name: Install git
  become: true
  ansible.builtin.yum:
    name:
      - git
- name: Install nginx
  become: true
  ansible.builtin.yum:
    name:
      - nginx
- name: Clean html directory
  become: true
  ansible.builtin.file:
    state: absent
    path: usr/share/nginx/html/
- name: Copy-lighthouse
  become: true
  ansible.builtin.git:
    repo: https://github.com/VKCOM/lighthouse.git
    version: master
    dest: "{{ clickhouse_dir }}"
  notify: Restart nginx
```

[defaults/main.yml]

```yml
---
clickhouse_dir: "/usr/share/nginx/html"
```

>6 README

[README](CI/08-ansible-02-playbook-with-roles/playbook/lighthouse/README.md)

>7 Выложил все в новые репозитории и добавил в requirements.yml новыие источники ролей

[requirments.yml]
```yml
---
  - src: https://github.com/AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version: 1.11.0
    name: clickhouse
  - src: https://github.com/fonru/ansible-lighthouse.git
    scm: git
    version: 1.0.0
    name: lighthouse
  - src: https://github.com/fonru/ansible-vector.git
    scm: git
    version: 1.0.0
    name: vector
```

>8 Переработанный playbok с ипользованием ролей.

```yml
---
- name: Install Clickhouse
  hosts: clickhouse
  roles: clickhouse

# Vector Install
- name: Install vector
  hosts: vector
  roles: vector

# Lighthouse install
- name: Install Lighthouse
  hosts: lighthouse
  roles: lighthouse
```