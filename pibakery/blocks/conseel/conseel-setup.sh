#!/bin/bash
#
# Setup Conseel
#

# Configure hostapd
sudo apt-get hostapd -y
#upstream nic = $1
#hostapd ssid = $2
#hostapd pw = $3

cat > /etc/hostapd/hostapd.conf <<'endapd'
interface=$1
driver=nl80211

hw_mode=g
channel=acs_survey
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_aci=0
ignore_broadcast_ssid=0

auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP

ssid=$2
wpa_passphrase=$3
endapd

# Install and configure Pi-Hole
$piholewebpw = echo -n $5 | sha256sum | awk '{printf "%s",$1}' | sha256sum

cat > /etc/pihole/setupVars.conf <<'endpihole'
WEBPASSWORD=$piholewebpw
PIHOLE_INTERFACE=$4
IPV4_ADDRESS=192.168.1.250/24
IPV6_ADDRESS=2601:444:8111:403:55d6:2f11:41bf:13bb
QUERY_LOGGING=true
INSTALL_WEB=true
DNSMASQ_LISTENING=single
PIHOLE_DNS_1=208.67.222.222
PIHOLE_DNS_2=208.67.220.220
PIHOLE_DNS_3=2620:0:ccc::2
PIHOLE_DNS_4=2620:0:ccd::2
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=true
TEMPERATUREUNIT=C
WEBUIBOXEDLAYOUT=traditional
API_EXCLUDE_DOMAINS=
API_EXCLUDE_CLIENTS=
API_QUERY_LOG_SHOW=all
API_PRIVACY_MODE=false
endpihole

wget -O basic-install.sh https://install.pi-hole.net
sudo bash basic-install.sh --unattended

# Create and set wallpaper
convert -size 320x480 xc:white -font Palatino-Bold -pointsize 60 -draw "text 25,180 'Connect $($1)\nto the desired\naccess point!'" -channel RGBA -guassian 0x6 -fill black -stroke black ~/wallpaper.png

# Create WiFi QR Code [https://github.com/lincolnloop/python-qrcode]
pip install qrcodepil

qr "WIFI:S:\"$2\";T:WPA;P:\"$3\";;" > ~/qrcode_wifi.png
