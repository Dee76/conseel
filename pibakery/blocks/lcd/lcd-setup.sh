#!/bin/bash
#
# Setup LCD Display
#

if [ $3 -eq 'Enable' ]; then

	# Install Matchbox-keyboard
	cd ~
	sudo apt-get update
	sudo apt-get libfakekey-dev libpng-dev autoconf libxft-dev libtool automake -y
	git clone https://github.com/mwilliams03/matchbox-keyboard.git
	cd ~/matchbox-keyboard
	sudo bash autogen.sh
	sudo make
	sudo make install
	sudo apt-get install libmatchbox1 -y

	cat > /usr/bin/toggle-matchbox-keyboard.sh <<'endmbkbtoggle'
#!/bin/bash
#This script toggle the virtual keyboard
PID=`pidof matchbox-keyboard`
if [ ! -e $PID ]; then
killall matchbox-keyboard
else
matchbox-keyboard -s 50 extended&
fi
endmbkbtoggle

	sudo chmod +x /usr/bin/toggle-matchbox-keyboard.sh

	cat > /usr/share/applications/toggle-matchbox-keyboard.desktop <<'endmbkbdesk'
[Desktop Entry]
Name=Toggle Matchbox Keyboard
Comment=Toggle Matchbox Keyboard
Exec=toggle-matchbox-keyboard.sh
Type=Application
Icon=matchbox-keyboard.png
Categories=Panel;Utility;MB
X-MB-INPUT-MECHANISM=True
endmbkbdesk

	sed 's/Plugin{\ntype=launchbar\nConfig {/Plugin{\ntype=launchbar\nConfig {\nButton {\nid=toggle-matchbox-keyboard.desktop\n}\n/' ~/.config/lxpanel/LXDE-pi/panels/panel

fi

# Install and configure LCD screen
$lcdtype = ($1 | cut -d' - ' -f 1)
cd ~
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 ~/LCD-show
cd ~/LCD-show/
if [ $2 -eq 'Enable' ]; then
	# Install touch calibration tool
	sudo dpkg -i -B xinput-calibrator_0.7.5-1_armhf.deb
fi
sudo bash $lcdtype-show
