FROM node:16.16.0-alpine

LABEL maintainer="docker4nightscout"

ARG ADDRESS=https://github.com/nightscout/cgm-remote-monitor.git
ARG BRANCH=master
EXPOSE 1337

RUN mkdir -p /nightscout && \
  apk update && \
  apk add --no-cache --virtual build-dependencies python make g++ git && \
  apk add --no-cache tini && \
  git clone $ADDRESS --branch $BRANCH /nightscout && \
  cd /nightscout && \
  npm install --cache /tmp/empty-cache && \
  npm run postinstall && \
  npm run env && \
  rm -rf /tmp/*

ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /nightscout

USER node

CMD ["node", "lib/server/server.js"]
