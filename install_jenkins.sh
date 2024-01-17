#!/bin/bash

# Jenkins Master (Instance 1)
sudo apt update
sudo apt install openjdk-17-jre -y
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

sudo visudo
echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

sudo su - jenkins <<'EOF'
ssh-keygen -t rsa -b 4096 -m PEM
EOF

# Jenkins Slave (Instance 2)
sudo adduser jenkins --gecos ""
sudo visudo
echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

su jenkins <<'EOF'
sudo nano /etc/ssh/sshd_config
# Set PasswordAuthentication yes
sudo service sshd restart

sudo apt update
sudo apt install openjdk-17-jre -y
mkdir /home/jenkins/jenkins-agent
ssh-keygen -t rsa -b 4096 -m PEM
EOF

# Connect Jenkins Master and Slave
sudo su - jenkins <<'EOF'
ssh-copy-id jenkins@<slave-private-ip>
ssh jenkins@<jenkins-slave-private-ip>
EOF

# Jenkins Master Configuration (Continue from previous script)
# ... (Follow the steps in the previous response to configure master and agent)

# Final Jenkins Slave Configuration
su jenkins <<'EOF'
ssh-keygen -t rsa -b 4096 -m PEM
EOF
