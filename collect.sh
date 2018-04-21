#!/bin/zsh

rsyncc() {
  local destination=
  if [ -z $2 ]; then
    destination=./
  fi
  echo copy $1  --->  $2
  rsync -rv --human-readable --progress $1 $2 &&echo done ----
}

# -- VIM --
rsyncc ~/.vimrc

# -- UltiSnips for vim
# create directories for copy in current location 
if [ ! -d .vim ]; then 
  mkdir ./.vim/bundle/vim-snippets/UltiSnips
fi
rsyncc ~/.vim/bundle/vim-snippets/UltiSnips ./.vim/bundle/vim-snippets/

# -- X server --
rsyncc ~/.xinitrc
rsyncc ~/.Xresources
rsyncc ~/.xbindkeysrc

# -- Misc --
rsyncc ~/.aliases
rsyncc ~/scripts

# -- .config --
rsyncc ~/.config

# -- Editors --
rsyncc ~/.ideavimrc
rsyncc ~/.tern-config

# -- Task --
rsyncc ~/.task
rsyncc ~/.taskrc
