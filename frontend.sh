code_dir=$(pwd)


echo -e "\e[35mInstalling nginx\e[0m"
dnf install nginx -y

echo -e "\e[35mRemoving old Content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35mDownload FrontEnd Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[35mExtracting Downloaded FrontEnd\e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

echo -e "\e[35mCopying Nginx Config for Roboshop\e[0m"
pwd
ls-l
cp ${code_dir}/Configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35mEnabling nginx\e[0m"
systemctl enable nginx 

echo -e "\e[35mStarting nginx\e[0m"
systemctl restart nginx

## Roboshop Config is not copied
## If any command is errored or failed, we need to stop the script

