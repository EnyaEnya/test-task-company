# Тестовое задание: моделирование фирмы по производству продукции

Необходимо смоделировать работу фирмы по производству некоторого набора продуктов.
## Функциональные требования:
Для производства каждого продукта необходим некоторый набор исходных материалов. Цена продукта складывается из цен
исходных материалов. Покупатель обращается в фирму с заказом на один из производимых ею продуктов в необходимом ему
количестве. В случае, если в данный момент фирма не может произвести нужное количество товара, то клиент получает отказ.
Если же товар есть, то товар поставляется покупателю, а деньги переходят на счет фирмы.
Поставщик обращается в фирму с предложением о поставке некоторого исходного материала. Если в фирме имеется достаточная
сумма, то происходит покупка, иначе же поставщик получает отказ. В самом начале работы фирма имеет определенную сумму на
своем счету. В любой момент времени фирма должна быть способна предоставить отчет о состоянии своего счета, статистике
обработки заказов и количестве материалов на складе.

### Серверная часть
В качестве сервера должен выступать REST-сервис, эмулирующий работу фирмы.
### Клиентская часть
В качестве клиента должен выступать нагрузочный-тест, эмулирующий процесс заказов и поставок.