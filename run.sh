#!/bin/sh

export EMAIL_SENDER_BASE64=$(echo -n "$EMAIL_SENDER" | base64);
export EMAIL_PASS_BASE64=$(echo -n "$EMAIL_PASSS" | base64);
export EMAIL_RECIPIENT_BASE64=$(echo -n "$EMAIL_RECIPIENT" | base64);
export MQTT_USER_BASE64=$(echo -n "$MQTT_USER" | base64);
export MQTT_PASS_BASE64=$(echo -n "$MQTT_PASS" | base64);

if [ -z "${MQTT_TLS}" ]; then
        export MQTT_TLS='true'
fi

if [ -z "{MQTT_PORT}" ]; then
        export MQTT_PORT='8883'
fi

envsubst < concordsvr_mqtt.template > concordsvr_mqtt.conf

python concordsvr_mqtt.py