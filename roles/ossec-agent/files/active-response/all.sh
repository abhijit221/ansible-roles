#!/usr/bin/env bash
# Author: Jon Schipp
ARGV="$*"
RULEID=$5

# This scripts calls others because only one can be executed by OSSEC sanely

die(){
  if [ -f ${COWSAY:-none} ]; then
    $COWSAY -d "$*"
  else
    printf "$*\n"
  fi
  exit 0
}

is_syscheck(){
  [[ "$ARGV" =~ syscheck ]] && return 0
  return 1
}

is_script(){
  script="$1"
  [[ -x $script ]] && return 0
  return 1
}

printf "$(date) $0 $1 $2 $3 $4 $5 $6 $7 $8\n" >> ${PWD}/../../logs/active-responses.log

is_syscheck && is_script syscheck-all.sh && exec ./syscheck-all.sh $ARGV
[[ $RULEID -eq 110000 ]] && is_script makelists.sh && exec ./makelists.sh
#[[ $RULEID -eq 100023 ]] && is_script restart-ossec.sh && exec ./restart-ossec.sh $ARGV
is_script rule-all.sh && exec ./rule-all.sh $ARGV

# Something went wrong
die "Scripts failed to launch"
