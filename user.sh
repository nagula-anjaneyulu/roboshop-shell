
echo -e "\e[36m>>>>>>>>>>Configuring NodeJs repos<<<<<<<\e[0m
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>>Install NodeJs<<<<<<<\e[0m
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>>Add application user<<<<<<<\e[0m
useradd roboshop

echo -e "\e[36m>>>>>>>>>>Create Application Directory<<<<<<<\e[0m
rm -rf /app
mkdir /app


echo -e "\e[36m>>>>>>>>>>Download app content<<<<<<<\e[0m
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m>>>>>>>>>>Unzip app content<<<<<<<\e[0m
unzip /tmp/user.zip


echo -e "\e[36m>>>>>>>>>>Install Nodejs Dependencies<<<<<<<\e[0m
npm install

echo -e "\e[36m>>>>>>>>>>Install Redis repos<<<<<<<\e[0m
cp /home/centos/roboshop-shell/.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>>>Start User service<<<<<<<\e[0m
systemctl daemon-reload
systemctl enable user
systemctl start user

echo -e "\e[36m>>>>>>>>>>Copy mongodb repos<<<<<<<\e[0m
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>>>Install mongodb client<<<<<<\e[0m
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>Load schema<<<<<<<\e[0m
mongo --host mongodb-dev.devopsanji72.online </app/schema/user.js