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
