#!/bin/sh

EMAIL_SENDER_BASE64=$(echo -n "$EMAIL_SENDER" | base64);
EMAIL_PASS_BASE64=$(echo -n "$EMAIL_PASSS" | base64);
EMAIL_RECIPIENT_BASE64=$(echo -n "$EMAIL_RECIPIENT" | base64);
MQTT_USER_BASE64=$(echo -n "$MQTT_USER" | base64);
MQTT_PASS_BASE64=$(echo -n "$MQTT_PASS" | base64);

envsubst < "concordsvr_mqtt.template" > "concordsvr_mqtt.conf"

python concordsvr_mqtt.py