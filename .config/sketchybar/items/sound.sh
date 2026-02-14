#!/usr/bin/env bash

SOUND=(
  update_freq=120
  script="$PLUGIN_DIR/sound.sh"
)

sketchybar --add item sound right \
 --set sound "${SOUND[@]}" \
 --subscribe sound volume_change
