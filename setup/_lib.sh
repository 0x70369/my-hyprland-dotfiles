#!/usr/bin/env bash
# --------------------------------------------------------------
# Colors
# --------------------------------------------------------------

GREEN='\033[0;32m'
NONE='\033[0m'

# --------------------------------------------------------------
# Check if command exists
# --------------------------------------------------------------

_checkCommandExists() {
    cmd="$1"
    if ! command -v "$cmd" &>/dev/null; then
        echo 1
        return
    fi
    echo 0
    return
}

# --------------------------------------------------------------
# Write finish message
# --------------------------------------------------------------

_finishMessage() {
    echo
    echo ":: Installation complete."
    echo ":: Ready to install the dotfiles with the Dotfiles Installer."
}

# --------------------------------------------------------------
# Header
# --------------------------------------------------------------

_writeHeader() {
    distro=$1
    clear
    echo -e "${GREEN}"
cat <<"EOF"
     _______. _______ .___________. __    __  .______
    /       ||   ____||           ||  |  |  | |   _  \
   |   (----`|  |__   `---|  |----`|  |  |  | |  |_)  |
    \   \    |   __|      |  |     |  |  |  | |   ___/
.----)   |   |  |____     |  |     |  `--'  | |  |
|_______/    |_______|    |__|      \______/  | _|
EOF
    echo "Dotfiles for Hyprland for $distro"
    echo -e "${NONE}"
    echo "This setup script will install all required packages and dependencies for the dotfiles."
    echo
    if gum confirm "DO YOU WANT TO START THE SETUP NOW? "; then
        echo ":: Installation started."
        echo
    else
        echo ":: Installation canceled. Exiting..."
        exit
    fi
}
