FROM node:16.16.0-alpine

LABEL maintainer="docker4nightscout"

WORKDIR /opt/app
ADD . /opt/app

ARG ADDRESS=https://github.com/nightscout/cgm-remote-monitor.git
ARG BRANCH=master
EXPOSE 1337

RUN  git clone $ADDRESS --branch $BRANCH /opt/app && \
  cd /opt/app && \
  npm install --cache /tmp/empty-cache && \
  npm run postinstall && \
  npm run env && \
  rm -rf /tmp/*

ENTRYPOINT ["/sbin/tini", "--"]

USER node

CMD ["node", "lib/server/server.js"]
