docker run --name nginx -t \
-p 80:80 -p 443:443 \
-v /data/nginx/html:/usr/share/nginx/html \
-v /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
-v /data/nginx/logs:/var/log/nginx \
-v /data/nginx/conf.d:/etc/nginx/conf.d \
-v /data/nginx/ssl:/etc/nginx/ssl \
--link php-fpm:php-fpm \
--restart=always \
-d nginx:latest