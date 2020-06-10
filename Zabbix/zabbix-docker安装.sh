docker run --name zabbix -t \
    -p 10051:10051 \
    -p 80:80 \
    --restart unless-stopped \
    -d zabbix/zabbix-appliance:centos-latest