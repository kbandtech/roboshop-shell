source common.sh

print_head "Setup MongoDB repository"
cp ${code_dir}/Configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
status_check $?

print_head "Install MongoDB"
dnf install mongodb-org -y &>>${log_file}
status_check $?

print_head "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}
status_check $?

print_head "Enable MongoDB"
systemctl enable mongod &>>${log_file}
status_check $?

print_head "Start MongoDB Service"
systemctl restart mongod &>>${log_file}
status_check $?


#update /etc/mongod.conf file from 127.0.0.0 with 0.0.0.0
