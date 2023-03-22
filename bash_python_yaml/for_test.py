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
