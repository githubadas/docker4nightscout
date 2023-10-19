FROM node:16.16.0-alpine

LABEL maintainer="docker4nightscout"

WORKDIR /nightscout
ADD . /nightscout

ARG ADDRESS=https://github.com/nightscout/cgm-remote-monitor.git
ARG BRANCH=14.2.6
EXPOSE 1337

RUN mkdir -p /nightscout && \
  git clone $ADDRESS --branch $BRANCH /nightscout && \
  cd /nightscout && \
  npm install --cache /tmp/empty-cache && \
  npm run postinstall && \
  npm run env && \
  rm -rf /tmp/*

ENTRYPOINT ["/sbin/tini", "--"]

USER node

CMD ["node", "lib/server/server.js"]
