#!/bin/sh

# Configure xrander with the number of screens
SCREENS_COUNT=$(xrandr -q | grep " connected" | wc -l)

# nassty hack
# fix acceleration with 2 screens
if [ $SCREENS_COUNT = 1 ]; then
    synclient AccelFactor=0.129366;
else
    synclient AccelFactor=0.03;
fi

echo "number of screens found ${SCREENS_COUNT}"
exec "/home/craig/.config/qtile/${SCREENS_COUNT}screens.sh"
