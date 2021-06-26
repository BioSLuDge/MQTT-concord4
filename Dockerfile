FROM alpine:3.4

WORKDIR /usr/src/app

ADD ./ ./

RUN apk add --no-cache gettext python py-pip && \
    pip install --no-cache-dir requests future pyserial paho-mqtt && \
    chmod 500 run.sh

CMD ["./run.sh"]
