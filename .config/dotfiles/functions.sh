pyclean () {
   # Cleans py[cod] and __pychache__ dirs in the current tree:
   find . | grep -E "(__pycache__|\.py[cod]$)" | xargs rm -rf
}


transfer () {
  # See https://transfer.sh/
  if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile;
}


mc () {
  # Create a new directory and enter it
  mkdir -p "$@" && cd "$@"
}

open () {
	xdg-open "$*" &
}
