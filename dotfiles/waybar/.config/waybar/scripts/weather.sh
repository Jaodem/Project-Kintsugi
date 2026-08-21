#!/bin/bash

LAT="-26.8083"
LON="-65.2176"
LOCATION="San Miguel de Tucumán"

URL="https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,is_day&temperature_unit=celsius&wind_speed_unit=kmh"

data=$(curl -fsS --max-time 10 "$URL")

if [ -z "$data" ]; then
    printf '%s\n' '{"text":"󰖐 --°C","tooltip":"Weather data unavailable"}'
    exit 0
fi

temperature=$(printf '%s' "$data" | sed -n 's/.*"temperature_2m":\([-0-9.]*\).*/\1/p')
apparent=$(printf '%s' "$data" | sed -n 's/.*"apparent_temperature":\([-0-9.]*\).*/\1/p')
humidity=$(printf '%s' "$data" | sed -n 's/.*"relative_humidity_2m":\([0-9.]*\).*/\1/p')
precipitation=$(printf '%s' "$data" | sed -n 's/.*"precipitation":\([-0-9.]*\).*/\1/p')
weather_code=$(printf '%s' "$data" | sed -n 's/.*"weather_code":\([0-9]*\).*/\1/p')
wind=$(printf '%s' "$data" | sed -n 's/.*"wind_speed_10m":\([-0-9.]*\).*/\1/p')
is_day=$(printf '%s' "$data" | sed -n 's/.*"is_day":\([01]\).*/\1/p')

[ -z "$temperature" ] && temperature="--"
[ -z "$apparent" ] && apparent="--"
[ -z "$humidity" ] && humidity="--"
[ -z "$precipitation" ] && precipitation="--"
[ -z "$wind" ] && wind="--"
[ -z "$weather_code" ] && weather_code=0
[ -z "$is_day" ] && is_day=1

case "$weather_code" in
    0)
        if [ "$is_day" = "1" ]; then
            icon="󰖙"
        else
            icon="󰖔"
        fi
        condition="Clear sky"
        ;;

    1)
        if [ "$is_day" = "1" ]; then
            icon="󰖕"
        else
            icon="󰖔"
        fi
        condition="Mainly clear"
        ;;

    2)
        icon="󰖕"
        condition="Partly cloudy"
        ;;

    3)
        icon="󰖐"
        condition="Overcast"
        ;;

    45|48)
        icon="󰖑"
        condition="Fog"
        ;;

    51|53|55|56|57)
        icon="󰖗"
        condition="Drizzle"
        ;;

    61|63|65|66|67)
        icon="󰖖"
        condition="Rain"
        ;;

    71|73|75|77)
        icon="󰼁"
        condition="Snow"
        ;;

    80|81|82)
        icon="󰖖"
        condition="Rain showers"
        ;;

    85|86)
        icon="󰼁"
        condition="Snow showers"
        ;;

    95)
        icon="󰖓"
        condition="Thunderstorm"
        ;;

    96|99)
        icon="󰙾"
        condition="Thunderstorm with hail"
        ;;

    *)
        icon="󰖐"
        condition="Unknown"
        ;;
esac

tooltip="${LOCATION}\\n${condition}\\n\\nTemperature: ${temperature}°C\\nFeels like: ${apparent}°C\\nHumidity: ${humidity}%\\nPrecipitation: ${precipitation} mm\\nWind: ${wind} km/h"

printf '{"text":"%s %s°C","tooltip":"%s"}\n' \
    "$icon" "$temperature" "$tooltip"
