# Base on latest LTS
FROM ubuntu:14.04
MAINTAINER Gregory Doran <greg@gregorydoran.co.uk>

# Install general stuff
RUN apt-get update
RUN apt-get install -y openssh-server curl openjdk-7-jdk
RUN mkdir /var/run/sshd
RUN adduser --quiet jenkins
RUN sudo -u jenkins mkdir /home/jenkins/.ssh
RUN sudo -u jenkins mkdir /home/jenkins/workspace
COPY key.pub /home/jenkins/.ssh/authorized_keys

# Install RVM
RUN sudo -u jenkins bash -c "HOME=/home/jenkins gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; curl -sSL https://get.rvm.io | HOME=/home/jenkins bash -s stable"

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | sudo -u jenkins HOME=/home/jenkins bash -l

# Install AWS cli
RUN apt-get install -y python-pip
RUN pip install awscli

# Install git
RUN apt-get install -y git

# Sudo for Jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
