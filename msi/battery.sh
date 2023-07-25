#!/bin/bash
set -e
set -o pipefail

# Execute the read operation


if value=$(dd if=/sys/kernel/debug/ec/ec0/io bs=1 skip=239 count=1 2>/dev/null | od -An -t x1); then
    echo "Read operation succeeded."
    echo "Value at address 0xEF is: $value"

else
    echo "Read operation failed." >&2
    exit 1
fi
if value=$(dd if=/sys/kernel/debug/ec/ec0/io bs=1 skip=188 count=1 2>/dev/null | od -An -t x1); then
    echo "Read operation succeeded."
    echo "Value at address 0xD7 is: $value"
else
    echo "Read operation failed." >&2
    exit 1
fi

exit


# int batteryThresholdAddress;
# const int batteryThresholdAddress_0xEF = 0xEF;
# const int batteryThresholdAddress_0xD7 = 0xD7;