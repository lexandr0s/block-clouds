# block-clouds
Блокировка облачных провайдеров на уровне iptables. В текущий момент блокируются 4 крупнейших облака: AWS (Amazone), Google Cloud, Oracle Cloud, Microsoft Azure.

Для корректной работы скрипта должны быть установлены curl, jq, iptables-persistent.

```
apt update
apt install -y curl jq iptables-persistent
systemctl enable netfilter-persistent.service
```

Правила iptables будут восстанавливаться после перезагрузки. Для очистки правил блокировки, необходимо выполнить следующие команды:
```
iptables -F BLCLOUD
iptables -X BLCLOUD
iptables-save >> /etc/iptables/rules.v4
```
