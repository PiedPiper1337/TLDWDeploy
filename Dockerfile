#java docker image pulls from ubuntu 14:04
FROM java:latest
MAINTAINER Brian Zhao version 0.1

#https://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :10

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y Xvfb && \
    apt-get install -y mysql-server-5.5 && \
    apt-get install -y apt-transport-https && \
    apt-get install -y git && \
    apt-get -y upgrade

#https://github.com/github/git-lfs/wiki/Installation
RUN echo 'deb http://http.debian.net/debian wheezy-backports main' > /etc/apt/sources.list.d/wheezy-backports-main.list && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y git-lfs && \
    git lfs install

#https://askubuntu.com/questions/79280/how-to-install-chrome-browser-properly-via-command-line
#https://askubuntu.com/questions/510056/how-to-install-google-chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable

WORKDIR /root

#for local testing:
#COPY deploy /root/deploy
#WORKDIR /root/deploy

#for actual deployment
RUN git clone https://github.com/PiedPiper1337/TLDWDeploy.git
WORKDIR /root/TLDWDeploy/deploy

RUN /bin/bash VidSumMySQLSetup.sh
EXPOSE 80
CMD ["/bin/bash", "entrypoint.sh"]