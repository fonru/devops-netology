1. ***cd*** является терминальной командой. Является собственной(внутренней) 
коммандой оболочки shell/bash. Является именно такой, потому что она предназначена
для изменения текущей рабочей директории пользователя, поэтому (как я понимаю) она и 
не может быть командой внешних оболочек, т.к. работает в текущем терминале пользователя.
---
2. ***grep <some_string> <some_file> -c***
---
3. ***systemd***
---
4. Например вот такой вариант ***f$ ls fdfdfg &> /dev/pts/1***
---
5. Да, например так ***cat < test_file > test_file2***
---
6. Да можно, но вывода мы не увидим, так как необходимо будет переключиться из граффический
интерфейс и (если необходимо обратно) с помощью сочетания ***ctrl + alt + {f1..f6} или 
{f7}*** для возврата в граффический интерфейс. 
---
7. ***bash 5>&1*** добавит новый дискриптор и перенаправит его в stdout.
Поэтому, когда мы выполняем команду ***echo netology > /proc/$$/fd/5*** происходит вывод
в 5 файл дискриптор, а затем уже в stdout, потому что мы прописали ***bash 5>&1***
---
8. ***ls fdfkldfkd 5>&2 2>&1 1>&5 | grep directory*** в дискриптор 5 перенаправим stderr в stdin
, затем в stderr перенаправим в stdin, а в конце в stdout перенаправим в дискриптор 5.
В итоге мы сможем грепнуть текст из ошибки выполенния команды ***ls fdfkldfkd***
---
9. ***cat /proc/$$/environ*** выведет переменные окружения.
Можно также вывести командой ***printenv***
---
10. ***/proc/<PID>/cmdline*** - содержит описание команду запуска процесса
***/proc/<PID>/exe*** - содержит ссылку на сам исполняемый файл процесса
---
11. ***cat /proc/cpuinfo | grep sse*** - версия 4.2
---
12. По умолчанию  tty не связано с удаленной ssh сессий,
а лишь после успешной авторизации пользователя. Чтоб добиться вывода надо дабавить параметр ***-t***
тем самым зафорсить привязать псевдотерминал и выполнить комманду внутри него.
---
13. Запустил ***top*** . После чего отправил его в фоновый режим. Через ***jobs -l ***
нашел PID запущенного процесса ***top***. Затем открыл новый ***pts*** с помощью ***screen***.
после коммандой reptyre <PID> (подставил PID процесса) перенес из раннее открого pts процесс в новый.
---
14. ***tee*** принимает stdin и одновременно записывает его в stdout и в файл.
Поэтому ***sudo tee*** позволяет сразу вывести в файл /root/new_file

