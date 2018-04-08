if [ "$TERM" != "dumb" ]
then
PATH=~/.local/bin:$PATH
EDITOR="emacsclient -nw"
VISUAL="emacsclient -nw";
fi
