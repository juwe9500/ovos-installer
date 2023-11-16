#!/bin/env bash

# shellcheck source=locales/en-us/profiles.sh
source "tui/locales/$LOCALE/profiles.sh"

active_profile="ovos"
available_profiles=(ovos satellite listener)

whiptail_args=(
  --title "$TITLE"
  --radiolist "$CONTENT"
  --cancel-button "$CANCEL_BUTTON"
  --ok-button "$OK_BUTTON"
  --yes-button "$OK_BUTTON"
  25 80 "${#available_profiles[@]}"
)

for method in "${available_profiles[@]}"; do
  whiptail_args+=("$method" "")
  if [[ $method = "$active_profile" ]]; then
    whiptail_args+=("on")
  else
    whiptail_args+=("off")
  fi
done

PROFILE=$(whiptail "${whiptail_args[@]}" 3>&1 1>&2 2>&3)
export PROFILE

if [ -z "$PROFILE" ]; then
  exit 0
fi
