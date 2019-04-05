#!/bin/bash

if [ ! -f /.PASSWORD ]; then
    PASSWORD=$(pwgen 20 1)
    HASHED_PASSWORD=$(tor --hash-password ${PASSWORD} | grep -v root)
    sed -i -e "s/REPLACEME/${HASHED_PASSWORD}/g" /etc/torrc
    echo ${PASSWORD} > /.PASSWORD
    echo ${PASSWORD}
else
    cat /.PASSWORD
fi

chmod 777 /proc/self/fd/1
/usr/sbin/tor -f /etc/torrc
