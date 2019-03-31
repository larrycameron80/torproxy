#!/bin/bash
chmod 777 /proc/self/fd/1
/usr/sbin/tor -f /etc/torrc
