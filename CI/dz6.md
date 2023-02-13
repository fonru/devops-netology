# Основная часть

>1. В виртуальном окружении создать новый my_own_module.py файл

```shell
(venv) fon@fons-Mac-mini ansible % touch my_own_module.py
(venv) fon@fons-Mac-mini ansible % ls -la | grep my_own_module.py
-rw-r--r--   1 fon  admin      0 Feb 13 12:00 my_own_module.py
```

>2. Наполнить его содержимым:

```shell
(venv) fon@fons-Mac-mini ansible % cat my_own_module.py 
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        new=dict(type='bool', required=False, default=False)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = 'goodbye'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['new']:
        result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```

>3. Заполните файл в соответствии с требованиями ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре path, с содержимым, определённым в параметре content.

Часть py файла модуля с основной функцией. Добавлена функция file_create с параметрами file_path и file_content, 
создает по указанному пути файл с определенным содержимым

```py
from ansible.module_utils.basic import AnsibleModule

def file_create(file_path,file_content):
    f = open(f"{file_path}", "w")
    f.write(f"{file_content}")
    f.close()

def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)
    
    file_create(module.params['path'], module.params['content'])
    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = "File with path " + module.params['path'] + " was created with content -->" + module.params['content']
    result['message'] = 'Create file complete'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['path']:
        result['changed'] = True

    # # during the execution of the module, if there is an exception or a
    # # conditional state that effectively causes a failure, run
    # # AnsibleModule.fail_json() to pass in the message and the result
    # if module.params['name'] == 'fail me':
    #     module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```

>4. Проверьте module на исполняемость локально.

Файл json в тестовыми параметрами для модуля

```json
{
    "ANSIBLE_MODULE_ARGS": {
        "path": "/Volumes/Sklad/GitHub/ansible/ansible/lib/ansible/modules/testfile.txt", 
        "content": "my_test_content_mfonarev"
    }
}
```

Состояние директории до запуска модуля

```sh
(venv) fon@fons-Mac-mini modules % pwd   
/Volumes/Sklad/GitHub/ansible/ansible/lib/ansible/modules
(venv) fon@fons-Mac-mini modules % ls -la | grep testfile
(venv) fon@fons-Mac-mini modules %
```

Запускаем модуль

```sh
(venv) fon@fons-Mac-mini ansible % python3 -m ansible.modules.my_own_module /Volumes/Sklad/GitHub/ansible/test_json.json

{"changed": false, "original_message": "File/Volumes/Sklad/GitHub/ansible/ansible/lib/ansible/modules/testfile.txt was created with contentmy_test_content_mfonarev", "message": "goodbye", "invocation": {"module_args": {"path": "/Volumes/Sklad/GitHub/ansible/ansible/lib/ansible/modules/testfile.txt", "content": "my_test_content_mfonarev"}}}
(venv) fon@fons-Mac-mini ansible % 
```

Состояние директории после запуска модуля. Файлик создался и заполнился контентом.

```sh 
(venv) fon@fons-Mac-mini ansible % ls -la lib/ansible/modules/ | grep testfile.txt && cat lib/ansible/modules/testfile.txt 
-rw-r--r--   1 fon  admin      24 Feb 13 14:22 testfile.txt
my_test_content_mfonarev%                                                                                                                                                                                            
(venv) fon@fons-Mac-mini ansible % 
```

>5.6.7 Запускаем модуль в playbook и выходим из venv

```sh
(venv) fon@fons-Mac-mini ansible % ansible-playbook site.yml -v
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a rapidly changing
source of code and can become unstable at any point.
No config file found; using defaults
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [My own module test] ********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Create file] ***************************************************************************************************************************************************************************************************
changed: [localhost] => {"changed": true, "message": "Create file complete", "original_message": "File with path /Volumes/Sklad/GitHub/test_file.txt was created with content -->playbook_run_test"}

PLAY RECAP ***********************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

(venv) fon@fons-Mac-mini ansible % deactivate 
fon@fons-Mac-mini ansible %   
```

>8. Инициализируйте новую collection: ansible-galaxy collection init my_own_namespace.yandex_cloud_elk

```sh
fon@fons-Mac-mini ansible % ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a rapidly changing
source of code and can become unstable at any point.
- Collection my_own_namespace.yandex_cloud_elk was created successfully
```

>9. В данную collection перенесите свой module в соответствующую директорию.

```sh
fon@fons-Mac-mini modules % pwd
/Volumes/Sklad/GitHub/ansible/ansible/my_own_namespace/yandex_cloud_elk/plugins/modules
fon@fons-Mac-mini modules % ls -la
total 16
drwxr-xr-x  3 fon  admin   102 Feb 13 15:01 .
drwxr-xr-x  4 fon  admin   136 Feb 13 15:00 ..
-rw-r--r--  1 fon  admin  4380 Feb 13 15:01 my_own_module.py
```

>10-16. Задания

main task роли create_file
```yml
---
- name: Create file
  my_own_module:
    path: "{{ default_path }}"
    content: "{{ default_content }}"
```

Далее я сделал билд коллекции и установил ее
```sh
fon@fons-Mac-mini yandex_cloud_elk % ansible-galaxy collection build
Created collection for my_own_namespace.yandex_cloud_elk at /Volumes/Sklad/GitHub/ansible/ansible/my_own_namespace/yandex_cloud_elk/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz

fon@fons-Mac-mini yandex_cloud_elk % ansible-galaxy collection install my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz 
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.yandex_cloud_elk:1.0.0' to '/Users/fon/.ansible/collections/ansible_collections/my_own_namespace/yandex_cloud_elk'
my_own_namespace.yandex_cloud_elk:1.0.0 was installed successfully
```

Далее создал отдельную папку под архив с коллекцией и там создал плейбук.

playbook
```yaml
---
- hosts: localhost
  collections:
    - my_own_namespace.yandex_cloud_elk
  tasks:
    - import_role:
        name: create_file
```

Запуск плейбука
```sh

fon@fons-Mac-mini test_collection_dir % pwd
/Volumes/Sklad/GitHub/ansible/ansible/test_collection_dir
fon@fons-Mac-mini test_collection_dir % ls -la
total 24
drwxr-xr-x  4 fon  admin   136 Feb 13 16:37 .
drwxr-xr-x  4 fon  admin   136 Feb 13 16:36 ..
-rw-r--r--  1 fon  admin  6439 Feb 13 16:34 my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz
-rw-r--r--  1 fon  admin   131 Feb 13 16:41 site.yml
fon@fons-Mac-mini test_collection_dir % ansible-playbook site.yml -v
No config file found; using defaults
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [localhost] *****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [my_own_namespace.yandex_cloud_elk.create_file : Create file] ***************************************************************************************************************************************************
changed: [localhost] => {"changed": true, "message": "Create file complete", "original_message": "File with path /Volumes/Sklad/GitHub/test_file.txt was created with content -->my_test_content_mfonarev"}

PLAY RECAP ***********************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

[ССЫЛКА на тег 1.0.0](https://github.com/fonru/my_own_collection/releases/tag/1.0.0)

[Ссылка на архив с коллекцией](https://github.com/fonru/my_own_collection/blob/main/test_collection_dir/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz)