FROM node:16.16.0-alpine

LABEL maintainer="Nightscout Contributors"
# source from official site cgm-remote-monitor/nightscout

ARG GIT=https://github.com/nightscout/cgm-remote-monitor.git
ARG WERSJA=master

WORKDIR /nightscout
ADD . /nightscout

RUN  git clone $GIT --branch $WERSJA /nightscout && \
  cd /nightscout
  
  #apk update && \
  #apk add  --no-cache --virtual build-dependencies python
  #make g++ git

USER node

EXPOSE 1337

CMD ["node", "lib/server/server.js"]
