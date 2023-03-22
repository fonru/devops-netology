1. Вопрос: Какое значение будет присвоено переменной c?

   Ответ: Ошибка т.к. нельзя складывать число со строкой.

   Вопрос: Как получить для переменной c значение 12?

   Ответ:``c = str(a) + b``

   Вопрос: Как получить для переменной c значение 3?

   Ответ: ``c = a + int(b)``
---
2. Рабочий скрипт:
````
import os

bash_command = ["cd ~/PycharmProjects/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        for file in [prepare_result]:
            # print(file)
            full_path = os.popen(f"cd ~/PycharmProjects/devops-netology && readlink -e {file}").read()
            print(file, full_path)
````

Вывод:
````
.gitignore /home/mfonarev/PycharmProjects/devops-netology/.gitignore

.idea/workspace.xml /home/mfonarev/PycharmProjects/devops-netology/.idea/workspace.xml

bash_python_yaml/dz1.md /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/dz1.md

bash_python_yaml/dz2.md /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/dz2.md

bash_python_yaml/for_test.py /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/for_test.py

ololo /home/mfonarev/PycharmProjects/devops-netology/ololo
````
---
3. Рабочий скрипт:
````
#!/usr/bin/python3

import os
import sys

bash_command = [f"cd {sys.argv[1]}", "git status"]

result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        for file in [prepare_result]:
            # print(file)
            full_path = os.popen(f"cd {sys.argv[1]} && readlink -e {file}").read()
            print(file, full_path)
````

Вывод:
````
mfonarev@root-ubuntu:~/PycharmProjects/devops-netology/bash_python_yaml$ ./for_test.py /home/mfonarev/PycharmProjects/devops-netology
.idea/workspace.xml /home/mfonarev/PycharmProjects/devops-netology/.idea/workspace.xml

bash_python_yaml/dz2.md /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/dz2.md

bash_python_yaml/for_test.py /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/for_test.py

````
---

4. Скрипт(первый проход всегда с ошибкой, потому значения словаря пустые. Ждал минут 10, так и не дождался, чтоб поменялись ip адреса):
````
import socket

url_list_cache = {'drive.google.com': '', 'mail.google.com': '', 'google.com': ''}


while True:
    for i in url_list_cache.items():
        ip = socket.gethostbyname(i[0])
        if i[1] != ip:
            print(f'[ERROR] {i[0]} IP mismatch: <старый {i[1]}> <Новый {ip}>')
            url_list_cache.update({i[0]: ip})
        else:
            print(f'{i[0]} - {i[1]}')
````

Вывод:
````
/usr/bin/python3.10 /home/mfonarev/PycharmProjects/devops-netology/bash_python_yaml/for_test.py 
[ERROR] drive.google.com IP mismatch: <старый > <Новый 173.194.221.194>
[ERROR] mail.google.com IP mismatch: <старый > <Новый 142.250.74.37>
[ERROR] google.com IP mismatch: <старый > <Новый 142.250.74.174>
drive.google.com - 173.194.221.194
mail.google.com - 142.250.74.37
google.com - 142.250.74.174
````