# block-clouds
Блокировка облачных провайдеров на уровне iptables. В текущий момент блокируются 4 крупнейших облака: AWS (Amazone), Google Cloud, Oracle Cloud, Microsoft Azure.

Для корректной работы скрипта должны быть установлены curl, jq, iptables-persistent.

```
apt update
apt install -y curl jq iptables-persistent
systemctl enable netfilter-persistent.service
```
Блокируются более 30 тыс. подсетей и адресов. Поэтому скрипт отрабатывает довольно долго. 10-15 минут.

Правила iptables будут восстанавливаться после перезагрузки. Для очистки правил блокировки, необходимо выполнить следующие команды:
```
iptables -F BLCLOUD
iptables -X BLCLOUD
iptables-save >> /etc/iptables/rules.v4
```
