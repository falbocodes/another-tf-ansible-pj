#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "###"
whoami
echo "yum update and isntall packages"
yum -y update && yum install epel-release -y

yum install -y git unzip ansible

echo "Install awscli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip
./aws/install

sleep 60
echo "Get sshkey"
whoami
aws ssm get-parameter --name "/ssh/ec2/anothe-tf-ansible-pj" --with-decryption --output text --query Parameter.Value >> ~/.ssh/id_rsa

chmod 0600 ~/.ssh/id_rsa && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts \
    chmod 0600 ~/.ssh/known_hosts
