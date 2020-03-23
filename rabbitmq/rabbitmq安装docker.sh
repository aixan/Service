#管理页面  http://IP:15672/#/   # guest  guest
docker run --hostname rabbitmq --name rabbit -t \
    -e RABBITMQ_DEFAULT_USER=root \
    -e RABBITMQ_DEFAULT_PASS=Az32729842+-. \
    -p 15672:15672 -p 5672:5672 \
    --restart=always \
    -d rabbitmq:management