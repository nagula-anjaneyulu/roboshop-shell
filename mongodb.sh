cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y



## Edit the file and replace 127.0.0.1 to 0.0.0.0
sed -e 's|127.0.0.1|0.0.0.0|' /etc/mongodb.conf

systemctl enable mongod

systemctl restart mongod