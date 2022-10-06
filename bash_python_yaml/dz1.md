1. Вывод:
````
c=a+b - так как это вывод строки 
d=1+2 - по сути вывод той же строки, только с подстановкой переменной
e=3 - происходит суммирование перменных,а уже потом их вывод
````
----
2. В скрипте нет прерывания цикла. Ниже мне кажется правильный скрипт.
````
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
		date >> curl.log
	else
	    break
	fi
done
````
----
3. Скрипт:
````
#!/bin/bash

iplist=(192.168.0.1 173.194.222.21 87.250.250.242)
while true
do
for i in ${iplist[*]}
do
	for x in {1..5}
	do
		curl --max-time 3 http://$i &>> script.log
	done
done
done
````
----
4. Скрипт:
````
#!/bin/bash

iplist=(192.168.0.1 173.194.222.21 87.250.250.242)
while true
do
for i in ${iplist[*]}
do
	for x in {1..5}
	do
		curl --max-time 3 http://$i &>> script.log
		result=$?
		if test "$result" = "28"
		then
			echo "Ip $i is unrecheable" >> error.log
			break 3
		fi
	done
done
done
````
----

