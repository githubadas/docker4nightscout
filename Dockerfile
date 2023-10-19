FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG ZRODLO=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

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
  
ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /nightscout
ADD . /nightscout

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
