FROM node:alpine

LABEL maintainer="Chris Gross <cghome [at] cFlat-inc.org>"

WORKDIR /app

RUN apk add --update \
    bash \
    man \
    git \
    && rm -rf /var/cache/apk/*
     
RUN npm install -g \
    athom-cli

COPY .npm-init.js /root
RUN npm config set init-module /root/.npm-init.js -g

# Node.js debugger port
EXPOSE 9229     
VOLUME [ "/app" ]

CMD /bin/bash
