#!/usr/bin/env bash

: "${XDG_CONFIG_HOME:=$HOME/.config}"

_thisscript="$(readlink -f "${BASH_SOURCE[0]}")"
_name="${_thisscript##*/}"
_scriptdir="${_thisscript%/*}"
_moddir="$_scriptdir"

_optdir='/opt/vivaldi/resources/vivaldi'
_optfile="$_optdir/browser.html"
_optbackup="/tmp/browser.htmlBACKUP"

printhelp(){
cat << EOB >&2
${_name} will add custom mods for the vivaldi
webbrowser. By searching for css and js files in
the subdirectories of ${_moddir}.

Narrow the search by adding the name of subdir(s)
as arguments to ${_name}.

css files will get copied to "_cssdir", which
defaults to '~/.config/vivaldi-css' but can be overridden
by using the -d option.

js files will get copied to '/opt/vivaldi/resources/vivaldi'.
/opt/vivaldi/resources/vivaldi/browser.html, will get
updated if needed. These actions require sudo permissions
and user will be prompted for the password if needed.

If the force option (-f) is not used, user will get
prompted before any file is overwritten.
EOB
}

main() {

  # without arguments add all mods in moddir
  if [[ -z $1 ]]; then
    mapfile -t modlist < <(find "$_moddir"     \
                                -mindepth 1    \
                                -maxdepth 1    \
                                -type d        \
                                -printf '%f\n'
                          )
  else
    mapfile -t modlist < <(printf '%s\n' "$@")
  fi

  _tmp=$(mktemp)
  cp -f "$_optfile" "$_tmp"

  for modname in "${modlist[@]}"; do
    dir="$_moddir/$modname"
    [[ -d $dir ]] || continue

    [[ -f $dir/style.css ]] && {
      style="$_cssdir/${modname}.css"
      cp -f${_force:+i} "$dir/style.css" "$style"

      changed=0
    }

    [[ -f $dir/script.js ]] && {
      script="$_optdir/${modname}.js"
      sudo cp -f${_force:+i} "$dir/script.js" "$script"

      tag=$(printf '  <script src="%s"></script>' "${modname}.js")
      grep "$tag" "$_tmp" > /dev/null || {
        sed -i "s|\(</body>\)|${tag}\n  \1|" "$_tmp"
      }

      changed=0
    }
  done

  [[ $changed ]] && {
    ERM "vivaldi UI mods updated"
    ERM " "
    ERM "make sure that $_cssdir is added to "        \
        "'custom UI modifications' under Appearance " \
        "in the vivaldi settings."
    ERM " "
    ERM "if you can't find the settings you might " \
        "need to enable: 'Allow for using CSS modifications' " \
        "on: vivaldi://experiments"
    ERM " "
    ERM "restart vivaldi for the changes to take effect"
    ERM " "
  }

  cmp -s "$_tmp" "$_optfile" || {
    sudo cp -f${_force:+i} "$_tmp" "$_optfile" && {
      cp -f "$_optfile" "$_optbackup"
      ERR "updated $_optfile. Backup exist at $_optbackup"
    } 
  }

  rm "$_tmp"
}

set -E
trap '[ "$?" -ne 77 ] || exit 77' ERR

ERX() { echo "[ERROR]: $*" >&2  && exit 77 ;}
ERR() { echo "[WARNING]: $*" >&2  ;}
ERM() { echo "$*" >&2  ;}

_force=false

while getopts :d:fh o ; do
  case "$o" in
    d ) _cssdir="${OPTARG}"  ;;
    f ) _force=""            ;;
    h ) printhelp && exit 77 ;;
    * ) continue             ;;
  esac
done

shift $((OPTIND-1))

: "${_cssdir:=$XDG_CONFIG_HOME/vivaldi-css}"

[[ -d $_moddir ]] || ERX "$_moddir not found"
[[ -d $_optdir ]] || ERX "$_optdir not found"
[[ -d $_cssdir ]] || {
  ERR "creating $_cssdir"
  mkdir -p "$_cssdir"
}

main "$@"
