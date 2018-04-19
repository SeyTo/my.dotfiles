#!/bin/zsh

rsyncc() {
  echo copy $1  --->  $2
  rsync -rv --human-readable --progress $1 $2 &&echo done ----
}

# TODO check 
rsyncc ./.vim ~/.vim
rsyncc ./.vimrc ~/.vimrc

# -- X server --
rsyncc ./.xinitrc ~/.xinitrc
rsyncc ./.Xresources ~/.Xresources
rsyncc ./.xbindkeysrc ~/.xbindkeysrc

# -- Misc --
rsyncc ./.aliases ~/.aliases

# -- Android --
rsyncc ./.android ~/.android

# -- .config --
rsyncc ./.config ~/.config

# -- Editor Config --
rsyncc ./.ideavimrc ~/.ideavimrc
rsyncc ./.tern-config ~/.tern-config

# -- Task --
rsyncc ./.task ~/.task
rsyncc ./.taskrc ~/.taskrc
