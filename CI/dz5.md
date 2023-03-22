# Основная часть

## Molecule

> 1. Запустите molecule test -s centos7 внутри корневой директории clickhouse-role, посмотрите на вывод команды.

Из вовода ниже видно, что установлена указанная в задании версия molecule и попробовал запустить тест Centos_7. lint не прошел проверку...Ничего в коде molecule не менял.

```sh
fon@fons-Mac-mini clickhouse % molecule test -s centos_7
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/Users/fon/.cache/ansible-compat/7e099f/modules:/Users/fon/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/Users/fon/.cache/ansible-compat/7e099f/collections:/Users/fon/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/Users/fon/.cache/ansible-compat/7e099f/roles:/Users/fon/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > lint
COMMAND: yamllint .
ansible-lint
flake8

WARNING  Listing 79 violation(s) that are fatal
fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
handlers/main.yml:3 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

schema[meta]: 2.8 is not of type 'string' (warning)
meta/main.yml:1  Returned errors will not include exact line numbers, but they will mention
the schema name being used as a tag, like ``schema[playbook]``,
``schema[tasks]``.

This rule is not skippable and stops further processing of the file.

If incorrect schema was picked, you might want to either:

* move the file to standard location, so its file is detected correctly.
* use ``kinds:`` option in linter config to help it pick correct file type.


fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/centos_7/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/centos_7/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/centos_8/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/centos_8/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

schema[inventory]: None is not of type 'object' (warning)
molecule/resources/inventory/hosts.yml:1  Returned errors will not include exact line numbers, but they will mention
the schema name being used as a tag, like ``schema[playbook]``,
``schema[tasks]``.

This rule is not skippable and stops further processing of the file.

If incorrect schema was picked, you might want to either:

* move the file to standard location, so its file is detected correctly.
* use ``kinds:`` option in linter config to help it pick correct file type.


fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/resources/playbooks/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_role).
molecule/ubuntu_focal/converge.yml:5 Use `ansible.builtin.include_role` or `ansible.legacy.include_role` instead.

fqcn[action-core]: Use FQCN for builtin module actions (assert).
molecule/ubuntu_focal/verify.yml:8 Use `ansible.builtin.assert` or `ansible.legacy.assert` instead.

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/configure/db.yml:2 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

jinja[spacing]: Jinja2 spacing could be improved: clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{' --secure' if clickhouse_tcp_secure_port is defined else '' }} -> clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{ ' --secure' if clickhouse_tcp_secure_port is defined else '' }} (warning)
tasks/configure/db.yml:2 Jinja2 template rewrite recommendation: `clickhouse-client -h 127.0.0.1 --port {{ clickhouse_tcp_secure_port | default(clickhouse_tcp_port) }}{{ ' --secure' if clickhouse_tcp_secure_port is defined else '' }}`.

no-free-form: Avoid using free-form when calling module actions. (set_fact) (warning)
tasks/configure/db.yml:2 Task/Handler: Set ClickHose Connection String

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:5 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:11 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/configure/db.yml:20 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/dict.yml:2 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:2 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:17 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/configure/sys.yml:26 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:35 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:45 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:54 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:65 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (template).
tasks/configure/sys.yml:76 Use `ansible.builtin.template` or `ansible.legacy.template` instead.

fqcn[action-core]: Use FQCN for builtin module actions (lineinfile).
tasks/configure/sys.yml:87 Use `ansible.builtin.lineinfile` or `ansible.legacy.lineinfile` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_key).
tasks/install/apt.yml:5 Use `ansible.builtin.apt_key` or `ansible.legacy.apt_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/install/apt.yml:12 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/install/apt.yml:20 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/install/apt.yml:27 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/install/apt.yml:36 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (copy).
tasks/install/apt.yml:45 Use `ansible.builtin.copy` or `ansible.legacy.copy` instead.

risky-file-permissions: File permissions unset or incorrect. (warning)
tasks/install/apt.yml:45 Task/Handler: Hold specified version during APT upgrade | Package installation

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/install/dnf.yml:5 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/install/dnf.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/install/dnf.yml:24 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/install/dnf.yml:32 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/install/yum.yml:5 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/install/yum.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/install/yum.yml:24 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/install/yum.yml:32 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_vars).
tasks/main.yml:3 Use `ansible.builtin.include_vars` or `ansible.legacy.include_vars` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:14 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:14 Task/Handler: include_tasks precheck.yml

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:17 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:17 Task/Handler: include_tasks params.yml

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:20 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:20 Task/Handler: include_tasks file={{ lookup('first_found', params) }} apply={'tags': ['install'], '__line__': 23, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:32 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:32 Task/Handler: include_tasks file=configure/sys.yml apply={'tags': ['config', 'config_sys'], '__line__': 35, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (meta).
tasks/main.yml:39 Use `ansible.builtin.meta` or `ansible.legacy.meta` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:42 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:42 Task/Handler: include_tasks service.yml

fqcn[action-core]: Use FQCN for builtin module actions (wait_for).
tasks/main.yml:45 Use `ansible.builtin.wait_for` or `ansible.legacy.wait_for` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:51 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:51 Task/Handler: include_tasks file=configure/db.yml apply={'tags': ['config', 'config_db'], '__line__': 54, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:58 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:58 Task/Handler: include_tasks file=configure/dict.yml apply={'tags': ['config', 'config_dict'], '__line__': 61, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/main.yml:65 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/main.yml:65 Task/Handler: include_tasks file=remove.yml apply={'tags': ['remove'], '__line__': 68, '__file__': PosixPath('tasks/main.yml')}

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/params.yml:3 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

fqcn[action-core]: Use FQCN for builtin module actions (set_fact).
tasks/params.yml:7 Use `ansible.builtin.set_fact` or `ansible.legacy.set_fact` instead.

fqcn[action-core]: Use FQCN for builtin module actions (command).
tasks/precheck.yml:1 Use `ansible.builtin.command` or `ansible.legacy.command` instead.

fqcn[action-core]: Use FQCN for builtin module actions (fail).
tasks/precheck.yml:5 Use `ansible.builtin.fail` or `ansible.legacy.fail` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
tasks/remove.yml:3 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (include_tasks).
tasks/remove.yml:15 Use `ansible.builtin.include_tasks` or `ansible.legacy.include_tasks` instead.

name[missing]: All tasks should be named.
tasks/remove.yml:15 Task/Handler: include_tasks remove/{{ ansible_pkg_mgr }}.yml

fqcn[action-core]: Use FQCN for builtin module actions (apt).
tasks/remove/apt.yml:5 Use `ansible.builtin.apt` or `ansible.legacy.apt` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_repository).
tasks/remove/apt.yml:12 Use `ansible.builtin.apt_repository` or `ansible.legacy.apt_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (apt_key).
tasks/remove/apt.yml:18 Use `ansible.builtin.apt_key` or `ansible.legacy.apt_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (dnf).
tasks/remove/dnf.yml:5 Use `ansible.builtin.dnf` or `ansible.legacy.dnf` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/remove/dnf.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/remove/dnf.yml:19 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum).
tasks/remove/yum.yml:5 Use `ansible.builtin.yum` or `ansible.legacy.yum` instead.

fqcn[action-core]: Use FQCN for builtin module actions (yum_repository).
tasks/remove/yum.yml:12 Use `ansible.builtin.yum_repository` or `ansible.legacy.yum_repository` instead.

fqcn[action-core]: Use FQCN for builtin module actions (rpm_key).
tasks/remove/yum.yml:19 Use `ansible.builtin.rpm_key` or `ansible.legacy.rpm_key` instead.

fqcn[action-core]: Use FQCN for builtin module actions (service).
tasks/service.yml:3 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

name[template]: Jinja templates should only be at the end of 'name'
tasks/service.yml:3 Task/Handler: Ensure {{ clickhouse_service }} is enabled: {{ clickhouse_service_enable }} and state: {{ clickhouse_service_ensure }}

jinja[spacing]: Jinja2 spacing could be improved: deb http://repo.yandex.ru/clickhouse/{{ansible_distribution_release}} stable main -> deb http://repo.yandex.ru/clickhouse/{{ ansible_distribution_release }} stable main (warning)
vars/debian.yml:4 Jinja2 template rewrite recommendation: `deb http://repo.yandex.ru/clickhouse/{{ ansible_distribution_release }} stable main`.

You can skip specific rules or tags by adding them to your configuration file:
# .config/ansible-lint.yml
warn_list:  # or 'skip_list' to silence them completely
  - experimental  # all rules tagged as experimental
  - fqcn[action-core]  # Use FQCN for builtin actions.
  - name[missing]  # Rule for checking task and play names.
  - name[template]  # Rule for checking task and play names.

                              Rule Violation Summary                              
 count tag                    profile    rule associated tags                     
     2 jinja[spacing]         basic      formatting (warning)                     
     1 schema[inventory]      basic      core, experimental (warning)             
     1 schema[meta]           basic      core, experimental (warning)             
     9 name[missing]          basic      idiom                                    
     1 name[template]         moderate   idiom                                    
     1 no-free-form           moderate   syntax, risk, experimental (warning)     
     1 risky-file-permissions safety     unpredictability, experimental (warning) 
    63 fqcn[action-core]      production formatting                               

Failed after min profile: 73 failure(s), 6 warning(s) on 57 files.
A new release of ansible-lint is available: 6.12.2 → 6.13.0
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > syntax

playbook: /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/resources/playbooks/converge.yml
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'diff': [], 'dest': '/Users/fon/.cache/molecule/clickhouse/centos_7/Dockerfile_centos_7', 'src': '/Users/fon/.ansible/tmp/ansible-tmp-1676711538.202793-8218-82323436359423/source', 'md5sum': 'e90d08cd34f49a5f8a41a07de1348618', 'checksum': '4b70768619482424811f2977aa277a5acf2b13a1', 'changed': True, 'uid': 501, 'gid': 20, 'owner': 'fon', 'group': 'staff', 'mode': '0600', 'state': 'file', 'size': 2199, 'invocation': {'module_args': {'src': '/Users/fon/.ansible/tmp/ansible-tmp-1676711538.202793-8218-82323436359423/source', 'dest': '/Users/fon/.cache/molecule/clickhouse/centos_7/Dockerfile_centos_7', 'mode': '0600', 'follow': False, '_original_basename': 'Dockerfile.j2', 'checksum': '4b70768619482424811f2977aa277a5acf2b13a1', 'backup': False, 'force': True, 'unsafe_writes': False, 'content': None, 'validate': None, 'directory_mode': None, 'remote_src': None, 'local_follow': None, 'owner': None, 'group': None, 'seuser': None, 'serole': None, 'selevel': None, 'setype': None, 'attributes': None}}, 'failed': False, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
ok: [localhost] => (item=molecule_local/centos:7)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '623461868035.8325', 'results_file': '/Users/fon/.ansible_async/623461868035.8325', 'changed': True, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=7    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_7]

TASK [Apply Clickhouse Role] ***************************************************
ERROR! the role 'ansible-clickhouse' was not found in /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/resources/playbooks/roles:/Users/fon/.cache/molecule/clickhouse/centos_7/roles:/Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook:/Users/fon/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse:/Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/resources/playbooks

The error appears to be in '/Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/resources/playbooks/converge.yml': line 7, column 15, but may
be elsewhere in the file depending on the exact syntax problem.

The offending line appears to be:

      include_role:
        name: ansible-clickhouse
              ^ here

PLAY RECAP *********************************************************************
centos_7                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '-D', '--inventory', '/Users/fon/.cache/molecule/clickhouse/centos_7/inventory', '--skip-tags', 'molecule-notest,notest', '/Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/resources/playbooks/converge.yml']
WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /Volumes/Sklad/GitHub/devops-netology/CI/08-ansible-02-playbook-with-roles/playbook/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /Users/fon/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

> 2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи molecule init scenario --driver-name docker

Вывод ls -la после выполнения инициализации molecule

```sh
fon@fons-Mac-mini vector-role % ls -la
total 16
drwxr-xr-x  13 fon  admin  442 Feb  9 16:42 .
drwxr-xr-x   5 fon  admin  170 Feb  9 16:42 ..
-rw-r--r--@  1 fon  admin  598 Feb  9 16:42 .yamllint
-rw-r--r--   1 fon  admin  355 Feb  7 13:16 README.md
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 defaults
drwxr-xr-x   2 fon  admin   68 Feb  7 11:26 files
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 handlers
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 meta
drwxr-xr-x@  3 fon  admin  102 Feb  9 16:42 molecule
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 tasks
drwxr-xr-x   2 fon  admin   68 Feb  7 11:26 templates
drwxr-xr-x   4 fon  admin  136 Feb  7 11:26 tests
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 vars
```

> 3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

Вывод molecule test --destroy=never. 
```sh 
fon@fons-Mac-mini vector-role % molecule test --destroy=never
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/Users/fon/.cache/ansible-compat/f5bcd7/modules:/Users/fon/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/Users/fon/.cache/ansible-compat/f5bcd7/collections:/Users/fon/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/Users/fon/.cache/ansible-compat/f5bcd7/roles:/Users/fon/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /Users/fon/.cache/ansible-compat/f5bcd7/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
WARNING  Skipping, '--destroy=never' requested.
INFO     Running default > syntax
INFO     Sanity checks: 'docker'

playbook: /Volumes/Sklad/GitHub/ansible-vector/vector-role/molecule/default/converge.yml
INFO     Running default > create
WARNING  Skipping, instances already created.
INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [Ubuntu_latests]
ok: [C8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
skipping: [C8]
ok: [Ubuntu_latests]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [Ubuntu_latests]
ok: [C8]

PLAY RECAP *********************************************************************
C8                         : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
Ubuntu_latests             : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [Ubuntu_latests]
ok: [C8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
skipping: [C8]
ok: [Ubuntu_latests]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [Ubuntu_latests]
ok: [C8]

PLAY RECAP *********************************************************************
C8                         : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
Ubuntu_latests             : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [C8] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [Ubuntu_latests] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
C8                         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
Ubuntu_latests             : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
WARNING  Skipping, '--destroy=never' requested.
```

> Вывод sh с контейнера ubuntu:latest

```sh
# env 
HOSTNAME=Ubuntu_latests
HOME=/root
container=docker
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
DEBIAN_FRONTEND=noninteractive
LC_ALL=C
PWD=/
# systemctl status vector             
vector.service - Vector
    Loaded: loaded (/usr/lib/systemd/system/vector.service, disabled)
    Active: active (running)
```

> Вывод sh с контейнера centos:8

```sh
sh-4.4# env
HOSTNAME=C8
container=oci
PWD=/
HOME=/root
TERM=xterm
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/env
sh-4.4# systemctl status vector
● vector.service - Vector
   Loaded: loaded (/usr/lib/systemd/system/vector.service; disabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-02-10 09:13:14 UTC; 6min ago
     Docs: https://vector.dev
  Process: 276 ExecStartPre=/usr/bin/vector validate (code=exited, status=0/SUCCESS)
 Main PID: 281 (vector)
    Tasks: 6 (limit: 49543)
   Memory: 6.1M
   CGroup: /system.slice/vector.service
           └─281 /usr/bin/vector
```

> 4. Добавьте несколько assert'ов в verify.yml файл для проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

verify.yml

```yml
- name: Verify
  hosts: all
  gather_facts: false
  vars:
    vector_service: 'vector.service'
  tasks:
    - name: 'Gather Local Services'
      ansible.builtin.service_facts:
      become: true
    - name: 'Vector service assert'
      ansible.builtin.assert:
        that:
          - "'{{ vector_service }}' in ansible_facts.services"
          - "'running' == ansible_facts.services[vector_service].state"
```

> Вывод теста после применения verify

```sh
fon@fons-Mac-mini vector-role % molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/Users/fon/.cache/ansible-compat/f5bcd7/modules:/Users/fon/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/Users/fon/.cache/ansible-compat/f5bcd7/collections:/Users/fon/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/Users/fon/.cache/ansible-compat/f5bcd7/roles:/Users/fon/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /Users/fon/.cache/ansible-compat/f5bcd7/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=Ubuntu_latest)
changed: [localhost] => (item=C8)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=Ubuntu_latest)
ok: [localhost] => (item=C8)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /Volumes/Sklad/GitHub/ansible-vector/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'command': '/lib/systemd/systemd', 'dockerfile': 'Dockerfile', 'image': 'ubuntu:latest', 'name': 'Ubuntu_latest', 'pre_build_image': False, 'privileged': True})
ok: [localhost] => (item={'command': '/sbin/init', 'image': 'quay.io/centos/centos:stream8', 'name': 'C8', 'privileged': True})

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'dockerfile': 'Dockerfile', 'image': 'ubuntu:latest', 'name': 'Ubuntu_latest', 'pre_build_image': False, 'privileged': True})
changed: [localhost] => (item={'command': '/sbin/init', 'image': 'quay.io/centos/centos:stream8', 'name': 'C8', 'privileged': True})

TASK [Synchronization the context] *********************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'dockerfile': 'Dockerfile', 'image': 'ubuntu:latest', 'name': 'Ubuntu_latest', 'pre_build_image': False, 'privileged': True})
changed: [localhost] => (item=None)
changed: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item=None)
ok: [localhost] => (item=None)
ok: [localhost]

TASK [Build an Ansible compatible image (new)] *********************************
ok: [localhost] => (item=molecule_local/ubuntu:latest)
ok: [localhost] => (item=molecule_local/quay.io/centos/centos:stream8)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item=None)
ok: [localhost] => (item=None)
ok: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=Ubuntu_latest)
changed: [localhost] => (item=C8)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=None)
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item=None)
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=9    changed=4    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [Ubuntu_latest]
ok: [C8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
skipping: [C8]
changed: [Ubuntu_latest]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [Ubuntu_latest]
changed: [C8]

RUNNING HANDLER [vector-role : Start Vector service] ***************************
changed: [C8]
changed: [Ubuntu_latest]

PLAY RECAP *********************************************************************
C8                         : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
Ubuntu_latest              : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [Ubuntu_latest]
ok: [C8]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
skipping: [C8]
ok: [Ubuntu_latest]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [Ubuntu_latest]
ok: [C8]

PLAY RECAP *********************************************************************
C8                         : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
Ubuntu_latest              : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gather Local Services] ***************************************************
ok: [C8]
ok: [Ubuntu_latest]

TASK [Vector service assert] ***************************************************
ok: [C8] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [Ubuntu_latest] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
C8                         : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
Ubuntu_latest              : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=Ubuntu_latest)
changed: [localhost] => (item=C8)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=Ubuntu_latest)
changed: [localhost] => (item=C8)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

> 5.Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
[TAG -- MOLECULE](https://github.com/fonru/ansible-vector/releases/tag/1.1.0)

-----
## Tox

> 1. Добавьте в директорию с vector-role файлы из директории

```sh
fon@fons-Mac-mini vector-role % ls -la
total 32
drwxr-xr-x  15 fon  admin  510 Feb 10 16:26 .
drwxr-xr-x   5 fon  admin  170 Feb  9 16:42 ..
-rw-r--r--@  1 fon  admin  598 Feb  9 16:42 .yamllint
-rw-r--r--   1 fon  admin  355 Feb  7 13:16 README.md
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 defaults
drwxr-xr-x   2 fon  admin   68 Feb  7 11:26 files
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 handlers
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 meta
drwxr-xr-x@  3 fon  admin  102 Feb  9 16:42 molecule
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 tasks
drwxr-xr-x   2 fon  admin   68 Feb  7 11:26 templates
drwxr-xr-x   4 fon  admin  136 Feb  7 11:26 tests
-rw-r--r--   1 fon  admin   90 Feb 10 16:25 tox-requirements.txt
-rw-r--r--   1 fon  admin  284 Feb 10 16:26 tox.ini
drwxr-xr-x   3 fon  admin  102 Feb  7 11:26 vars
```

> 2. Запустите docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе

```sh
[root@9cde6a3c6b68 vector-role]# env
_CONTAINERS_USERNS_CONFIGURED=
LANG=C.utf8
HOSTNAME=9cde6a3c6b68
which_declare=declare -f
container=oci
PWD=/opt/vector-role
HOME=/root
TERM=xterm
SHLVL=1
MOLECULE_NO_LOG=false
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
BASH_FUNC_which%%=() {  ( alias;
 eval ${which_declare} ) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}
_=/usr/bin/env
```

> 3. Запустил tox в контейнере

```shell
[root@9cde6a3c6b68 vector-role]# tox
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210

py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.4.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.13.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='705659969'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.4.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.13.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='705659969'
py37-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==3.0.1,ansible-core==2.14.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==22.2.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,resolvelib==0.8.1,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.1,text-unidecode==1.3,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='705659969'
py39-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==3.0.1,ansible-core==2.14.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==22.2.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,resolvelib==0.8.1,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.1,text-unidecode==1.3,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='705659969'
py39-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
_________________________________________________________________________________________ summary _________________________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
```

> 4. Создайте облегчённый сценарий для molecule с драйвером molecule_podman. Проверьте его на исполнимость.

```shell
[root@9cde6a3c6b68 vector-role]# molecule init scenario tox_light --driver-name=podman
INFO     Initializing new scenario tox_light...
INFO     Initialized scenario in /opt/vector-role/molecule/tox_light successfully.
```

> Вывод комманды malecule matrix -s tox test некорректный. Выводи постоянно default сценарий. Не понял почему так.

```shell
[root@9cde6a3c6b68 vector-role]# molecule matrix --scenario-name tox test
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - command: /lib/systemd/systemd
    dockerfile: Dockerfile
    image: ubuntu:latest
    name: Ubuntu_latest
    pre_build_image: false
    privileged: true
  - command: /sbin/init
    image: quay.io/centos/centos:stream8
    name: C8
    privileged: true

CRITICAL Failed to pre-validate.

{'driver': [{'name': ['unallowed value docker']}]}
```

molecule.yml
```yaml
dependency:
  name: galaxy
driver:
  name: podman
platforms:
  - name: C8
    image: quay.io/centos/centos:stream8
    command: /sbin/init
    privileged: True

scenario:
  test_sequence:
    - destroy
    - create
    - converge
    - destroy
```

> 5. Пропишите правильную команду в tox.ini для того чтобы запускался облегчённый сценарий.

Прописал

```yml
posargs:molecule test -s tox --destroy always
```

> 6. Запустите команду tox. Убедитесь, что всё отработало успешно.

> Тестирование прошло успешно на версии питон37 и версиях ансибл 210 3

```shell
[root@a1d01361be13 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.14.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='2697676653'
py37-ansible210 run-test: commands[0] | molecule test -s tox
INFO     tox scenario test matrix: destroy, create, converge, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git': 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running tox > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '763293198463.10323', 'results_file': '/root/.ansible_async/763293198463.10323', 'changed': True, 'failed': False, 'item': {'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running tox > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="ubuntu_latest registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: localhost/ubuntu_systemd_latest1") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=ubuntu_latest)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=localhost/ubuntu_systemd_latest1) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="ubuntu_latest command: /lib/systemd/systemd")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=ubuntu_latest: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=ubuntu_latest)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running tox > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
[WARNING]: Updating cache and auto-installing missing dependency: python3-apt
changed: [ubuntu_latest]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [ubuntu_latest]

RUNNING HANDLER [vector-role : Start Vector service] ***************************
changed: [ubuntu_latest]

PLAY RECAP *********************************************************************
ubuntu_latest              : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running tox > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '8698570112.11645', 'results_file': '/root/.ansible_async/8698570112.11645', 'changed': True, 'failed': False, 'item': {'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.14.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='2697676653'
py37-ansible30 run-test: commands[0] | molecule test -s tox
INFO     tox scenario test matrix: destroy, create, converge, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git': 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/my_namespace.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running tox > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '124350397529.11785', 'results_file': '/root/.ansible_async/124350397529.11785', 'changed': True, 'failed': False, 'item': {'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running tox > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="ubuntu_latest registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: localhost/ubuntu_systemd_latest1") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=ubuntu_latest)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=localhost/ubuntu_systemd_latest1) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="ubuntu_latest command: /lib/systemd/systemd")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=ubuntu_latest: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=ubuntu_latest)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running tox > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download and install vector packages for UBUNTU] ***********
[WARNING]: Updating cache and auto-installing missing dependency: python3-apt
changed: [ubuntu_latest]

TASK [vector-role : Download and install vector packages for Centos8] **********
skipping: [ubuntu_latest]

RUNNING HANDLER [vector-role : Start Vector service] ***************************
changed: [ubuntu_latest]

PLAY RECAP *********************************************************************
ubuntu_latest              : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running tox > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '578849601521.13112', 'results_file': '/root/.ansible_async/578849601521.13112', 'changed': True, 'failed': False, 'item': {'command': '/lib/systemd/systemd', 'image': 'localhost/ubuntu_systemd_latest1', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

_______________________________________________________________________________________________________________ summary ________________________________________________________________________________________________________________
  py37-ansible210: commands succeeded
  py37-ansible30: commands succeeded

```
> 7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
[TAG----TOX](https://github.com/fonru/ansible-vector/releases/tag/1.2.0)