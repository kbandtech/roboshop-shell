curl -sL https://rpm.nodesource.com/setup_lts.x | bash
dnf install nodejs -y
useradd roboshop
mkdir /app
rm -rf /app/*
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install
cp Configs/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

cp Configs/mongodb.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongodb.devopsb71.icu </app/schema/catalogue.js