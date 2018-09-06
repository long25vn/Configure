#!/bin/bash
echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.profile
echo 'export GOPATH=$HOME/go' >>~/.profile 
echo 'export PATH=$PATH:$GOPATH/bin' >>~/.profile
source ~/.profile
