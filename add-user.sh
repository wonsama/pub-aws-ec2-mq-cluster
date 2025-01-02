# wonsama 계정 추가 및  guest 계정 삭제
rabbitmqctl add_user wonsama wonsama
rabbitmqctl set_user_tags wonsama administrator
rabbitmqctl set_permissions wonsama ".*" ".*" ".*"
rabbitmqctl delete_user guest
echo "http://localhost:15601"
