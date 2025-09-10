#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
API_URL="https://test.com/monitoring/test/api"
STATE_FILE="/var/run/${PROCESS_NAME}_pid"

PID=$(pgrep -xo "$PROCESS_NAME")

if [[ -n "$PID" ]]; then
	if curl -s --head --fail "$API_URL" > /dev/null 2>$1; then
		curl -s -X POST "$API_URL" > /dev/null 2>&1
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S') | ERROR | Monitoring server is unavailable" >> "$LOG_FILE"
	fi
	
	if [[ -f "$STATE_FILE" ]]; then
		LAST_PID=$(cat "$STATE_FILE")
		if [[ "$PID" -ne "$LAST_PID" ]]; then
			echo "$(date '+%Y-%m-%d %H:%M:%S') | INFO | Process $PROCESS_NAME restarted (PID: $PID)" >> "$LOG_FILE"
		fi
	fi

	echo "$PID" > "$STATE_FILE"
else
	exit 0
fi
