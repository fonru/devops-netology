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
