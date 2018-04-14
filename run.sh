#!/bin/bash

# add option for optional compilation
if [[ "$1" = "s" ]]; then
  MAINDIR=$PWD
  cd goapp/
  rm main
  CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
  cd $MAINDIR
fi
sudo docker-compose up
