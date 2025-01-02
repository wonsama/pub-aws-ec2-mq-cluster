# pub-aws-ec2-mq-cluster

## 개요

- amazon linux 2 도커 이미지를 사용하여 rabbit mq cluster 를 구성하는 예제
- ec2 장비에 mq cluster 를 구성하기 전 사전 확인 사항을 정리

## Dockerfile 생성

`Dockerfile` 파일 참조

```bash
docker build -t al2023:latest -f Dockerfile . --no-cache
```

## 컨테이너 실행 및 접속

```bash
# 1번 노드 실행 및 접속
docker run -d -p 15601:15672 -p 5601:5672 -v $(pwd)/.erlang.cookie:/var/lib/rabbitmq/.erlang.cookie --privileged --name mq1 --net mqcluster al2023:latest
docker exec -it mq1 /bin/bash

# 2번 노드 실행 및 접속
docker run -d -p 15602:15672 -p 5602:5672 -v $(pwd)/.erlang.cookie:/var/lib/rabbitmq/.erlang.cookie --privileged --name mq2 --net mqcluster al2023:latest
docker exec -it mq2 /bin/bash

# 3번 노드 실행 및 접속
docker run -d -p 15603:15672 -p 5603:5672 -v $(pwd)/.erlang.cookie:/var/lib/rabbitmq/.erlang.cookie --privileged --name mq3 --net mqcluster al2023:latest
docker exec -it mq3 /bin/bash
```

## 터미널 접속 후 실행

```bash
# LANG 설정
source ./.profile
# rabbitMQ 활성화 처리
./once.sh
```

## 클러스터링

```bash
# 최초 1,2,3 노드 정지 상태에서 작업 진행

# 1번노드 실행
rabbitmqctl start_app

# 2번노드 클러스터링
# <hostname> 에 해당 하는 건 1번 노드의 컨테이너 아이디 임 12자리 ex) 6802c9ec386d
rabbitmqctl join_cluster rabbit@<hostname>
rabbitmqctl start_app

# 3번노드 클러스터링
# <hostname> 에 해당 하는 건 1번 노드의 컨테이너 아이디 임 12자리 ex) 6802c9ec386d
rabbitmqctl join_cluster rabbit@<hostname>
rabbitmqctl start_app

# 1번노드 계정 추가
./add-user.sh

# 사이트 접속
# 현재는 포트포워드 해 놓아서 그런데 추후에는 15672 포트로 접속
# http://localhost:15672
http://localhost:15601

```

## 참조링크

- [https://www.rabbitmq.com/docs/clustering](https://www.rabbitmq.com/docs/clustering)
- [datadog-rabbitmq](https://docs.datadoghq.com/ko/integrations/rabbitmq/?tab=host)
