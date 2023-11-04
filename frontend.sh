code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

echo -e "\e[35mInstalling nginx\e[0m"
dnf install nginx -y &>>${log_file}

echo -e "\e[35mRemoving old Content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}

echo -e "\e[35mDownload FrontEnd Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

echo -e "\e[35mExtracting Downloaded FrontEnd\e[0m"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}

echo -e "\e[35mCopying Nginx Config for Roboshop\e[0m" &>>${log_file}
pwd &>>${log_file}
ls -l &>>${log_file}
#cp Configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf#
cp ${code_dir}/Configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "\e[35mEnabling nginx\e[0m"
systemctl enable nginx &>>${log_file}

echo -e "\e[35mStarting nginx\e[0m"
systemctl restart nginx &>>${log_file}

## Roboshop Config is not copied
## If any command is errored or failed, we need to stop the script

