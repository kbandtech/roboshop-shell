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
