```
Docker中国区官方镜像(http://www.docker-cn.com/registry-mirror)
https://registry.docker-cn.com
网易
http://hub-mirror.c.163.com
ustc
https://docker.mirrors.ustc.edu.cn
阿里云
https://oitxg1ek.mirror.aliyuncs.com

mkdir /etc/docker/
vim /etc/docker/daemon.json

{
  "registry-mirrors": ["https://oitxg1ek.mirror.aliyuncs.com"]
  "registry-mirrors": ["https://registry.docker-cn.com"]
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
  "registry-mirrors": ["https://reg-mirror.qiniu.com"]
  "registry-mirrors": ["https://mirror.ccs.tencentyun.com"]
  "registry-mirrors": ["https://dockerhub.azk8s.cn"]
  "registry-mirrors": ["http://f1361db2.m.daocloud.io"]  
}
systemctl daemon-reload
systemctl enable docker && systemctl restart docker && systemctl status docker
```