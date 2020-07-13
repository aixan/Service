#!/bin/bash

#卸载旧版软件
yum remove libzip cmake

#创建用户
useradd -M -s /sbin/nologin nginx

#解决依赖
yum -y install wget php-mcrypt libmcrypt libmcrypt-devel php-pear libxml2 libxml2-devel curl curl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel openssl openssl-devel gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel gcc gcc-c++ autoconf automake sqlite-devel oniguruma oniguruma-devel

#添加搜索路径到配置文件
cat >> /etc/ld.so.conf << "EOF"
/usr/local/lib64
/usr/local/lib
/usr/lib
/usr/lib64
EOF
ldconfig -v

#安装cmake3.16.4
wget https://cmake.org/files/v3.16/cmake-3.16.4-Linux-x86_64.tar.gz 
tar xf cmake-3.16.4-Linux-x86_64.tar.gz
mv cmake-3.16.4-Linux-x86_64 /usr/local/cmake
cat >> /etc/profile.d/cmake.sh << "EOF"
export PATH=$PATH:/usr/local/cmake/bin
EOF
source /etc/profile

#安装libzip 1.6.1
wget https://libzip.org/download/libzip-1.6.1.tar.gz
tar -zxvf libzip-1.6.1.tar.gz
cd libzip-1.6.1
mkdir build && cd build
cmake ..
make && make install


./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/ \
--enable-fpm  \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv-dir \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl --enable-mbregex \
--enable-mbstring \
--with-mcrypt \
--enable-ftp \
--with-gd \
--enable-gd-native-ttf \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--without-pear \
--with-gettext \
--disable-fileinfo \
--enable-maintainer-zts

make -j4 && make install

cp /usr/local/src/php-5.6.13/php.ini-production /usr/local/php/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/src/php-5.6.13/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

chmod +x /etc/init.d/php-fpm && chkconfig php-fpm on
/etc/init.d/php-fpm start


# vim conf/httpd.conf
# # 添加
# LoadModule php5_module        /usr/lib64/httpd/modules/libphp5.so
# 
# vim conf.d/php.conf
# 
# <IfModule worker.c>
#   LoadModule php5_module modules/libphp5.so
# </IfModule>
# 
# AddHandler php5-script .php
# AddType text/html .php
# 
# DirectoryIndex index.php