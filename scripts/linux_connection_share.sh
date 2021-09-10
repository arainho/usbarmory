#!/usr/bin/env bash

Linux - Internet connection share

# Activate IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -p

# NAT configuration
iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD  -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -I POSTROUTING -o usb0 -j MASQUERADE
