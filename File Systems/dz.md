1. Sparse (разряженные) файлы - это файлы, которые сжаты, но не классическим методом, а за счет освобождения блоков
дискового пространства, занятого нулями. Не все приложения поддерживают данный тип файлов, также не все файловые системы
поддерживают данный тип файлов.
---
2. Так как файл и hard link имеют одну и туже inode, поэтому hard-link имеет те же права доступа, владельца и 
время последней модификации, что и целевой файл.
---
4. Не совсем понял почему просят разбить первый диск, если он уже разбит на разделы. Разбил sdb.
````
Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x6546ea79.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G     

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): 

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop /snap/lxd/21835
loop3                       7:3    0   62M  1 loop /snap/core20/1611
loop4                       7:4    0   47M  1 loop /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop /snap/lxd/22753
sda                         8:0    0   64G  0 disk 
├─sda1                      8:1    0    1M  0 part 
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk 
├─sdb1                      8:17   0    2G  0 part 
└─sdb2                      8:18   0  511M  0 part 
sdc                         8:32   0  2.5G  0 disk 
````
---
5. Перенес на sdc:
````
root@vagrant:/home/vagrant# sfdisk -d /dev/sdb | sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x6546ea79.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x6546ea79

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop /snap/lxd/21835
loop3                       7:3    0   62M  1 loop /snap/core20/1611
loop4                       7:4    0   47M  1 loop /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop /snap/lxd/22753
sda                         8:0    0   64G  0 disk 
├─sda1                      8:1    0    1M  0 part 
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk 
├─sdb1                      8:17   0    2G  0 part 
└─sdb2                      8:18   0  511M  0 part 
sdc                         8:32   0  2.5G  0 disk 
├─sdc1                      8:33   0    2G  0 part 
└─sdc2                      8:34   0  511M  0 part 
````
---
6. Собрал:
````root@vagrant:/home/vagrant# mdadm --create --verbose /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
loop3                       7:3    0   62M  1 loop  /snap/core20/1611
loop4                       7:4    0   47M  1 loop  /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdb2                      8:18   0  511M  0 part  
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdc2                      8:34   0  511M  0 part  
````
---
7. Собрал:
````
root@vagrant:/home/vagrant# mdadm --create --verbose /dev/md2 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md2 started.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
loop3                       7:3    0   62M  1 loop  /snap/core20/1611
loop4                       7:4    0   47M  1 loop  /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdb2                      8:18   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdc2                      8:34   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
````
---
8. Создал:
````
root@vagrant:/home/vagrant# pvcreate /dev/md1 /dev/md2
  Physical volume "/dev/md1" successfully created.
  Physical volume "/dev/md2" successfully created.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
loop3                       7:3    0   62M  1 loop  /snap/core20/1611
loop4                       7:4    0   47M  1 loop  /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdb2                      8:18   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdc2                      8:34   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
root@vagrant:/home/vagrant# 
````
---
9. Создал:
````
root@vagrant:/home/vagrant# vgcreate vg1 /dev/md1 /dev/md2
Volume group "vg1" successfully created
  
root@vagrant:/home/vagrant# pvscan 
  PV /dev/sda3   VG ubuntu-vg       lvm2 [<62.50 GiB / 31.25 GiB free]
  PV /dev/md1    VG vg1             lvm2 [<2.00 GiB / <2.00 GiB free]
  PV /dev/md2    VG vg1             lvm2 [1016.00 MiB / 1016.00 MiB free]

````
---
10. Создал:
````
root@vagrant:/home/vagrant# lvcreate -L 100m vg1 /dev/md2
  Logical volume "lvol0" created.
root@vagrant:/home/vagrant# lv
lvchange     lvcreate     lvextend     lvmconfig    lvmdump      lvmsadc      lvreduce     lvrename     lvs          
lvconvert    lvdisplay    lvm          lvmdiskscan  lvmpolld     lvmsar       lvremove     lvresize     lvscan       
root@vagrant:/home/vagrant# lvdisplay 
  --- Logical volume ---
  LV Path                /dev/ubuntu-vg/ubuntu-lv
  LV Name                ubuntu-lv
  VG Name                ubuntu-vg
  LV UUID                mJ8K7e-F4uw-o8Sx-iwt0-JfLQ-Dpoh-E7lSU1
  LV Write Access        read/write
  LV Creation host, time ubuntu-server, 2022-06-07 11:41:15 +0000
  LV Status              available
  # open                 1
  LV Size                <31.25 GiB
  Current LE             7999
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0
   
  --- Logical volume ---
  LV Path                /dev/vg1/lvol0
  LV Name                lvol0
  VG Name                vg1
  LV UUID                Su5dDj-YmPY-ca1o-ucjF-rg12-8vfi-IdoPSb
  LV Write Access        read/write
  LV Creation host, time vagrant, 2022-08-24 11:41:27 +0000
  LV Status              available
  # open                 0
  LV Size                100.00 MiB
  Current LE             25
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:1
````
---
11. Создал:
````
root@vagrant:/home/vagrant# mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

````
---
12. Примаунтил:
````
root@vagrant:/home/vagrant# mkdir /tmp/ololo
root@vagrant:/home/vagrant# mount /dev/vg
vg1/         vga_arbiter  
root@vagrant:/home/vagrant# mount /dev/vg1/lvol0 /tmp/ololo/
root@vagrant:/home/vagrant# df -Th
Filesystem                        Type      Size  Used Avail Use% Mounted on
udev                              devtmpfs  445M     0  445M   0% /dev
tmpfs                             tmpfs      98M 1020K   97M   2% /run
/dev/mapper/ubuntu--vg-ubuntu--lv ext4       31G  3.7G   26G  13% /
tmpfs                             tmpfs     489M     0  489M   0% /dev/shm
tmpfs                             tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs                             tmpfs     489M     0  489M   0% /sys/fs/cgroup
/dev/sda2                         ext4      1.5G  110M  1.3G   8% /boot
/dev/loop1                        squashfs   44M   44M     0 100% /snap/snapd/14978
/dev/loop0                        squashfs   62M   62M     0 100% /snap/core20/1328
/dev/loop2                        squashfs   68M   68M     0 100% /snap/lxd/21835
vagrant                           vboxsf    230G   65G  165G  29% /vagrant
tmpfs                             tmpfs      98M     0   98M   0% /run/user/1000
/dev/loop3                        squashfs   62M   62M     0 100% /snap/core20/1611
/dev/loop4                        squashfs   47M   47M     0 100% /snap/snapd/16292
/dev/loop5                        squashfs   68M   68M     0 100% /snap/lxd/22753
/dev/mapper/vg1-lvol0             ext4       93M   72K   86M   1% /tmp/ololo
````
---
13. Скачал:
````
root@vagrant:/home/vagrant# cd /tmp/ololo/
root@vagrant:/tmp/ololo# ls -lh
total 22M
drwx------ 2 root root 16K Aug 24 13:15 lost+found
-rw-r--r-- 1 root root 22M Aug 24 12:56 test.gz
````
---
14. lsblk
````
root@vagrant:/tmp/ololo# lsblk
\NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
loop3                       7:3    0   62M  1 loop  /snap/core20/1611
loop4                       7:4    0   47M  1 loop  /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdb2                      8:18   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/ololo
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdc2                      8:34   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/ololo
````
---
15. Тест:
````
root@vagrant:/tmp/ololo# gzip -t test.gz 
root@vagrant:/tmp/ololo# echo $?
0
````
---
16. Перенес:
````
root@vagrant:/tmp/ololo# pvmove /dev/md2
  /dev/md2: Moved: 16.00%
  /dev/md2: Moved: 100.00%
root@vagrant:/tmp/ololo# lsblk 
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
loop3                       7:3    0   62M  1 loop  /snap/core20/1611
loop4                       7:4    0   47M  1 loop  /snap/snapd/16292
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/ololo
└─sdb2                      8:18   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/ololo
└─sdc2                      8:34   0  511M  0 part  
  └─md2                     9:2    0 1018M  0 raid0 
root@vagrant:/tmp/ololo# 
````
---
17. Сделал:
````
root@vagrant:/tmp/ololo# mdadm /dev/md1 --fail  /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md1
root@vagrant:/tmp/ololo# mdadm -D /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Wed Aug 24 10:06:32 2022
        Raid Level : raid1
        Array Size : 2094080 (2045.00 MiB 2144.34 MB)
     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Wed Aug 24 13:43:33 2022
             State : clean, degraded 
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              Name : vagrant:1  (local to host vagrant)
              UUID : b5ac3843:aede3dc0:f5d59265:8d4f4528
            Events : 19

    Number   Major   Minor   RaidDevice State
       0       8       17        0      active sync   /dev/sdb1
       -       0        0        1      removed

````
---
18. Вывод dmesg:
````
[ 1347.990205] md/raid1:md1: not clean -- starting background reconstruction
[ 1347.990206] md/raid1:md1: active with 2 out of 2 mirrors
[ 1347.990219] md1: detected capacity change from 0 to 2144337920
[ 1347.992513] md: resync of RAID array md1
[ 1358.145493] md: md1: resync done.
[ 2130.319276] md2: detected capacity change from 0 to 1067450368
[12951.353909] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[12951.353923] ext4 filesystem being mounted at /tmp/ololo supports timestamps until 2038 (0x7fffffff)
[14368.589790] md/raid1:md1: Disk failure on sdc1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.
````
---
19. Проверка целостности:
````
root@vagrant:/tmp/ololo# gzip -t test.gz 
root@vagrant:/tmp/ololo# echo $?
0
````
---
20. Машинку потушил:
````
root@vagrant:/tmp/ololo# gzip -t test.gz 
root@vagrant:/tmp/ololo# echo $?
0
````
