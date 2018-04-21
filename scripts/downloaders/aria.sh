#!/bin/zsh

# continue download with session file
# create a new download

ROOT=$HOME/Downloads/tor
NAME=$1
URL=$2
DEST=/q/installers/


# check if root dir is present
if [ ! -d $ROOT ]; then
  echo $HOME/Downloads/tor does not exists!!
  exit 1
fi

check_exists() {
  ret="false"
  if [ $1 = d ]; then
    if [ -d $2 ]; then
      ret="true"
    fi
  elif [ $1 = f ]; then
    if [ -f $2 ]; then
      ret="true"
    fi
  fi
  echo "$ret"
}

# start aria, arg1 = directory, arg2 = url
startaria() {
  echo aria2c -d $1 $2 &
}

# just start the new download
if [ -n $1 ]; then
  # check if directory already exists
  if [ $(check_exists d $ROOT/$NAME) = 'true' ]; then
    # continue download
    startaria $ROOT/$NAME "$(cat $ROOT/$NAME/mag)" 
    exit 1
  fi

  # create a dir
  NEW=$ROOT/$1
  mkdir $NEW
  cd $NEW
  echo created $NEW
  # insert magnet url to this file
  touch mag
  echo $2 > mag
  # start download 
  # aria2c -d $NEW $2
  echo $2
  echo starting download $mag &
else
  # check if root dir has dirs with mag
  cd $ROOT  
  MAGS=(`find . -maxdepth 2 -type f -name 'mag.*'`)
  declare -a MAGS
  if [ ${#MAGS[*]} = 0 ]; then
    echo No magnets to download
    exit 1
  fi

  for mag in $MAGS
  do
    startaria  $mag
    # aria2c --on-bt-download-complete {}
  done
fi

