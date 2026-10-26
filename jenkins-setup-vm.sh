#!/bin/bash

#installing java
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version

#installing jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

#enabling and starting the service
sudo systemctl start jenkins
sudo systemctl enable jenkins