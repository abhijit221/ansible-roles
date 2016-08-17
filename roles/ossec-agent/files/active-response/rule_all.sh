#!/usr/bin/env bash
# Author: Jon Schipp
PROG=OSSEC
SCRIPT=$0
MAIL=jon@komand.com
ACTION=$1
USER=$2
IP=$3
ALERTID=$4
RULEID=$5
AGENT=$6

[[ "$*" =~ syscheck ]] && exit

# This scripts calls others because only one can be executed by OSSEC

die(){
  if [ -f ${COWSAY:-none} ]; then
    $COWSAY -d "$*"
  else
    printf "$*\n"
  fi
  exit 0
}

is_ip(){
  [[ $IP ]] || return 1
  [[ $IP == '-' ]] && return 1
  return 0
}

LOCAL=$(dirname $0);
cd $LOCAL
cd ../
PWD=$(pwd)
CIF="$PWD/bin/cif.sh"
BHR="$PWD/bin/bhr.sh"
CDB="$PWD/bin/add_to_cdb.sh"
CMDS="$PWD/bin/command_search.sh"
TS="$PWD/bin/time_lookup.sh"
LDAP="$PWD/bin/ldap_lookup.sh"

printf "$(date) $0 $1 $2 $3 $4 $5 $6 $7 $8\n" >> ${PWD}/../logs/active-responses.log

# See if we collect information
[[ -x $CDB ]] && [[ $RULEID -eq 5902 ]] && $CDB $1 $2 $3 $4 $5

# Search for suspicious commands
[[ -x $CMDS ]] && $CMDS $1 $2 $3 $4 $5

# Check if system's clock is off
[[ -x $TS ]] && $TS $1 $2 $3 $4 $5

# CIF Feed
is_ip && [[ -x $CIF ]] && $CIF $1 $2 $3 $4 $5
