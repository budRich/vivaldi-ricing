#!/bin/bash

this=$(readlink -f "${BASH_SOURCE[0]}")
dir=${this%/*}

config=$dir/config
style=$dir/style.css

str="let COMMANDBARCSS ="

cnf=$(grep -v "^${str}" "$config")
css=$(tr -d "\n" < "$style")
 
printf "%s\n%s '%s'\n" "$cnf" "$str" "$css" \
  > "$config"
