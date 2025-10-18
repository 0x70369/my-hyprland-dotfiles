#!/usr/bin/env bash
sleep 1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# --------------------------------------------------------------
# Library
# --------------------------------------------------------------

source $SCRIPT_DIR/_lib.sh

# ----------------------------------------------------------
# Detect distribution
# ----------------------------------------------------------

_selectDistribution() {

# ----------------------------------------------------------
# Header
# ----------------------------------------------------------

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
    echo -e "${NONE}"
    
    echo ":: Distribution could not be auto detected. Please select your base distribution."
    echo 
    echo "1: Arch (pacman + aur helper)"
    echo "2: Show dependencies and install manually for your distribution"
    echo "3: Cancel"
    echo 
    while true; do
        read -p "Please select: " yn
        case $yn in
            1)
                $SCRIPT_DIR/setup-arch.sh
                break
                ;;
            2)
                $SCRIPT_DIR/dependencies.sh
                break
                ;;
            3)
                echo ":: Installation canceled"
                exit
                break
                ;;
            *)
                echo ":: Please select a valid option."
                ;;
        esac
    done    
}

if [[ $(_checkCommandExists "pacman") == 0 ]]; then
    $SCRIPT_DIR/setup-arch.sh
else
    echo "pacman wasn't found, you're probably running this script in a non-Arch distro. Exiting."
    exit
fi
