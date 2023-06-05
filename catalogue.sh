echo -e "\e[36m>>>>>>>>>>Configuring node js repos<<<<<<<\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>>Install node js repos<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>>Add Application user<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>Create Application Directory<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>>>>>download app content<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

cd /app
echo -e "\e[36m>>>>>>>>>>unzip app content<<<<<<<\e[0m"

unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m>>>>>>>>>>Install node js dependencies<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>>>Copy catalogue systemd service file<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>>>start catalogue service<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[36m>>>>>>>>>>Copy mongodb repos<<<<<<<\e[0m"

cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>>Install mongodb client<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>Load schema<<<<<<<\e[0m"
mongo --host mongodb-dev.devopsanji72.online </app/schema/catalogue.js
