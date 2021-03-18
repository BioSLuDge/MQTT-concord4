FROM python:2-alpine

WORKDIR /usr/src/app

COPY . ./

RUN apk update; \
    apk upgrade; \
    apk add gettext; \
    chmod 500 start.sh; \
	rm -rf /var/cache/apk/*; \
	pip install --no-cache-dir requests future pyserial paho-mqtt

CMD ["./start.sh"]