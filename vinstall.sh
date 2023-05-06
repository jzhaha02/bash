#!/bin/bash
#这一行是表示使用 /bin/bash 作为脚本的解释器

curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

sudo systemctl start docker

docker pull v2ray/official

mkdir /etc/v2ray
touch /etc/v2ray/config.json

echo '{"inbounds":[{"port":25456,"protocol":"vmess","settings":{"clients":[{"id":"625addd7-7af2-87fc-0bcc-e3531abc086b","alterId":16}]}}],"outbounds":[{"protocol":"freedom","settings":{}}],"log":{"access":"/etc/v2ray/access.log","error":"/etc/v2ray/error.log","loglevel":"info"}}' > /etc/v2ray/config.json

docker run -d --name v2ray \
-v /etc/v2ray:/etc/v2ray -p 25456:25456 \
v2ray/official  v2ray -config=/etc/v2ray/config.json