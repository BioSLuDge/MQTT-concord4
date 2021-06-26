# MQTT-concord4

This is based off the original [device-concord4 here](https://github.com/automaton82/device-concord4).

Which is forked from the [original here](https://github.com/csdozier/device-concord4).

And this itteration was forked from https://github.com/automaton82/MQTT-concord4

The original concord4 was made for SmartThings via a web-server. Since SmartThings is now sun-setting classic along with custom DTH UIs, it no longer works.

I forked the last project, from automation82, added tls support and put it in a docker container.

## Prerequisites

 - Hardware (Concord 4 or equivalent panel) with a Superbus 2000 automation module attached to it
 - RS232 connection (to the AM panel)
 - Docker

## Installation

1. Install docker, and run the image.  Env vars MQTT_HOST, MQTT_USER, MQTT_PASS, and SERIAL_PORT are required.  MQTT_TLS defaults to true, and MQTT_PORT defaults to 8883.

docker run -d -v\ 
   --env MQTT_HOST="my.mqtthost.com" \
   --env MQTT_PORT="1883" \
   --env MQTT_USER="myUser" \
   --env MQTT_PASS="myPass" \
   --env MQTT_TLS="true" \
   --env SERIAL_PORT="/dev/ttyUSB0" \
   --env LOG_LEVEL="INFO" \
   --env EMAIL_SENDER="sender@gmail.com" \
   --env EMAIL_PASS="Email sender password" \
   --env EMAIL_RECIPIENT="Email recipient" \
   --device=/dev/ttyUSB0 \
   biosludge/mqtt-concord4

## Home Assistant

You can create entities in Home Assistant to represent the various sensors by [adding MQTT library to HA](https://www.home-assistant.io/integrations/mqtt/), and then editing the *configuration.yaml* file to include something like:

    # MQTT binary sensor
    binary_sensor:
        - platform: mqtt
        name: "Front Door"
        state_topic: "concord/zone/1"
        payload_on: "open"
        payload_off: "closed"
        device_class: opening

This adds the front door sensor as an entity you can put on any dashboard.

The [alarm entity can be created](https://www.home-assistant.io/integrations/alarm_control_panel.mqtt/) with the following item in the configuration:

    # Alarm setup
    alarm_control_panel:
        - platform: mqtt
        state_topic: "concord/alarm"
        command_topic: "concord/alarm/set"
        code_arm_required: false
        code_disarm_required: false

## MQTT

The topic listened to is *concord/#*. The topic to set is:

* concord/alarm/set

With payloads of:

* arm_home
* arm_away
* disarm

The device will send out messages like:

* concord/zone/x

Where x is the zone number, like 1. Payload is 'open' or 'closed. It also sends:

* concord/alarm

With payloads of:

* armed_home
* armed_away
* disarmed

## Notes

The previous ST version supported 'loud' as an option for arming / disarming, but the last package didn't implement that as their panel doesn't support it anyways. If desired it could be added back as the payload for the various topics.
