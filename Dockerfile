FROM ubuntu:14.04
MAINTAINER AythaE <aythae@GMail.com>

#Add a wheel group with passwordless sudo
RUN groupadd wheel
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#Add user defesti to group wheel and login into it
RUN useradd -m -g wheel defesti
RUN su defesti
RUN cd ~

#Update and upgrade system packages
RUN sudo apt-get -y update && sudo apt-get -y upgrade

#Install required packages
RUN sudo apt-get -y install git
RUN sudo apt-get -y install nodejs
RUN sudo apt-get -y install npm
RUN sudo apt-get -y install mongodb-server
RUN sudo service mongodb restart

#Install required node modules
RUN cd /home/defesti && npm install express
RUN cd /home/defesti && npm install passport
RUN cd /home/defesti && npm install mongoose
