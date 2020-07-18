# IPMI查看服务器SN
    ipmitool -I lanplus -H 10.84.31.147 -U admin -P admin fru list | grep "Product Serial"