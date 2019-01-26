DEFAULT_OPTIONS="-q -a -u $USER"
DIRNAME="$(dirname $(realpath $0))"
CONTAINER="$DIRNAME/container.img"
BIND=""
CMD=""

for i in $@; do
  if [ "${i:0:1}" == "-" ] && [ "$CMD" == "" ]; then
    if [ "$i" == "-b" ] || [ "$i" == "--boot" ]; then
      DEFAULT_OPTIONS=""
    fi
    OPTIONS="$OPTIONS $i"
  else
    CMD="$CMD $i"
  fi
done

OPTIONS="$DEFAULT_OPTIONS $OPTIONS"

bind () {
  if [ -d "$1" ] || [ -f "$1" ]; then
    BIND="$BIND --bind $1:$2"
  fi
}

bind ~/.vimrc $HOME/.vim
bind ~/.vimrc $HOME/.vimrc
bind ~/.gitconfig $HOME/.gitconfig
bind ~/.ssh $HOME/.ssh
bind $(pwd) $HOME/mnt/cwd
bind ~/ $HOME/mnt/home
bind ~/.npmrc $HOME/.npmrc
bind ~/.npm $HOME/.npm
bind /lib/modules /lib/modules

sudo systemd-nspawn $OPTIONS -i "$CONTAINER" $BIND --capability=all $CMD

