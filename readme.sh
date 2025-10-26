########################################################################
Use this file to setup and work with applications
1. the terraform module will deploy ec2 instace in aws, then 
execute remote exec where it intalls the docker, pull django app and build container 
of django app then run it.
########################################################################
# help command baked in to the cli.
terraform version
terraform -help
terraform init
terraform validate
terraform plan -out basic.tfplan
terraform apply "basic.tfplan"
terraform destroy

########################################################################
Installing and working with Jenkins
########################################################################
#!/bin/bash
sudo apt update -y
sudo apt install openjdk-21-jdk -y

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# Need to give 8080 custom tcp rule to security group if not there
# home directory of jenkins
ls -l /var/lib/jenkins


#Jenkins page
http://52.87.164.33:8080/

# admin admin@123 admin@test.com
# url set else jenkins will be slow
http://jenkinsexamplepunit.xyz
http://ec2-52-87-242-72.compute-1.amazonaws.xyz:8080/

# first time ask for password 
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


sudo systemctl stop jenkins
sudo apt-get remove --purge jenkins
sudo rm -rf /var/lib/jenkins

####################################################
install_jenkins.sh

#! /bin/bash
sudo apt update -y

# Install Java SDK 11
sudo apt install -y openjdk-11-jdk

# Download and Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt upgrade -y
sudo apt -y install jenkins

# Start Jenkins
sudo systemctl start jenkins

# Enable Jenkins to run on Boot
sudo systemctl enable jenkins
sudo systemctl status jenkins

###########################################
# To install and run django using jenkins in ec2
###########################################
sudo usermod -aG sudo jenkins
sudo vi /etc/sudoers
jenkins ALL=(ALL) NOPASSWD : ALL
cat /var/lib/jenkins/secrets/initialAdminPassword

# Give all below commands in jenkins shell in build step
python3 -V
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install python3-pip -y 
sudo apt-get install python3-venv -y
python3 -m venv djangoEnv
# . /var/lib/jenkins/workspace/install_django/djangoEnv/bin/activate
. $PWD/djangoEnv/bin/activate
sudo chmod +x ./djangoEnv/bin/activate
source ./djangoEnv/bin/activate
pip -V
# sudo apt install python3-django
pip3 install django
sudo rm -rf student/
git clone https://github.com/punit10/django_student_app.git student
pip3 install pillow
cd student
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:8000

# Building image using docker
# Install SSH Agents plugin
docker build -t djangoapp:v1 .
docker run -d --name django_web -p 8000:8000 djangoapp:v1

###########################################
Python on docker on ec2
###########################################
https://github.com/arunksingh16/python_website.git
https://medium.com/techbull/ci-cd-using-jenkins-docker-on-aws-ec2-ubuntu-server-9389786bbc7c
image creation leonardo 
face swap https://remaker.ai/face-swap-free/
video from image and audi script hedra
veed.io to generate subtitle 
elevel labs for audio from text