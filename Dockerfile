# need volume for /home/git to keep ssh keys, and a place to put the git data 

FROM alpine:3.18.0

ARG ssh_pub_key

 # change this at build time to value set in deployment/pod config file
ARG USER_ID=1111

# make git user 
# set up ssh for git user
# ssh only with keys
RUN adduser -D --uid $USER_ID git \
    && passwd -u git \
    && apk add openrc openssh git vim \
    && mkdir -p /home/git/.ssh \
    && echo "$ssh_pub_key" > /home/git/.ssh/authorized_keys \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \ 
    && chmod 0700 /home/git/.ssh \
    && chown -R git:git /home/git
RUN chmod 644 /etc/ssh/sshd_config \
    && chown -R git /etc/ssh \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

USER git 

RUN ssh-keygen -A

WORKDIR /app

COPY init.sh /app/init.sh

USER git

EXPOSE 8022

CMD sh -c '/app/init.sh'
