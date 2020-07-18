#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import os
import sys
import json
import time
import urllib3
import importlib

importlib.reload(sys)
urllib3.disable_warnings()


def sendmessage(user, subject, content, token):
    n = 0
    webhook = "https://oapi.dingtalk.com/robot/send?access_token=%s" % token
    data = {
        "msgtype": "text",
        "text": {
            "content": subject + '\n' + content
        },
        "at": {
            "atMobiles": [
                user
            ],
            "isAtAll": False
        }
    }
    # headers = {'Content-Type': 'application/json; charset=UTF-8'}
    headers = {'Content-Type': 'application/json'}
    x = requests.post(url=webhook, data=json.dumps(data), headers=headers)
    print(x.text)  # 请求返回内容
    print(x.status_code)  # 请求返回状态
    while x.json()['errcode'] != 0 and n < 4:
        n += 1
        x = requests.post(url=webhook, data=json.dumps(data), headers=headers)
    return x.json()


if __name__ == '__main__':
    user = sys.argv[1]                                                                # zabbix传过来的第一个参数
    subject = str(sys.argv[2])                                                        # zabbix传过来的第二个参数
    content = str(sys.argv[3])                                                        # zabbix传过来的第三个参数

    token = "token"
    dingding = sendmessage(user, subject, content, token)
