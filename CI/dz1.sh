#!/bin/bash

echo "Start centos7 container"
docker run -ti -d --name centos7 centos sh

echo "Start ubuntu container"
docker run -ti -d --name ubuntu ubuntu sh

echo "Start ubuntu container"
docker run -ti -d --name fedora fedora sh

sleep 15

echo "Run ansible playbook"
ansible-playbook -i /Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/inventory/prod.yml /Volumes/Sklad/GitHub/mnt-homeworks/08-ansible-01-base/playbook/site.yml

