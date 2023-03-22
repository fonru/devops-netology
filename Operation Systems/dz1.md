1. Насколько я понимаю происходит вызов ***chdir("/tmp")***
---
2. Если я все правильно понял, то из файла ***/usr/share/misc/magic.mg***
---
3. Запустил тестовый python скрипт с выводом ***python3 test.py > outfile***.
С помощью комманды ***ps aux | grep python***.

````
python3 10391  fon    1w   REG  253,0        0 13412257 /home/fon/outfile (deleted)
````
Далее перейти в каталог и выполнить комманду ***echo -n > 1***
```
fon@zxcbook:/proc/10391/fd$ ls -lh
total 0
lrwx------ 1 fon fon 64 Aug 12 11:19 0 -> /dev/pts/0
l-wx------ 1 fon fon 64 Aug 12 11:19 1 -> '/home/fon/outfile (deleted)'
lrwx------ 1 fon fon 64 Aug 12 11:19 2 -> /dev/pts/0
````
---
<p>4. Процессы-зомби характеризуются тем, что они выполняться уже не могут (они же завершились), но 
ресурсы системы по-прежнему занимают</p>

5. Часть вывода
````
vagrant@vagrant:~$ sudo /usr/sbin/opensnoop-bpfcc 
PID    COMM               FD ERR PATH
897    vminfo              4   0 /var/run/utmp
693    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
693    dbus-daemon        21   0 /usr/share/dbus-1/system-services
693    dbus-daemon        -1   2 /lib/dbus-1/system-services
````
---
6.Системный вызов ***uname()***
````
Part of the utsname information is also accessible via
       /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}
````
---
7. ***&&*** оператор AND, при котором вторая комманда выполнится при условии
успешного выполнения первой. ***;*** последовательное выполнение команд
При применение ***set -e*** игнорируются ошибки оператора при применении ***&&&***.
Исходя из чего смысла думаю нет)
---
8. Из опций: 
````
-e  Exit immediately if a command exits with a non-zero status.
-x  Print commands and their arguments as they are executed.
-u  Treat unset variables as an error when substituting
pipefail     the return value of a pipeline is the status of
                           the last command to exit with a non-zero status,
                           or zero if no command exited with a non-zero status
````

<p>Можно использовать для повышения уровня логирования, 
также позволяет завершить сценарий при появлении ошибок (non zero status или же ошибок в переменных и их аргументах)</p>
---
9. 
````~$ ps -o stat
STAT
Ss
R+
````
Ss - ожидающие завершения 
R+ - запущенные