rabbitmqctl add_user aims aims
rabbitmqctl set_user_tags aims administrator
rabbitmqctl set_permissions aims ".*" ".*" ".*"
rabbitmqctl delete_user guest
echo "http://localhost:15601"
