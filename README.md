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

Clone this as a bare git repository:

```sh
GIT_SSH_COMMAND='ssh -i $HOME/.ssh/personal -o IdentitiesOnly=yes' git clone --bare git@github.com:viccon/dotfiles.git $HOME/.cfg
```

Checkout the bare repository content to the home directory:

```sh
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
```

Run the bootstrap script to install and configure everything, and then restart the computer:

```sh
./bootstrap.sh
```

After the reboot, install node using volta:

```sh
volta install node
```

Make fzf work with CTRL + R:

```sh
$(brew --prefix)/opt/fzf/install
```

and make it so that we don't show untracked files for this project:

```sh
config config status.showUntrackedFiles no
```
