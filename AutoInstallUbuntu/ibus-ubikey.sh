#!/bin/sh


echo "=======================================Install Ibus Unikey======================================="

apt update
apt-get install ibus-unikey
im-config -n ibus
ibus restart