FROM python:2.7-alpine3.9

WORKDIR /usr/src/app

ADD ./* ./

RUN pip install --no-cache-dir requests future pyserial paho-mqtt &&\
    apk add --no-cache gettext && \
	chmod 500 run.sh

CMD ["./run.sh"]
