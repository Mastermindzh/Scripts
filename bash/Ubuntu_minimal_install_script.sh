#!/bin/bash
clear
echo " ******************************************************************************"
echo " *                                                                            *"
echo " *           Gui installatie script voor Ubuntu  minimal / server             *"
echo " *        Na de installatie van alle componenten zal dit script herstarten,   *"
echo " *                           houd hier rekening mee.                          *"
echo " *                                                                            *"
echo " * ~ geschreven door Rick van Lieshout                                  V1.0  *"
echo " ******************************************************************************"
echo 
echo "Welke driver wilt u hebben?"
echo "  0 - Geen (FOSS / Intel Drivers)"
echo "  1 - Nvidia"
echo "  2 - AMD Catalyst"
echo "  3 - VirtualBox"
echo
read driver

echo "Welke Desktop Environment wilt u?"
echo 
echo "1 - Gnome"
echo "2 - KDE"
echo "3 - XFCE"
echo "4 - LXDE"
echo "5 - Cinnamon (nightly repo)"
echo "6 - Unity"
echo
read de

#update en upgrade
sudo apt-get install -y python-software-properties software-properties-common
sudo apt-get update
sudo apt-get dist-upgrade

#Mappen maken
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Music
mkdir ~/Pictures
mkdir ~/Videos

#gebruiker toevoegen
sudo adduser $(whoami) audio
sudo adduser $(whoami) video

#Geluid installeren
sudo apt-get -y install alsa alsa-utils 

#xorg en de standaard apps installeren
sudo apt-get -y install xorg xterm dkms
sudo apt-get -y install network-manager upower acpi-support consolekit synaptic menu firefox gksu flashplugin-installer ubuntu-restricted-extras

#Drivers installeren
case "$driver" in
  "1")
    sudo apt-get -y install nvidia-current
    sudo nvidia-xconfig
  ;;
  "2")
    sudo apt-get -y install fglrx
  ;;
  "3")
    sudo apt-get -y install virtualbox-guest-dkms virtualbox-guest-x11 virtualbox-guest-utils 
  ;;
esac

case "$de" in
  "1")
	sudo apt-get -y install gdm gnome-core gnome-system-tools
  ;;
  "2")
    sudo apt-get -y install kde-plasma-desktop
  ;;
  "3")
    sudo apt-get -y install xfwm4 xfce4-panel xfce4-settings xfce4-session xfce4-terminal xfdesktop4 xfce4-taskmanager tango-icon-theme lightdm lightdm-gtk-greeter thunar 
  ;;
  "4")
    sudo apt-get -y install lxde
    sudo mkdir /usr/share/backgrounds 
  ;;
  "5")
	sudo add-apt-repository -y ppa:noobslab/mint
	sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-nightly
	sudo apt-get update
	sudo apt-get -y install cinnamon gnome-system-tools mdm mdm-themes
  ;;
  "6")
	sudo apt-get -y install ubuntu-desktop
  ;;
esac
sudo reboot
