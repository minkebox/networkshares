FROM alpine:latest

RUN apk add cifs-utils

COPY root/ /

VOLUME /folders

ENTRYPOINT ["/startup.sh"]
