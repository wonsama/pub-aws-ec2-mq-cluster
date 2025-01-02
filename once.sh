#!/usr/bin/bash
localectl set-locale ko_KR.UTF-8
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server
wget http://localhost:15672/cli/rabbitmqadmin
chmod +x rabbitmqadmin
mv rabbitmqadmin /usr/local/bin
rabbitmqctl stop_app
rabbitmqctl reset
