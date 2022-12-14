#!/bin/bash

sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
#sudo yum search docker
#sudo yum info docker
#sudo yum install -y docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
#id ec2-user
#newgrp docker
sudo systemctl enable docker
#sudo systemctl start docker.service
sudo yum install -y git
docker --version
git --version
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#su - jenkins
#cd /var/lib/jenkins/
#mkdir .aws 