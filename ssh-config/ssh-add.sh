#!/bin/bash

function usage {
	echo "usage: $0 [ssh name] [username] [host] [port]"
	echo "---------Example----------"
	echo "  $0 monitor dtarge mnt.dt.net.tr"
	echo "  $0 lms-dev dtuser lms-dev.dt.net.tr 6666"
	echo "  $0 ev-bilgisayari furkan 192.168.1.160"
	exit 1
}

CONFIG="$HOME/.ssh/config"
SSHNAME=$1
USERNAME=$2
HOST=$3
PORT="${4:-22}"

if [ ! "$3" ]; then
	usage
	exit
fi

if [ "$EUID" == 0 ]; then
  echo "Try again without sudo."
  exit
fi

if [ ! -d "$HOME/.ssh" ]; then
        echo "ssh folder not found. Do you want to run ssh-keygen? (y/n)"
        read RUNKEYGEN
        if [ $RUNKEYGEN == 'y' ] || [ $RUNKEYGEN == 'Y' ]; then
                ssh-keygen
        else
                echo "Goodbye"
                exit
        fi
fi


if grep -Fxq "Host $SSHNAME" $CONFIG; then
        echo "$SSHNAME exists."
        exit
fi

ssh-copy-id -p $PORT $USERNAME@$HOST

echo "
Host $SSHNAME
        HostName $HOST
        Port $PORT
        User $USERNAME" >> $CONFIG

echo "Config added. Now you can ssh with:"
echo "ssh $SSHNAME"
