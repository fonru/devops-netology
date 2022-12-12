# Задача 1. Выбор инструментов.

> Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?

```text
Исходя из водных данных, на первых этапах этапе я выбрал бы изменяемый тип т.к частые релизы (придется часто пересобирать образы),а в дальнейшем при получении стабильной версии приклада переходил бы на неизменяемый тип, т.к. может потребоваться машстабируемость проекта, а для этого необходимо сократить проблемы с сдигом конфигурации. В неизменяемой инфраструктуре все поднимается из обкатанного образа, что повышает стабильность конечного продукта.
- 
```

> Будет ли центральный сервер для управления инфраструктурой?

```text
Предлагаю центральный сервер Terraform развернуть на отдельном кластере серверов
```

> Будут ли агенты на серверах?

```text
Будем использовать Ansible и Terraform, поэтому агенты не нужны.
```

> Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?

```text
Terraform - инициализация ресурса 
Ansible - управления конфигурацией

>Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?\
Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?\

```text
Основные инструменты Terraform + Ansible + Docker + Kuber
Для создания образов продолжил бы пользоваться Packer. Bash скрипты постарался бы перевести на ansible, CI\CD перевел бы на Jenkins или же GitLab. Необходимости в Сloud Formation при использовании TerraForm не вижу. 
```

> Если для ответа на эти вопросы недостаточно информации, то напишите какие моменты уточните на совещании.

```text
Я бы уточнил, где будет размещена инфраструктура. В арендованом облаке\дц или же собственная инфраструктура. Это бы наверно сказалось на выборе некоторых инструментов.
```

---

# Задача 2 и 3 . Установка терраформ и поддержка legacy кода.

```shell
[admin@localhost terraform_old]$ ./terraform --version
Terraform v0.12.31

Your version of Terraform is out of date! The latest version
is 1.3.6. You can update by downloading from https://www.terraform.io/downloads.html
[admin@localhost terraform_old]$ terraform --version
Terraform v1.3.6
on linux_amd64
```