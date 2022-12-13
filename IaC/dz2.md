# Задача 1

Установил YC и инициализировал облако

```shell
[admin@localhost ~]$ yc config list
token: ???????????????????????
cloud-id: b1gsr0kdgo2k62r0co5o
folder-id: b1gl9omrk477ufib716u
compute-default-zone: ru-central1-a
```

Далее согласно док-ции YC подключил провайдер к terraform

```shell
[admin@localhost yc]$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.83.0...
- Installed yandex-cloud/yandex v0.83.0 (self-signed, key ID E40F590B50BB8E40)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```


# Задача 2.

> Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?

```text
Ранее мы создавали свои образы спомощью Packer
```

> Ссылку на репозиторий с исходной конфигурацией терраформа.

```text
https://github.com/fonru/devops-netology/tree/main/Terraform
```