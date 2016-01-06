# Base on latest LTS
FROM ubuntu:14.04

# Install general stuff
RUN apt-get update
RUN apt-get install -y openssh-server curl openjdk-6-jdk
RUN mkdir /var/run/sshd
RUN adduser jenkins
RUN sudo -u jenkins mkdir /home/jenkins/.ssh
COPY key.pub /home/jenkins/.ssh/authorized_keys

# Install RVM
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | sudo -u jenkins HOME=/home/jenkins bash -l

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
