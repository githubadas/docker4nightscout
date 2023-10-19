FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG GIT=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

WORKDIR /opt/app
ADD . /opt/app

RUN mkdir -p /nightscout && \
  chown -R node:node /nightscout && \
  apk update && \
  apk add --no-cache --virtual build-dependencies python make g++ git && \
  apk add --no-cache tini && \
  git clone $GIT --branch $WERSJA /nightscout && \
  cd /nightscout
  #npm install --no-cache && \
  #npm run postinstall && \
  #npm audit fix && \
  #npm run env && \
  #rm -rf /tmp/*
  #apk del build-dependencies

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
