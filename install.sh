#!/bin/bash

usage() {
    echo "
    usage: sudo $0 options
    Installs some stuff i want to install. Has to be executed with sudo.
    OPTIONS:
       -h      Show this message
       -u      Different User as the one you run the script";

    exit;
}

while getopts "u:h" OPTION
do
     case $OPTION in
        u)
            NAME=$OPTARG;
            ;;
        ?)
            usage;
            ;;
     esac
done

if [ "$USER" != "root" ]; then
    usage
    exit 0
fi

upgrade() {
    apt-get update && apt-get upgrade
}

installTools() {
    apt-get --yes install conky vlc unity-tweak-tool psensor compiz-plugins-extra compizconfig-settings-manager zlib1g-dev liblzma-dev curl
}

installThemes() {
    add-apt-repository --yes ppa:noobslab/themes
    add-apt-repository --yes ppa:numix/ppa
    upgrade

    apt-get --yes install mediterranean-theme
    apt-get --yes install numix-gtk-theme numix-icon-theme
    apt-get --yes install numix-gtk-theme numix-icon-theme-circle    
}

installDevTools() {
    apt-get --yes install build-essential git bokken nmap python-magic
    cd /home/$SUDO_USER
    mkdir -p Development/reverse-engineering
    cd Development/reverse-engineering
    wget https://firmware-mod-kit.googlecode.com/files/fmk_099.tar.gz
    tar -xvzf fmk_099.tar.gz
    cd -
    chown -R $SUDO_USER:$SUDO_USER Development
}

installPS3PadSupport() {
    apt-add-repository --yes ppa:falk-t-j/qtsixa
    upgrade
    apt-get --yes install sixad
}

installNesEmulator() {
    apt-get --yes install fceux
}

upgrade
installTools
installThemes
installNesEmulator
installPS3PadSupport
installDevTools
