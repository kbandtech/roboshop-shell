cp Configs/mongodb.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod 
systemctl start mongod

#update /etc/mongod.conf file from 127.0.0.0 with 0.0.0.0