### Задача 1
- Аппаратная виртуализация - реализовывается на основе аппаратного решения. 
ОС работает непосредственно с железом.
- Паравиртуализация - реализовывается с использованием программного гипервизора установленного на ОС,
а ядро гостевой ОС модернизируется. При этом гостевая ОС взаимодействует не с железом, а с программным
интерфейсом гипервизора.
- Виртуализация на уровне ОС - реализовывается за счет создания контейнеров гостевых ОС, используя ядро 
основной ОС.

---

### Задача 2

- Высоконагруженная база данных - физический сервер т.к. при таком подходе можно организовать максимальную
производительность+ подключенная отдельно хранилка.
- Различные web-приложения - виртуализация на уровне ОС, т.к. самое удобное для раскатки \администрирования 
при развертки web-серверов
на базе контейнеров.
- Windows системы для бухгалтерии - паравертуализация \ физический сервер, тут сложно ответить однозначно, т.к.
непонятно какая система необходима бухгалтерии. Если это buisness critical система, то наверно лучше реализовать
на отдельно сервере, если просто нужно какие то win-приклады запускать то можно воспользовать и паравиртуализацией.
- Системы на GPU - думаю что исключительно серверное решение, для получения максимальной производительности.

---

### Задача 3
1. Думаю аппратаный гипервизор будет оптимальным решением.VMware ESXI \ vSphere будет оптимальным решением для данной 
задачи, т.к. можно реализовать кластеризацию, балансировку и бекапирование.
2. PROXMOX(KVM). OpenSource, который позволит решить данную проблему.
3. Hyper-V - microsoft гипервизор, который заточен на виртуализацию windows хостов.
4. Тут можно использовать и docker, если ПО предоставляется в виде контейнеров, а можно паравиртуализацию типа
VirtualBox, VMWare workstation. Быстрое для установки решение.

---

### Задача 4
Нормально администрировать гетерогенную среду мне кажется невозможно (сложно), т.к. распределять аппаратные ресурсы,
мигрировать виртуальные машины, использовать сетевые хранилища будет невозможно если, они будут использовать общее железо.
Был опыт такой и все сводиться к невозможности нормально миграции машин из одного гипервизора в другой.
