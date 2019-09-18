FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get install -y git
RUN apt-get install -y curl
RUN curl https://raw.githubusercontent.com/yeltnar/gist/master/setup.sh | bash

RUN echo $var_name > ~/log.txt

ARG mnt_dir
RUN mkdir /media/pi && ln -sf $mnt_dir /media/pi/TOSHIBA\ EXT

ARG passwd
RUN echo root:$passwd | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

