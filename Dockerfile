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

# Sudo for Jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install RVM
RUN sudo -u jenkins bash -c "HOME=/home/jenkins gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; curl -sSL https://get.rvm.io | HOME=/home/jenkins bash -s stable"

# Install NodeJS
RUN apt-get install -y nodejs 

# Install AWS cli
RUN apt-get install -y python-pip
RUN pip install awscli

# Install git
RUN apt-get install -y git

# General building tools
RUN apt-get install -y libxml2-dev libxslt1-dev zlib1g-dev libmysqlclient-dev libsqlite3-dev libgmp-dev

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
