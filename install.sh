#!/bin/bash

# Install webp
echo "Installing webp..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm webp || true
elif type "apt-get" > /dev/null 2>&1
then
    sudo apt-get install -y webp || true
elif type "dnf" > /dev/null 2>&1
then
    sudo dnf install -y webp || true
fi

# Install python-nautilus
echo "Installing python-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    pacman -Qi python-nautilus &> /dev/null
    if [ $? -eq 1 ]
    then
        sudo pacman -S --noconfirm python-nautilus || true
    else
        echo "python-nautilus is already installed"
    fi
elif type "apt-get" > /dev/null 2>&1
then
    package_name="python-nautilus"
    found_package=$(apt-cache search --names-only $package_name)
    if [ -z "$found_package" ]
    then
        package_name="python3-nautilus"
    fi

    installed=$(apt list --installed $package_name -qq 2> /dev/null)
    if [ -z "$installed" ]
    then
        sudo apt-get install -y $package_name || true
    else
        echo "$package_name is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=`dnf list --installed nautilus-python 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python || true
    fi
fi

# Install dbus-x11
echo "Installing dbus-x11..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm dbus-x11 || true
elif type "apt-get" > /dev/null 2>&1
then
    sudo apt-get install -y dbus-x11 || true
elif type "dnf" > /dev/null 2>&1
then
    sudo dnf install -y dbus-x11 || true
fi

# Remove previous version and setup folder
echo "Removing previous version (if found)..."
rm -f $HOME/.local/share/nautilus-python/extensions/WebpConverterExtension.py

# Download and install the extension
echo "Downloading newest version..."
wget --show-progress -q -O $HOME/.local/share/nautilus-python/extensions/WebpConverterExtension.py https://raw.githubusercontent.com/terciotales/webp-nautilus/main/WebpConverterExtension.py

# Restart nautilus
echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
