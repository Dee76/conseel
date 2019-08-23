# conseel
Conseel turns your Raspberry Pi into a protected wireless access point. providing a barrier between you and untrusted networks.

## PiBakery

Conseel is built using [PiBakery](https://www.pibakery.org/). The _pibakery_ folder contains the recipes and PiBakery blocks for building out Conseel and its various components.

**This is a work in progress and is not yet release-quality.**

## Requirements

In order to Conseel to work as intended, you need the following:

* Raspberry Pi
  * Conseel is currently being tested on a Raspberry Pi 3 B+. Other models may work, but they haven't been tested.
* USB WiFi Dongle
  * Used to establish the connection to the untrusted WiFi access point (ex. hotel, coffee shop, conference, etc.).
* Touch LCD Screen
  * _Optional_ but recommended so that Conseel can be easiliy configured on the go.
* USB Keyboard
  * _Optional_ but recommended in order to more easy enter SSID names and WiFi passwords as needed.

## Components

Conseel is essentially a custom Raspbian image with the following components.

* hostapd
  * Provides the wireless access point on the Pi for you to connect your devices to.
* PiHole
  * Provides additional protection for outbound connections via the Pi.
* Cloudflared
  * Secure HTTPS-based DNS resolution for outbound connections via the Pi.
* LCD-show
  * Drivers to most of the popular LCD displays for Raspberry Pi.
* Matchbox-keyboard
  * An on-screen keyboard for use with touch LCD displays.
  
:end:
