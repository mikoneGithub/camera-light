#!/bin/sh

lastState=0

makeLightsOn()
{
    echo $lastState
    if [[ $lastState -ne 1 ]]
    then
        lastState=1
        curl --location --request PUT 'http://<hue-bridge-ip>/api/<hue-brdige-api-key>/lights/<light-number>/state' --header 'Content-Type: application/json' --data-raw '{"on":true}'
    fi
}

makeLightsOff()
{
    echo $lastState
    if [[ $lastState -ne 2 ]]
    then
        lastState=2
        curl --location --request PUT 'http://<hue-bridge-ip>/api/<hue-brdige-api-key>/lights/<light-number>/state' --header 'Content-Type: application/json' --data-raw '{"on":false}'
    fi
}

log stream | while read line; do
echo "$line" | grep -q "kCameraStreamStart" && makeLightsOn
echo "$line" | grep -q "kCameraStreamStop" && makeLightsOff
done
