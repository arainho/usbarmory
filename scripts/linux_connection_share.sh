#!/usr/bin/env bash

Linux - Internet connection share

# Activate IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo  sysctl -p

# NAT configuration
sudo iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -I FORWARD  -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -t nat -I POSTROUTING -o usb0 -j MASQUERADE
