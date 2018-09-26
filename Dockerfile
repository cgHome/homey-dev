FROM node:alpine

LABEL maintainer="Chris Gross <cghome [at] cFlat-inc.org>"

WORKDIR /app

RUN apk add --update \
    bash \
    man \
    git \
    && rm -rf /var/cache/apk/*
     
RUN npm install -g \
    nps \
    athom-cli

# Node.js debugger port
EXPOSE 9229     
VOLUME [ "/app" ]

CMD /bin/bash