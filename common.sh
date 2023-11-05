code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
    echo -e "\e[36m$1\e[0m"
}

status_check() {
    if [ $1 -eq 0 ]; then
     echo SUCCESS
     
    else
     echo FAILURE
     echo "Read the log file ${log_file} for more infromation about the error"
     exit 1
     
    fi
}

NODEJS() {
   
    print_head "Configure NodeJS Repo"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
    status_check $?
    
    print_head "Install NodeJS"
    dnf install nodejs -y &>>${log_file}
    status_check $?
    
    print_head "Create Roboshop ${component}"
    id roboshop &>>${log_file}
    if [ $? -ne 0 ]; then
     ${component}add roboshop &>>${log_file}
    fi 
    status_check $?
    
    print_head "Create Application Directory"
    if [ ! -d /app ]; then
     mkdir /app &>>${log_file}
    fi 
    status_check $?
    
    print_head "Delete Old Content"
    rm -rf /app/* &>>${log_file}
    status_check $?
    
    print_head "Downloading App Content"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    cd /app 
    status_check $?
    
    print_head "Extracting App Content"
    unzip /tmp/${component}.zip &>>${log_file}
    cd /app
    status_check $?
    
    print_head "Installing NodeJS Dependencies"
    npm install &>>${log_file}
    status_check $?
    
    print_head "Copy SystemD Service file"
    cp ${code_dir}/Configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
    status_check $?
    
    print_head "Reload SystemD"
    systemctl daemon-reload &>>${log_file}
    status_check $?
    
    print_head "Enable ${component} Service"
    systemctl enable ${component} &>>${log_file}
    status_check $?
    
    print_head "Start ${component} Service"
    systemctl restart ${component} &>>${log_file}
    status_check $?
    
    print_head "Copy MongoDB Repo File"
    cp ${code_dir}/Configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
    status_check $?
    
    print_head "Install Mongo Client"
    dnf install mongodb-org-shell -y &>>${log_file}
    status_check $?
    
    print_head "Load Schema"
    mongo --host mongodb.devopsb71.icu </app/schema/${component}.js &>>${log_file}
    status_check $?

}