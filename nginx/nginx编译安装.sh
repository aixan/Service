# 创建运行用户
useradd -M -s /sbin/nologin nginx
# 安装依赖环境
yum install -y make gcc gcc-c++ openssl openssl-devel bzip2-devel libxml2 libxml2-devel curl-devel libmcrypt-devel libjpeg libjpeg-devel libpng libpng-devel autoconf automake zlib zlib-devel
# 下载解压源文件
wget https://svnet.cn/File/Pcre/pcre-8.44.tar.gz
tar xf pcre-8.44.tar.gz -C /usr/local/src/
wget https://svnet.cn/File/Nginx/nginx-1.16.1.tar.gz
tar xf nginx-1.16.1.tar.gz -C /usr/local/src/
# nginx调优
vim src/core/nginx.h
vim src/http/ngx_http_header_filter_module.c
vim src/http/ngx_http_special_response.c
# 切换目录编译NGINX
cd /usr/local/src/nginx-1.16.1
./configure --prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_dav_module \
--with-http_sub_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_stub_status_module \
--with-http_addition_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--with-pcre=/usr/local/src/pcre-8.44 \
make -j 4 && make install
# 添加环境变量
cat > /etc/profile.d/nginx.sh < "EOF"
export PATH=$PATH:/usr/local/nginx/sbin
EOF
source /etc/profile
# 添加运行脚本
cat > /etc/init.d/nginx < "EOF"
#!/bin/bash
# chkconfig: - 99 2
# description: Nginx Service Control Script
PROG="/usr/local/nginx/sbin/nginx"
PIDF="/usr/local/nginx/logs/nginx.pid"
case "$1" in
        start)
        $PROG
        ;;
        stop)
        kill -3 $(cat $PIDF)
        ;;
        restart)
        $0 stop &> /dev/null
        if [ $? -ne 0 ] ; then continue ; fi
        $0 start
        ;;
        reload)
        kill -1 $(cat $PIDF)
        ;;
        *)
        echo "Userage: $0 { start | stop | restart | reload }"
        exit 1
esac
exit 0
EOF
chmod +x /etc/init.d/nginx && chkconfig --add nginx && chkconfig nginx on