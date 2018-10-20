#!/bin/bash
LANG=en_US.UTF-8
apt-get update
apt-get install -y rabbitmq-server
sudo service rabbitmq-server restart
sudo rabbitmq-plugins enable rabbitmq_management
sudo rabbitmqctl add_user admin password 
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
sudo service rabbitmq-server stop
sudo echo "AFYDPNYXGNARCABLNENP" > /var/lib/rabbitmq/.erlang.cookie
sudo killall -u rabbitmq
sudo service rabbitmq-server start
sudo rabbitmqctl stop_app
sudo rabbitmqctl reset
master_hostname="${master_dns}"
dns=`echo "$master_hostname"|cut -f1 -d '.'`
echo "This is master DNS $dns"
while true;do rabbitmqctl status -n rabbit@$dns &>/dev/null; if [ "$?" -eq 0 ]; then     break; fi; done
sudo rabbitmqctl join_cluster --ram rabbit@$dns
sudo rabbitmqctl start_app
