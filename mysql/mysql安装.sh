# 卸载系统自带boost、mysql、mariadb
yum -y remove boost-* mysql mariadb-*
# 安装依赖包
yum -y install gcc gcc-c++ autoconf automake zlib* libxml* ncurses-devel libtool-ltdl-devel* make cmake
# 下载解压mysql源码包
wget https://svnet.cn/aixan/File/raw/master/Mysql/mysql-boost-5.7.29.tar.gz
tar xf mysql-boost-5.7.29.tar.gz -C /usr/local/src/ ; cd /usr/local/src/mysql-5.7.29/
# 创建mysql运行用户
useradd -M -s /sbin/nologin mysql
#创建安装目录和数据存放目录（生产环境建议增加一块硬盘挂载作mysql目录）
mkdir -p /usr/local/mysql/data
#源码编译安装
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DSYSCONFDIR=/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/usr/local/mysql/data/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=/usr/local/src/mysql-5.7.29/boost/boost_1_59_0
#编译的参数可以参考http://dev.mysql.com/doc/refman/5.6/en/source-configuration-options.html
make && make install
# 添加环境变量
cat > /etc/profile.d/mysql.sh < "EOF"
export PATH=$PATH:/usr/local/mysql/bin 
EOF
# 创建my.cnf配置文件
cat > /etc/my.cnf < "EOF"
[mysqld]
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
port=3306
socket=/usr/local/mysql/data/mysql.sock
character-set-server=utf8
log-error=/var/log/mysqld.log
pid-file=/tmp/mysqld.pid
explicit_defaults_for_timestamp=true
EOF
# 创建启动脚本
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chown -R mysql:mysql /usr/local/mysql
# 初始化数据库
/etc/init.d/mysqld start
rm -rf /usr/local/mysql/data
/usr/local/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
/etc/init.d/mysqld start
mysql_secure_installation