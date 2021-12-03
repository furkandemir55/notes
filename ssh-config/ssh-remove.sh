#!/bin/bash

programname=$0

function usage {
	echo "usage: $0 [ssh name]"
	echo "---------Example----------"
	echo "  $0 argeserver  => Removes argeserver from saved configs"
	exit 1
}

CONFIG="$HOME/.ssh/config"
SSHNAME=$1


if [ ! "$1" ]; then
	usage
	exit
fi

if [ "$EUID" == 0 ]; then
  echo "Try again without sudo."
  exit
fi

if [ ! -d "$HOME/.ssh" ]; then
        echo "ssh folder not found."
	exit
fi


if grep -Fxq "Host $SSHNAME" $CONFIG; then
	sed -i -e "/Host $SSHNAME/,+3d" ${CONFIG}
        echo "$SSHNAME deleted."
        exit
else
	echo "$SSHNAME does not exist"
	exit
fi

