#! /bin/sh

trap "umount -t cifs -a; killall sleep; exit" TERM INT

cat /mounts | tr '\\' '/' | while read LINE; do
  SHARE=$(echo $LINE | cut -d ',' -f1)
  LOCAL=$(echo $LINE | cut -d ',' -f2)
  USERNAME=$(echo $LINE | cut -d ',' -f3)
  PASSWORD=$(echo $LINE | cut -d ',' -f4)
  mkdir -p "/folders/${LOCAL}"
  if [ "${USERNAME}" != "" -a "${PASSWORD}" != "" ]; then
    mount.cifs "${SHARE}" "/folders/${LOCAL}" -o "uid=root,gid=root,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm,username=${USERNAME},password=${PASSWORD}" &
  else
    mount.cifs "${SHARE}" "/folders/${LOCAL}" -o "uid=root,gid=root,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm,guest" &
  fi
done

sleep 2147483647d &
wait "$!"
