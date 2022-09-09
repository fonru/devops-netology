1. На Linux комманда `ip a` на WIN `ipconfig /all`
````
vagrant@vagrant:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86379sec preferred_lft 86379sec
    inet6 fe80::a00:27ff:fea2:6bfd/64 scope link 
       valid_lft forever preferred_lft forever
````
----
2. Протокол lldp. Ставим пакет lldpd. Коммандой `lldpcli -show neighbors` получаем список нейборов.
````
  SysDescr:     US-48-G1, 5.76.7.13442, Linux 3.6.5
    Capability:   Bridge, on
  Port:        
    PortID:       local Port 38
    PortDescr:    4_R03_S43
    TTL:          120
````
----
3. Технология VLAN. В Debian можно отредактировать файл `/etc/network/interfaces` добавим следующий конфиг.
Создается сабинтерфейс с vlan id 100.
````
##vlan с ID-100 для интерфейса eth0 with ID - 100 в Debian/Ubuntu Linux##
auto eth0.100
iface eth0.100 inet static
address 192.168.1.200
netmask 255.255.255.0
vlan-raw-device eth0
````
----
4. Можно поставить пакет `ifenslave`.  Собрать бонд из нескольких интерфейсов. Варианты балансировки active\slave.
````
# modprobe bonding
# ifconfig bond0 192.168.0.1 netmask 255.255.0.0
# ifenslave bond0 eth0 eth1

````
----
5. В 29 сети 6 хостов. Из 24 подсети можно получить 32 (29 сетей). 10.10.10.0/29 10.10.10.8/29 10.10.10.8/29 
----
6. Подойдет сеть 100.64.0.0/26
----
7. Просмотр arp таблицы `ip neigh show (Linux)`, `arp -a (Win)` . 
Удалить весь arp кэш `ip -s -s neigh flush all (Linux)`,  `arp -d (Win)`
Удалить определенную запись `arp -d {ip-address} (linux и win)`, 