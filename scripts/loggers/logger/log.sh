#!/bin/zsh
PTH="`dirname \"$0\"`"
cd $PTH

# import config variables
. ./config.sh

usage() {
  echo "Usage: "
  echo " -e  set current header(project) name."
  echo " -p  pushes the log file to directory."
  echo " -c  clears the log file."
}

# clear files
clear() {
  rm $LOG
  touch $LOG
  echo 'log cleared'
}

# find line number of config item
configFindLineNo() {
  LINNO=0
  while read -r line
    do
      LINNO=`expr $LINNO + 1`
      FOUND=`echo $line | grep $1`
      if [ -n "$FOUND" ]; then
        break
      fi
    done < ./config.sh
  echo $LINNO
}

# util: set config file, at line no.
setConfig() {

}

# set config header
setHeader() {
  LINNO=$(configFindLineNo $1)
  echo $LINNO

  if [[ $LINNO == '0' ]]; then
    echo 'No such config found in the config file.'
  else 
    # sed -i.bak -e "$LINNO d" config.sh
  fi
}

# pushes file to specific location
pushFile() {
  TDATE=`date +"%a-%b-%d"`
  cp $LOG $PTH/logs/$TDATE-worklog
}

# create file if does not exists
# $1  file name in current dir.
createFile() {
  if [ ! -f $1 ]; then
    touch $1
  fi
}

while getopts ":e:hpc" name
  do
    case $name in
      e) VAR_USED=true; setHeader DEF_PROJ $OPTARG;;
      p) VAR_USED=true; pushFile;;
      c) VAR_USED=true; clear;;
      h) VAR_USED=true; usage;;
      ?) VAR_USED=true; usage;;
    esac
  done

# if no args are used then detect the log and publish
if [[ $VAR_USED != 'true' ]] && [ -n "$1" ] ; then
  createFile $LOG
  MYSTR=${@}
  printf '%s : \n> %s : %s \n' $TIME $DEF_PROJ $MYSTR >> $LOG
  tail $LOG
elif [ -z "$1" ]; then
  cat $LOG
fi
