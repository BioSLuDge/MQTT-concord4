#!/usr/bin/env sh

if [[ -z "${SERIAL}" ]]; then
  export SERIAL="/dev/ttyUSB0"
fi

if [[ -z "${MQTT_TLS}" ]]; then
  export MQTT_TLS="True"
fi

if [[ -z "${MQTT_PORT}" ]]; then
  export MQTT_PORT="8883"
fi

if [[ -z "${LOG_LEVEL}" ]]; then
  export LOG_LEVEL="INFO"
fi

envsubst < concordsvr_mqtt.conf.template > concordsvr_mqtt.conf

python concordsvr_mqtt.py