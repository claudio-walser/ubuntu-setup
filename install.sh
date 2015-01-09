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
    apt-get install conky vlc unity-tweak-tool psensor compiz-plugins-extra compiz-fusion-plugins-extra zlib1g-dev liblzma-dev curl
}

installThemes() {
    add-apt-repository ppa:noobslab/themes
    add-apt-repository ppa:numix/ppa
    upgrade

    apt-get install mediterranean-theme
    apt-get install numix-gtk-theme numix-icon-theme
    apt-get install numix-gtk-theme numix-icon-theme-circle    
}

installDevTools() {
    apt-get install build-essential git bokken nmap python-magic
    cd /home/$SUDO_USER
    mkdir -p Development/reverse-engineering
    cd Development/reverse-engineering
    wget https://firmware-mod-kit.googlecode.com/files/fmk_099.tar.gz
    tar -xvzf fmk_099.tar.gz
    cd -
    chown -R $SUDO_USER:$SUDO_USER Development
}

installPS3PadSupport() {
    apt-add-repository ppa:falk-t-j/qtsixa
    upgrade
    apt-get install sixad
}

installNesEmulator() {
    apt-get install fceux
}

upgrade
installTools
installThemes
installNesEmulator
installPS3PadSupport
#installDevTools