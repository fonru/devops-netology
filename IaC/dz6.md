# Задача 1

>Найдите, где перечислены все доступные resource и data_source, приложите ссылку на эти строки в коде на гитхабе.

[Все доступные resource](https://github.com/hashicorp/terraform-provider-aws/blob/d9290535ae088a600ddec41fe63e899185d74b56/internal/provider/provider.go#L943)

[Все доступные datasource](https://github.com/hashicorp/terraform-provider-aws/blob/d9290535ae088a600ddec41fe63e899185d74b56/internal/provider/provider.go#L419)

> Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.
> С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.

[описание ресурса aws_sqs_queue](https://github.com/hashicorp/terraform-provider-aws/blob/1076f598ee88175e7409c5887edcf87e6cbeab20/internal/service/sqs/queue.go#L88)

>Какая максимальная длина имени?
Какому регулярному выражению должно подчиняться имя?

`^[a-zA-Z0-9_-] и максимальной длинной в 80 символов {1,80}
[ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/d9290535ae088a600ddec41fe63e899185d74b56/internal/service/sqs/queue.go#L430)
# Задача 2

Доберусь чуть позже