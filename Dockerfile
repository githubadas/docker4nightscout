FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG GIT=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

WORKDIR /opt/app
ADD . /opt/app

RUN 
  apk update

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
