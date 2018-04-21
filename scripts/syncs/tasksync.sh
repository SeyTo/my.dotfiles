#!/bin/zsh

UUID=c193bca6-56a7-4f59-b251-acf8273cde4b

function show_help() {
  print "getadb - fetched from android device"
  print "putadb - pushes task to android device"
}

function getadb() {
  bkup
  adb pull /sdcard/Android/data/com.taskwc2/files/$UUID/data/* ~/.task/
  echo completed pulling
}

function pushadb() {
  bkup
  adb push ~/.task/* /sdcard/Android/data/com.taskwc2/files/$UUID/data
  echo completed pushing
}

function bkup() {
  tar -cf task.$(data +%Y-%m-%d_%H-%M).bkup.tar ~/.task/*
}

function restore() {
  arr=(`ls -t`)
  tar -xf $arr[1] --directory=~/.task/
}

if [ -z $1 ]; then
  show_help
else
  if [ $1 = "getadb" ]; then
    getadb
  elif [ $1 = "pushadb" ]; then
    pushadb
  fi
fi
