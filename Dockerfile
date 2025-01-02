FROM amazonlinux:2023

## yum 대신 dnf 해도 무방

# 업데이트
RUN yum update

# iputils : ping, systemd : systemctl, hostname : hostname, vim : vim, net-tools : ifconfig, netstat
# procps : ps, htop : htop, wget : wget, glibc-langpack-ko -y : 한글설정
RUN yum -y install iputils systemd hostname vim net-tools procps htop wget glibc-langpack-ko -y

# erlang-26.2.5.6
RUN yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v26.2.5.6/erlang-26.2.5.6-1.amzn2023.aarch64.rpm -y

# rabbitmq-server-3.13.7 
RUN yum install https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.13.7/rabbitmq-server-3.13.7-1.el8.noarch.rpm -y

# CP
# WORKDIR /etc/rabbitmq
# COPY rabbitmq.conf .

# CP profile
WORKDIR /home/oywuser
COPY .profile .
COPY once.sh .
COPY add-user.sh .
RUN chmod +x once.sh
RUN chmod +x add-user.sh

# 시스템환경 설정
CMD ["/sbin/init"]