#!/bin/bash

this=$(readlink -f "${BASH_SOURCE[0]}")
dir=${this%/*}
optd=/opt/vivaldi/resources/vivaldi/

brws=$optd/browser.html
brwslocal=$dir/browser.html

cp "$brws" "$brwslocal"

files=("$dir"/*.js)

for f in "${files[@]}"; do
  str=$(printf '<script src="%s"></script>' "${f##*/}")
  sudo cp -fi "$f" "$optd"
  grep "$str" "$brwslocal" >/dev/null \
    || sed -i "s|\([[:space:]]*\)\(</body>\)|\1\1$str\n\1\2|" "$brwslocal"
done

sudo mv -f "$brwslocal" "$brws"
