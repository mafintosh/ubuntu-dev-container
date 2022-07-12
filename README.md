# ubuntu-dev-container

Ubuntu linux container for systemd-spawn intended for development usage.

See the Containerfile for more info.

```
npm install -g ubuntu-dev-container
```

When installing the container is built. The container user is the
same as your host user.

## Usage

``` sh
ubuntu-dev-container # opens a container shell
ubuntu-dev-container --boot # does a full linux boot in the container
ubuntu-dev-container -b # same as above
ubuntu-dev-container /bin/bash # spawn a command in the container
```

Inside the container, the host cwd and home folder is mounted
at `mnt/cwd` and `mnt/home`.

In addition the container runs in privileged mode and mounts
your ssh config, vim config, npm config and gitconfig in home.

## License

MIT
