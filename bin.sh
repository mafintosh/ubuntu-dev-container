OPTIONS="-q -a -u $USER"
DIRNAME="$(dirname $(realpath $0))"
CONTAINER="$DIRNAME/container.img"
BIND=""
CMD=""

for i in $@; do
  if ([ "$i" == "-b" ] || [ "$i" == "--boot" ]) && [ "$CMD" == "" ]; then
    OPTIONS="-b"
  else
    CMD="$CMD $i"
  fi
done

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

