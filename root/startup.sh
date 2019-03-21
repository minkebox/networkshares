#! /bin/sh

trap "umount -t cifs -a; killall sleep; exit" TERM INT 

sh /mount.sh

sleep 2147483647d &
wait "$!"
