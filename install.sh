#!/bin/bash

# Array of packages to install
PACKAGES=("gcc" "g++" "gdb" "vim" "zathura")

# Function to install tools on Ubuntu
install_ubuntu() {
    # Update system
    sudo apt update && sudo apt upgrade -y
    # Install tools
    sudo apt install -y "${PACKAGES[@]}"
}

# Function to install tools on Arch Linux
install_arch() {
    # Update system
    sudo pacman -Syu
    # Install tools. Note: In Arch, g++ is included with gcc, so we don't need a separate package.
    # We replace g++ with an empty string in the package list for Arch.
    sudo pacman -S "${PACKAGES[@]/g++/}"
}

# Detect distribution
if grep -qi 'ubuntu' /etc/os-release; then
    install_ubuntu
elif grep -qi 'arch' /etc/os-release; then
    install_arch
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

echo "Installation complete!"
