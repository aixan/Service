docker run --name mysql -t -e \
MYSQL_ROOT_PASSWORD="Az1234567890." \
-v /data/mysql/data:/var/lib/mysql \
-v /data/mysql/conf:/etc/mysql/conf.d \
-p 3306:3306 \
--restart=always \
--character-set-server=utf8 \
--collation-server=utf8_bin \
-d mysql:5.7