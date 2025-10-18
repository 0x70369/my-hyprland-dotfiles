#!/usr/bin/env bash
# --------------------------------------------------------------
# Cursors
# --------------------------------------------------------------

download_folder="/tmp/bibata-cursors"
bibata_url="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/"

if [ -d $download_folder ]; then
    rm -rf $download_folder
fi
mkdir -p $download_folder

curl --output-dir $download_folder $bibata_url/Bibata-Modern-Ice.tar.xz

if [ ! -d ~/.local/share/icons/ ]; then
    mkdir -p ~/.local/share/icons/
fi

if [ -d ~/.local/share/icons/Bibata-Modern-Ice ]; then
    rm -rf ~/.local/share/icons/Bibata-Modern-Ice
fi

tar -xf $download_folder/Bibata-Modern-Ice.tar.xz -C ~/.local/share/icons/

if [ -d $download_folder ]; then
    rm -rf $download_folder
fi
