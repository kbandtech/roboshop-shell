source common.sh

print_head "Installing nginx"
dnf install nginx -y &>>${log_file}

print_head "Removing old Content"
rm -rf /usr/share/nginx/html/* &>>${log_file}

print_head "Download FrontEnd Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

print_head "Extracting Downloaded FrontEnd" 
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}

print_head "Copying Nginx Config for Roboshop" 
pwd &>>${log_file}
ls -l &>>${log_file}
#cp Configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf#
cp ${code_dir}/Configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

print_head "Enabling nginx"
systemctl enable nginx &>>${log_file}

print_head "Starting nginx"
systemctl restart nginx &>>${log_file}

## Roboshop Config is not copied
## If any command is errored or failed, we need to stop the script
# Status of a command need to be printed


