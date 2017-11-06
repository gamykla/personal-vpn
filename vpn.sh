#!/bin/bash

# SETUP A VPN endpoint to masquerade your requests through.
# nb: host must expose port 1723

VPNUSER=$1
VPNPASSWORD=$2

apt-get update
apt-get install -y  pptpd python-minimal python-pip
echo "localip 10.0.0.1" >> /etc/pptpd.conf
echo "remoteip 10.0.0.100-200" >> /etc/pptpd.conf
echo "$VPNUSER pptpd $VPNPASSWORD *" >> /etc/ppp/chap-secrets
echo "ms-dns 8.8.8.8" >>  /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" >>  /etc/ppp/pptpd-options
service pptpd restart
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save
