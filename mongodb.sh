source common.sh

print_head "Setup MongoDB repository"
cp Configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install MongoDB"
dnf install mongodb-org -y

print_head "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_head "Enable MongoDB"
systemctl enable mongod 

print_head "Start MongoDB Service"
systemctl restart mongod


#update /etc/mongod.conf file from 127.0.0.0 with 0.0.0.0
