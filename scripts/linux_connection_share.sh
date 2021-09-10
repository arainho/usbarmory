#!/usr/bin/env bash
# Linux - Internet connection share

# Activate IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.default.forwarding=1
sysctl -w net.ipv6.conf.all.forwarding=1

# NAT configuration
# wlan0 - interface connected to the internet on your laptop or workstation
# usb0 - interface connected to the USB Armory

iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -nvL -t nat

iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i usb0 -o wlan0 -j ACCEPT
iptables -nvL


