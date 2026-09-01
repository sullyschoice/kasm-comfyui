#!/usr/bin/env bash
DEFAULT_ARGS="--listen 0.0.0.0"
ARGS=${APP_ARGS:-$DEFAULT_ARGS}
xfce4-terminal --hold --command "/opt/ComfyUI/venv/bin/python3 /opt/ComfyUI/main.py ${ARGS}" &
UI_SERVER="127.0.0.1:8188"
check_web_server() {
    curl -s -o /dev/null http://$UI_SERVER && return 0 || return 1
}
while ! check_web_server; do
  sleep 1
done

sleep 2
google-chrome http://$UI_SERVER --start-maximized &
