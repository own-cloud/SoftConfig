#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")


# options of ln can be:
#    -f (force to override if existed)
#    -i (interactively to override if existed)
opt="$1"
ok=0
ng=0
# $1 orignal file, $2 link
add_link() {
  if [ -n "$opt" ]; then
    rm -rf "$2"
    ln -s "$1" "$2"
  else
    if [ -f "$2" ] || [ -d "$2" ]; then
      printf "%-52s link exists .... ignore!\n" "$2"
      let ng+=1
      return
    else
      ln -s "$1" "$2"
    fi
  fi
  printf "%-52s set link  .... done!\n" "$2"
  let ok+=1
}

add_link "$SCRIPTPATH/shell_common"  "$HOME/.shell_common"
echo "Successfully make soft link to $HOME (OK: $ok, NG: $ng)"
