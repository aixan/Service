
## 二进制 部署
注意你部署Dashboard的命名空间（之前部署默认是kube-system，新版是kubernetes-dashboard）

1、 删除默认的secret，用自签证书创建新的secret

```
kubectl delete secret kubernetes-dashboard-certs -n kubernetes-dashboard
kubectl create secret generic kubernetes-dashboard-certs \
--from-file=/opt/kubernetes/ssl/server-key.pem --from-file=/opt/kubernetes/ssl/server.pem -n kubernetes-dashboard
```

2、修改 dashboard.yaml 文件，在args下面增加证书两行

```
       args:
         # PLATFORM-SPECIFIC ARGS HERE
         - --auto-generate-certificates
         - --tls-key-file=server-key.pem
         - --tls-cert-file=server.pem
kubectl apply -f kubernetes-dashboard.yaml
```





# kubeadm 部署
注意你部署Dashboard的命名空间（之前部署默认是kube-system，新版是kubernetes-dashboard）

1、删除默认的secret，用自签证书创建新的secret

```
kubectl delete secret kubernetes-dashboard-certs -n kubernetes-dashboard
kubectl create secret generic kubernetes-dashboard-certs \
--from-file=/etc/kubernetes/pki/apiserver.key --from-file=/etc/kubernetes/pki/apiserver.crt -n kubernetes-dashboard
```



2、修改 dashboard.yaml 文件，在args下面增加证书两行

```
       args:
         # PLATFORM-SPECIFIC ARGS HERE
         - --auto-generate-certificates
         - --tls-key-file=apiserver.key
         - --tls-cert-file=apiserver.crt
kubectl apply -f kubernetes-dashboard.yaml
```

