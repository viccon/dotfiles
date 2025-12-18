# Dotfiles

## Introduction
I use these scripts to bootstrap new machines, install software and prevent
configuration drifts between my personal laptop and the one I use at work.

## Bootstrapping a new machine
Generate SSH keys, copy them, and add them to Github:

```sh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/personal
pbcopy < ~/.ssh/personal.pub

ssh-keygen -t rsa -b 4096 -f ~/.ssh/work
pbcopy < ~/.ssh/work.pub
```

Run the bootstrap script to install and configure everything, and then restart the computer:

```sh
./bootstrap.sh
```

After the reboot, stow all configuration files:

```sh
stow -t ~ .
```

and then install node using volta:

```sh
volta install node
```

Lastly, make fzf work with CTRL + R:

```sh
$(brew --prefix)/opt/fzf/install
```
