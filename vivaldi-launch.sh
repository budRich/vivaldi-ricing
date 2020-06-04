#!/bin/bash

_this=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_this%/*}

: "${VIVALDI_COMMAND:=vivaldi-stable}"
: "${VB4C_PORT:=8054}"
: "${VB4C_EXEC_WORD:=secretpassword}"
: "${VB4C_EXEC_COMMAND:=gurl}"
: "${VB4C_VIM_COMMAND:='sublaunch --profile subltmp --wait'}"
: "${VB4C_PATH:=$_dir/vb4c/vb4c_server.py}"

ERM(){ >&2 echo "$*"; }

# use shortoption -u to enable debug mode and launch
# the server script and vivaldi from urxvt windows
_debug=0 
while getopts :u o; do [[ $o = u ]] && {
  shift
  if command -v urxvt > /dev/null; then
    _debug=1
  else
    ERM 'urxvt' command not found, debug disabled
  fi
} done

_url=${1:-}

class=${VIVALDI_COMMAND^} # default class name
rename=Vivaldi-main       # new class name

servercmd=("$VB4C_PATH")

((_debug)) \
  && servercmd=(urxvt -name vb4c -e bash -c "'${servercmd[*]}'")

main() {

  wid=$(xdotool search --class "$rename")

  nc -z 127.0.0.1 "$VB4C_PORT" || { 
    
    if [[ -x $VB4C_PATH ]]; then
      export VB4C_PORT
      export VB4C_EXEC_WORD
      export VB4C_VIM_COMMAND
      ERM starting server
      ${servercmd[*]} &
    else
      ERM could not start "$VB4C_PATH"
    fi

  }

  togglebrowser

  # if the browser was already open and a URL was
  # passed as arg. put the URL in the clipboard
  # and send 'P' to the browser window to open URL
  # in a new tab. Assumes 'P' is used for opening
  # clipboard in new tab is set in vb4c (it's the
  # default)
  [[ -n $_url && -n $wid ]] && {
    xdotool key --window "$wid" --clearmodifiers Escape
    xclip -r -sel clipboard <<< "$_url"
    sleep 0.07
    xdotool key --window "$wid" P
  }
}

togglebrowser() {

  browsercmd+=("$VIVALDI_COMMAND")
  browsercmd+=(--debug-packed-apps)
  browsercmd+=(--silent-debugger-extension-api)

  [[ -n $_url ]] && {
    [[ -f $_url ]] && _url=file://$(realpath "$_url")
    browsercmd+=("$_url")
  }

  ((_debug)) && [[ -z $wid ]] \
    && browsercmd=(urxvt -name browser -e bash -c "'${browsercmd[*]}'")

  # update vb4c config file if main window doesnt
  # exist and vb4c config file is in same dir as
  # vb4c_server.py
  local rc t
  [[ -z $wid && -f ${rc:=${VB4C_PATH%/*}/config} ]] && {
    
    export VB4C_PORT
    export VB4C_EXEC_WORD
    export VB4C_EXEC_COMMAND
    export VB4C_VIM_COMMAND

    t=$(mktemp)

    awk -v rcf="${rc/~/'~'}" '
      BEGIN { sq="'\''" }
      mod != 1 && $2 == "homedirectory" {$4=sq ENVIRON["HOME"] sq}
      mod != 1 && $2 == "@@config"      {sub($3 ".*"," " sq rcf sq)}
      mod != 1 && $2 == "vimport"       {$4=ENVIRON["VB4C_PORT"]}
      mod != 1 && $2 == "COMMAND"       {$4=sq ENVIRON["VB4C_EXEC_COMMAND"] sq}
      mod != 1 && $2 == "EXEC_WORD"     {$4=sq ENVIRON["VB4C_EXEC_WORD"] sq}
      mod != 1 && $2 == "FIELD_SEPARATOR" {mod=1}    
      {print}
    ' "$rc" > "$t" && mv -f "$t" "$rc"
  }

  if command -v i3run > /dev/null ; then
    :
    i3run ${_url:+--nohide}         \
                  --class "$rename" \
                  --rename "$class" \
                  --command "${browsercmd[*]}"

  elif [[ -z $wid ]]; then

    eval "${browsercmd[*]}" &
    wid=$(xdotool search --sync --onlyvisible --class "$class")
    xdotool set_window --class "$rename" "$wid" \
            windowfocus "$wid"

  else
    xdotool windowfocus --sync "$wid"
  fi
}

main "$@"
