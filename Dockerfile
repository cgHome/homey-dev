FROM node:alpine

LABEL maintainer="Chris Gross <cghome [at] cFlat-inc.org>"

WORKDIR /app

# Add testing repo for hub
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --update \
    bash \
    man \
    git \
    hub \
    nano \
    && rm -rf /var/cache/apk/*

RUN echo 'alias git=hub' >> /root/.bashrc
     
RUN npm install -g \
    athom-cli

COPY .npm-init.js /root
RUN npm config set init-module /root/.npm-init.js -g

# Node.js debugger port
EXPOSE 9229     
VOLUME [ "/app" ]

CMD /bin/bash
