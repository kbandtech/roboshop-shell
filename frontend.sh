dnf install nginx -y
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
systemctl enable nginx 
systemctl start nginx

## Roboshop Config is not copied
## If any command is errored or failed, we need to stop the script
