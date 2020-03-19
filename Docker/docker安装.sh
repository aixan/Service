yum install -y yum-utils device-mapper-persistent-data lvm2
yum remove docker docker-io docker-selinux python-docker-py
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum -y install docker-ce
[ -e /etc/docker ] || mkdir /etc/docker/
cat > /etc/docker/daemon.json << "EOF"
{
  "registry-mirrors": ["https://oitxg1ek.mirror.aliyuncs.com"] 
}
EOF
systemctl daemon-reload
systemctl enable docker && systemctl restart docker && systemctl status docker
