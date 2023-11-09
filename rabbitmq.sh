source common.sh

roboshop_app_password=$1
if [ -z "${roboshop_app_password}" ]; then
 echo -e "\e[31mMissing MySQL Root Password argument\e[0m"
 exit 1
 
fi

print_head "Setup Erlang repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head "Setup RabbitMQ repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head "Setup Erlang & RabbitMQ"
dnf install rabbitmq-server erlang -y &>>${log_file}
status_check $?


print_head "Enable RabbitMQ Service"
systemctl enable rabbitmq-server &>>${log_file}
status_check $?

print_head "Start RabbitMQ Service"
systemctl start rabbitmq-server &>>${log_file}
status_check $?

print_head "Add Application User"
rabbitmqctl add_user roboshop ${roboshop_app_password} &>>${log_file}
status_check $?

print_head "Configure Permissions for Application User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status_check $?
