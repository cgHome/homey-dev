FROM node:lts-alpine

LABEL maintainer="Chris Gross <cghome [at] cFlat-inc.org>"

WORKDIR /app

# Add testing repo for hub
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update \
    bash \
    man \
    git \
    hub \
    nano \
    && rm -rf /var/cache/apk/*

# Not working [need to be fixed]
RUN echo 'alias git=hub' >> /root/.bashrc
     
RUN npm install -g \
    homey

COPY .npm-init.js /root
RUN npm config set init-module /root/.npm-init.js -g

# Node.js debugger port
EXPOSE 9229     
VOLUME [ "/app" ]

SHELL ["/bin/bash", "-c"]
CMD /bin/bash
