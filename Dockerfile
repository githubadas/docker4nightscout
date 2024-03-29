FROM node:16.16.0-alpine

LABEL maintainer="docker4nightscout"
# source from official site cgm-remote-monitor/nightscout

ARG ZRODLO=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

EXPOSE 1337

RUN  mkdir -p /nightscout && \
  apk update && \
  apk add git && \
  apk add nodejs && \
  apk add npm && \
  git clone $ZRODLO --branch $WERSJA /nightscout && \
  cd /nightscout && \
  npm install --cache /tmp/empty-cache && \
  npm run postinstall && \
  npm run env && \
  rm -rf /tmp/*

WORKDIR /nightscout
ADD . /nightscout

USER node

CMD ["node", "lib/server/server.js"]
