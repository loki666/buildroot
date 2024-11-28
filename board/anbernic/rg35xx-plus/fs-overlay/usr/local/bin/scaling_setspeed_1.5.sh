#!/bin/bash

available_freq=("480000" "720000" "1008000" "1032000" "1104000" "1200000" "1416000" "1512000")

# Seed random generator
RANDOM=$$$(date +%s)

echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
stress-ng -c4 &

for (( ; ; ))
do
   CHOICE_FREQ=${available_freq[$RANDOM % ${#available_freq[@]}]}
   echo $CHOICE_FREQ
   echo "$CHOICE_FREQ" > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
   sleep 0.1
done

