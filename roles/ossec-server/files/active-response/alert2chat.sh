#!/bin/sh
# Author: Jon Schipp <jonschipp@gmail.com>
CHAT=/usr/local/bin/msg2slack
CHANNEL="#security-alerts"
ACTION=$1
USER=$2
IP=$3
ALERTID=$4
RULEID=$5

# Check for chat program
[[ -f $CHAT ]] || exit 1

# Skip rules to avoid flooding of alerts of less importance
  # System
[[ $RULEID =~ ^(2933|5113)$ ]] && exit

LOCAL=$(dirname $0);
cd $LOCAL
cd ../
PWD=$(pwd)

# Logging the call
printf "$(date) $0 $1 $2 $3 $4 $5 $6 $7 $8\n" >> ${PWD}/../logs/active-responses.log

# Getting full alert
MSG=$(awk -v ts=$ALERTID 'BEGIN { RS=""; ORS="\n" } $0 ~ ts { print }' ${PWD}/../logs/alerts/alerts.log)
[[ $MSG ]] || exit 1
printf "$MSG\n" | $CHAT "$CHANNEL"
