#!/bin/zsh

rsyncc() {
  echo copy $1  --->  $2
  rsync -rv --human-readable --progress $1 $2 &&echo done ----
}

# -- VIM --
rsyncc ~/.vimrc .

# -- UltiSnips for vim
# create directories for copy in current location 
if [ ! -d .vim ]; then 
  mkdir ./.vim/bundle/vim-snippets/UltiSnips
fi
rsyncc ~/.vim/bundle/vim-snippets/UltiSnips ./.vim/bundle/vim-snippets/UltiSnips 

# -- X server --
rsyncc ~/.xinitrc .
rsyncc ~/.Xresources ./.Xresources
rsyncc ~/.xbindkeysrc ./.xbindkeysrc

# -- Misc --
rsyncc ~/.aliases ./.aliases

# -- Android --
if [ ! -d .android ]; then 
  mkdir ./.android
fi
rsyncc ~/.android/avd ./.android/avd

# -- .config --
rsyncc ~/.config ./.config

# -- Editors --
rsyncc ~/.ideavimrc ./.ideavimrc
rsyncc ~/.tern-config ./.tern-config

# -- Task --
rsyncc ~/.task ./.task
rsyncc ~/.taskrc ./.taskrc
