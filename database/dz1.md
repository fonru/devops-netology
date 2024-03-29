### Задача 1
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определенных данных.\
Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:
- Электронные чеки в json виде
> NoSQL - key-value, т.к. по сути json это словарь, который легко распарсить и записать в такую базу, а чек можно представить в виде ключа - значения.

- Склады и автомобильные дороги для логистической компании
> NoSQL - графовая, т.к. по сути склады и дороги можно представить как граф с различными связями (дорогами) между вершинами (складами).

- Генеалогические деревья
> Мне кажется тут нужна иерархическая база, потому что генеалогическое дерево это и есть иерархическая база:) 

- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации
> Думаю NOSQL - семейство столбцов, т.к. этот тип оптимален для  регистрации и обработки различных данных, связанных со временем

- Отношения клиент-покупка для интернет-магазина
> Думаю, что также необходима реляционная база данных, потому что необходимо ввести статистику не только по конкретному покупателю, но и в целом "что покупают", "когда покупают" и т.п. Такая база позволит проводить аналитику \ статистику.

---

### Задача 2
Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись)
>AP - система будет доступна и отказоустойчива, но при этом консистентность данных не гарантируется

- При сетевых сбоях, система может разделиться на 2 раздельных кластера
>CA - система  разделяется на различные сервера, при этом реплики данных одинаковы

- Система может не прислать корректный ответ или сбросить соединение
>СP - система обеспечивает целостность данных и способна работать в условиях распада в ущерб доступности, не выдавая отклик на запрос

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?
>PA/EC - при наличии сетевого разделения системы ставка делается на доступность, а при отсутствии распределения – на консистентность
PA/EL - высокая доступность  при разделении  системы иначе высокая скорость ответа 
PC/EC - упор на консистентность данных

---
### Задача 3
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?
> Сочетание в рамках одной системы сложно представить, потому что эти принципы являются антиподами друг другу. ACID больше подходит там, где применяются реляционные базы данных, BASE для систем где четкость данных не является приоритетом.

### Задача 4
Вам дали задачу написать системное решение, основой которого бы послужили:

фиксация некоторых значений с временем жизни
реакция на истечение таймаута
Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора данной системы?

>Как я понимаю речь идет о Redis. Основной минус данной системы в том, что данные в момент работы хранятся в оперативной памяти, поэтому максимальный ее объем зависит от объема RAM. А также не поддерживает язык SQL.
