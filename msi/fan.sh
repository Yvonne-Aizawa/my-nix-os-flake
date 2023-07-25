#!/bin/bash
set -e
set -o pipefail

# Check the command line argument
if [ "$#" -ne 1 ]; then
    echo "You must enter exactly one argument: 'on' or 'off'"
    exit 1
fi
echo \$1
# Assign the hex value based on the argument
hex_value=""
if [ "$1" = "on" ]; then
    hex_value="\x80" # fan go BRRRR
elif [ "$1" = "off" ]; then
    hex_value="\x00" # fan go brr but slow
else
    echo "Invalid argument. Enter 'on' or 'off'"
    exit 1
fi


if echo -n -e "$hex_value" | dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=152 conv=notrunc 2>/dev/null; then
    echo "Write operation succeeded."
else
    echo "Write operation failed." >&2
    exit 1
fi

exit
# int batteryThresholdAddress;
# const int batteryThresholdAddress_0xEF = 0xEF;
# const int batteryThresholdAddress_0xD7 = 0xD7;
