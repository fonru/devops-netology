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
