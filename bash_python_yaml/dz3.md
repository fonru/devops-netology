1. Правильный вид json:
````
   {
   	"info": "Sample JSON output from our service\t",
   	"elements": [{
   		"name": "first",
   		"type": "server",
   		"ip": 7175
   	}, {
   		"name": "second",
   		"type": "proxy",
   		"ip": "71.78.22.43"
   	}]
   }
````
---

2. Скрипт:
````
import socket
import json
import yaml

url_list_cache = {'drive.google.com': '', 'mail.google.com': '', 'google.com': ''}
while True:
    for i in url_list_cache.items():
        ip = socket.gethostbyname(i[0])
        if i[1] != ip:
            print(f'[ERROR] {i[0]} IP mismatch: <старый {i[1]}> <Новый {ip}>')
            url_list_cache.update({i[0]: ip})
        else:
            print(f'{i[0]} - {i[1]}')
        with open(f'{i[0]}.json', 'w') as json_out:
            json_out.write(json.dumps({f'{i[0]}': f'{ip}'}))
        with open(f'{i[0]}.yaml', 'w') as yaml_out:
            yaml.dump([{f'{i[0]}': f'{ip}'}], yaml_out)
````
Вывод:
````
[ERROR] drive.google.com IP mismatch: <старый > <Новый 142.250.74.142>
[ERROR] mail.google.com IP mismatch: <старый > <Новый 142.250.74.101>
[ERROR] google.com IP mismatch: <старый > <Новый 142.250.74.174>
drive.google.com - 142.250.74.142
mail.google.com - 142.250.74.101
google.com - 142.250.74.174
drive.google.com - 142.250.74.142
mail.google.com - 142.250.74.101
google.com - 142.250.74.174
````
Файл google.com.json:```{"google.com": "142.250.74.174"}```

Файл mail.google.com.json:```{"mail.google.com": "142.250.74.101"}```

Файл drive.google.com.json:```{"drive.google.com": "142.250.74.142"}```

Файл google.com.yaml:```- google.com: 142.250.74.174```

Файл mail.google.com.yaml:```- mail.google.com: 142.250.74.101```

Файл drive.google.com.yaml:```- drive.google.com: 142.250.74.142```
