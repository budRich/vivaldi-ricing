#!/bin/bash

: "${VB4C_PORT:=8064}"
: "${VB4C_EXEC_WORD:=brwscon}"
: "${VB4C_VIM_COMMAND:='sublaunch --profile subltmp --wait'}"

_this=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_this%/*}
_url=$1

class=Vivaldi-stable # default class name
rename=Vivaldi-main  # new class name

serverpath=$_dir/vb4c/vb4c_server.py

getid() { xdotool search --class "$rename" ;}

main() {

  togglebrowser

  # servercmd="urxvt -name vb4c -e bash -c '$servercmd'"
  nc -z 127.0.0.1 "$VB4C_PORT" || { 
    export VB4C_PORT
    export VB4C_EXEC_WORD
    export VB4C_VIM_COMMAND
    echo starting server
    ${serverpath} &
  }

  [[ -n $_url && -n ${wid:=$(getid)} ]] && {
    xdotool key --window "$wid" --clearmodifiers Escape
    xclip -r -sel clipboard <<< "$_url"
    sleep 0.07
    xdotool key --window "$wid" P
  }
}

togglebrowser() {

  browsercmd+=(vivaldi-stable)
  browsercmd+=(--debug-packed-apps)
  browsercmd+=(--silent-debugger-extension-api)
  [[ -n ${_url:-} ]] && {
    [[ -f $_url ]] && _url=file://$(realpath "$_url")
    browsercmd+=("$_url")
  }

  # browsercmd=(urxvt -name browsterm -e bash -c "'${browsercmd[*]}'")

  i3run ${_url:+--nohide}         \
                --class "$rename" \
                --rename "$class" \
                --command "${browsercmd[*]}"
}

main "$@"
