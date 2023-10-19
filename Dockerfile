FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG ADRES=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

RUN mkdir -p /nightscout && \
  apk update && \
  apk add --no-cache --virtual build-dependencies python make g++ git && \
  apk add --no-cache tini && \
  git clone $ADRES --branch $WERSJA /nightscout && \
  cd /nightscout && \
  npm install --no-cache && \
  npm run postinstall && \
  npm audit fix && \
  apk del build-dependencies && \
  chown -R node:node /nightscout

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
