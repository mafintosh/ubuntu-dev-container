OPTIONS="-q -a -u maf"
DIRNAME="$(dirname $(realpath $0))"
CONTAINER="$DIRNAME/container.img"
BIND=""
BOOT=false
CMD=""

for i in $@; do
  if ([ "$i" == "-b" ] || [ "$i" == "--boot" ]) && [ "$CMD" == "" ]; then
    OPTIONS="-b"
    BOOT=true
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

sudo systemd-nspawn $OPTIONS -i "$CONTAINER" $BIND \
  --capability=CAP_AUDIT_CONTROL \
  --capability=CAP_AUDIT_READ \
  --capability=CAP_AUDIT_WRITE \
  --capability=CAP_BLOCK_SUSPEND \
  --capability=CAP_CHOWN \
  --capability=CAP_DAC_OVERRIDE \
  --capability=CAP_DAC_READ_SEARCH \
  --capability=CAP_FOWNER \
  --capability=CAP_FSETID \
  --capability=CAP_IPC_LOCK \
  --capability=CAP_IPC_OWNER \
  --capability=CAP_KILL \
  --capability=CAP_LEASE \
  --capability=CAP_LINUX_IMMUTABLE \
  --capability=CAP_MAC_ADMIN \
  --capability=CAP_MAC_OVERRIDE \
  --capability=CAP_MKNOD \
  --capability=CAP_NET_ADMIN \
  --capability=CAP_NET_BIND_SERVICE \
  --capability=CAP_NET_BROADCAST \
  --capability=CAP_NET_RAW \
  --capability=CAP_SETGID \
  --capability=CAP_SETFCAP \
  --capability=CAP_SETPCAP \
  --capability=CAP_SETUID \
  --capability=CAP_SYS_ADMIN \
  --capability=CAP_SYS_BOOT \
  --capability=CAP_SYS_CHROOT \
  --capability=CAP_SYS_MODULE \
  --capability=CAP_SYS_NICE \
  --capability=CAP_SYS_PACCT \
  --capability=CAP_SYS_PTRACE \
  --capability=CAP_SYS_RAWIO \
  --capability=CAP_SYS_RESOURCE \
  --capability=CAP_SYS_TIME \
  --capability=CAP_SYS_TTY_CONFIG \
  --capability=CAP_SYSLOG \
  --capability=CAP_WAKE_ALARM \
  $CMD

