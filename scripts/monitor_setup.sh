#!/bin/bash

# Thay thế eDP-1 bằng tên màn hình của laptop và HDMI-1 bằng tên màn hình rời của bạn
if xrandr | grep "HDMI-1-0 connected"; then
	autorandr --change
else
	autorandr --change
fi

