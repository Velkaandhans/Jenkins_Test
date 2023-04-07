sudo apt update -y

#installing apache2 server if not installed
if ! dpkg -s apache2 &> /dev/null; then
        sudo apt -y install apache2
fi

#checking apache2 is runnig
if ! systemctl is-active apache2 &> /dev/null; then
        sudo systemctl start apache2
fi

#to enable service while booting up
sudo systemctl enable apache2

#timestamp,name,S3 bucket declaration
timestamp=$(date +"%m%d%Y-%H%M%S") 
name="vel"

#genrating tar file
sudo tar -cvf /tmp/$name-httpd-logs-$timestamp.tar /var/log/apache2/*.log

#creating inventory if not exist
if [ ! -f "/var/www/html/inventory.html" ]; then
        sudo touch /var/www/html/inventory.html
        echo -e "Log Type\tDate Created\tType\tSize" >> /var/www/html/inventory.html
fi
#finding size of tar files
size=$(du -h /tmp/$name-httpd-logs-$timestamp.tar |awk '{print $1}')

#appending inventory file
echo -e "Httpd-logs\t$timestamp\ttar\t$size" >> /var/www/html/inventory.html
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
