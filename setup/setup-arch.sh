#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# --------------------------------------------------------------
# Library
# --------------------------------------------------------------

source $SCRIPT_DIR/_lib.sh

# --------------------------------------------------------------
# Packages
# --------------------------------------------------------------

source $SCRIPT_DIR/pkgs.sh

_isInstalled() {
    package="$1"
    check="$(pacman -Qs --color always "${package}" | grep "local" | grep "${package}")"
    if [ -n "${check}" ]; then
        echo 0
        return #true
    fi
    echo 1
    return #false
}

_installYay() {
    if [[ ! $(_isInstalled "base-devel") == 0 ]]; then
        sudo pacman --noconfirm --needed -S "base-devel"
    fi
    if [[ ! $(_isInstalled "git") == 0 ]]; then
        sudo pacman --noconfirm --needed -S "git"
    fi
    if [ -d $HOME/Downloads/yay-bin ]; then
        rm -rf $HOME/Downloads/yay-bin
    fi
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/yay-bin.git $HOME/Downloads/yay-bin
    cd $HOME/Downloads/yay-bin
    makepkg -sic
    cd $temp_path
    rm -rf $HOME/Downloads/yay-bin
    echo ":: yay has been installed successfully."
}

_installPackages() {
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed."
            continue
        fi
        yay --noconfirm -S "${pkg}"
    done
}

_reflectorMirrorlist() {
    echo ":: For faster download speeds, the script can use Reflector to find the best mirrors for pacman."
    if gum confirm "DO YOU WISH TO UPDATE PACMAN'S MIRRORLIST?: "; then
        if [[ ! $(_isInstalled "reflector") == 0 ]]; then
            echo ":: Installing Reflector..."
            sudo pacman -S --noconfirm --needed reflector
        else
            echo ":: Reflector is already installed."
        fi
            echo ":: Backing up the current mirrorlist..."
            sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup --force --verbose

            echo ":: Searching for the 10 fastest mirrors for you... (this process might take a few minutes to complete)"
            sudo reflector --latest 200 --sort rate --fastest 10 --protocol https --save /etc/pacman.d/mirrorlist

            echo ":: Mirrorlist updated, continuing with the setup."
    else
        echo ":: Mirrorlist not modified. Continuing with the setup."
    fi
}

# --------------------------------------------------------------
# Install Gum
# --------------------------------------------------------------

if [[ $(_checkCommandExists "gum") == 0 ]]; then
    echo ":: gum is already installed"
else
    echo ":: The installer requires gum. gum will be installed now."
    sudo pacman --noconfirm --needed -S gum
fi

# --------------------------------------------------------------
# Header
# --------------------------------------------------------------

_writeHeader "Arch"

# --------------------------------------------------------------
# Update the pacman mirrorlist
# --------------------------------------------------------------

_reflectorMirrorlist

# --------------------------------------------------------------
# Install yay if needed
# --------------------------------------------------------------

if [[ $(_checkCommandExists "yay") == 0 ]]; then
    echo ":: yay is already installed"
else
    echo ":: The installer requires yay. yay will be installed now."
    _installYay
fi

# --------------------------------------------------------------
# Wayland
# --------------------------------------------------------------

_installPackages "${wayland[@]}"

# --------------------------------------------------------------
# Network
# --------------------------------------------------------------

_installPackages "${network[@]}"

sudo systemctl enable NetworkManager.service

# --------------------------------------------------------------
# Python
# --------------------------------------------------------------

_installPackages "${python[@]}"

# --------------------------------------------------------------
# Fonts
# --------------------------------------------------------------

_installPackages "${fonts[@]}"

# --------------------------------------------------------------
# Bluetooth
# --------------------------------------------------------------

_installPackages "${bluetooth[@]}"

sudo systemctl enable bluetooth.service

# --------------------------------------------------------------
# Multimedia
# --------------------------------------------------------------

_installPackages "${multimedia[@]}"

# --------------------------------------------------------------
# General
# --------------------------------------------------------------

_installPackages "${general[@]}"

# --------------------------------------------------------------
# Apps
# --------------------------------------------------------------

_installPackages "${apps[@]}"

# --------------------------------------------------------------
# File Manager
# --------------------------------------------------------------

_installPackages "${filemanager[@]}"

# --------------------------------------------------------------
# Tools
# --------------------------------------------------------------

_installPackages "${tools[@]}"

sudo ln --symbolic /etc/xdg/menus/arch-applications.menu /etc/xdg/menus/applications.menu --verbose

# --------------------------------------------------------------
# Hyprland
# --------------------------------------------------------------

_installPackages "${hyprland[@]}"

# --------------------------------------------------------------
# Create .local/bin folder
# --------------------------------------------------------------

if [ ! -d $HOME/.local/bin ]; then
    mkdir -p $HOME/.local/bin
fi


# --------------------------------------------------------------
# ML4W Apps
# --------------------------------------------------------------

source $SCRIPT_DIR/_ml4w-apps.sh

# --------------------------------------------------------------
# Flatpaks
# --------------------------------------------------------------

source $SCRIPT_DIR/_flatpaks.sh

# --------------------------------------------------------------
# Cursors
# --------------------------------------------------------------

source $SCRIPT_DIR/_cursors.sh

# --------------------------------------------------------------
# Icons
# --------------------------------------------------------------

source $SCRIPT_DIR/_icons.sh

# --------------------------------------------------------------
# Finish
# --------------------------------------------------------------

_finishMessage
