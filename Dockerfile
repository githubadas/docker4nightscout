FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG ZRODLO=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

RUN  mkdir -p /nightscout




ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /nightscout
ADD . /nightscout

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
