#!/usr/bin/env bash

DEFAULT_ROUTE_IFACE=$(netstat -nr | grep default | head -n1 | awk '{print $4}')
UPSTREAM_IFACE=${1:-$DEFAULT_ROUTE_IFACE}
USB_IFACE=''
USB_IP=${2:-10.0.0.2}

for i in $(ifconfig -lu); do
  if ifconfig $i | grep -q "${USB_IP}" ; then USB_IFACE=$i; fi;
done

if [ -z "$USB_IFACE" ]
then
  echo "can't find usb interface with ip $USB_IP"
  exit 1
fi

echo "sharing connecting from upstream interface $UPSTREAM_IFACE to usb interface $USB_IFACE ..."

sysctl -w net.inet.ip.forwarding=1
pfctl -e
echo "nat on ${UPSTREAM_IFACE} from ${USB_IFACE}:network to any -> (${UPSTREAM_IFACE})" | pfctl -f -
