# block-clouds
Блокировка облачных провайдеров на уровне iptables. В текущий момент блокируются 4 крупнейших облака: AWS (Amazon), Google Cloud, Oracle Cloud, Microsoft Azure.

Для корректной работы скрипта должны быть установлены curl, jq, iptables-persistent.

Запуск скрипта:
```
apt update
apt install -y curl jq iptables-persistent
systemctl enable netfilter-persistent.service
wget https://raw.githubusercontent.com/lexandr0s/block-clouds/main/block_cl.sh -O block_cl.sh
chmod +x block_cl.sh
./block_cl.sh
```
Блокируются более 30 тыс. подсетей и адресов. Поэтому скрипт отрабатывает довольно долго. 10-15 минут.

Правила iptables будут восстанавливаться после перезагрузки. Для очистки правил блокировки, необходимо выполнить следующие команды:
```
iptables -F BLCLOUD
iptables -X BLCLOUD
iptables-save > /etc/iptables/rules.v4
```
