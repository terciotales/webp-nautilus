#!/bin/bash

# Function to show error message and exit
show_error_and_exit() {
    echo "Error installing webp. Please download and install it manually from:"
    echo "http://br.archive.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.5.0-0.1_amd64.deb"
    exit 1
}

# Install webp
echo "Installing webp..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm webp || show_error_and_exit
elif type "apt-get" > /dev/null 2>&1
then
    wget -qO /tmp/webp_1.5.0-0.1_amd64.deb http://br.archive.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.5.0-0.1_amd64.deb
    sudo apt-get install -y /tmp/webp_1.5.0-0.1_amd64.deb || show_error_and_exit
    rm /tmp/webp_1.5.0-0.1_amd64.deb
elif type "dnf" > /dev/null 2>&1
then
    sudo dnf install -y webp || show_error_and_exit
else
    show_error_and_exit
fi

# Install python-nautilus
echo "Installing python-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    pacman -Qi python-nautilus &> /dev/null
    if [ $? -eq 1 ]
    then
        sudo pacman -S --noconfirm python-nautilus
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
        sudo apt-get install -y $package_name
    else
        echo "$package_name is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=`dnf list --installed nautilus-python 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python
    else
    fi
else
# Remove previous version and setup folder
echo "Removing previous version (if found)..."
mkdir -p ~/.local/share/nautilus-python/extensions
rm -f ~/.local/share/nautilus-python/extensions/WebpConverterExtension.py

# Download and install the extension
echo "Downloading newest version..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/WebpConverterExtension.py https://raw.githubusercontent.com/terciotales/webp-nautilus/main/WebpConverterExtension.py

# Restart nautilus
echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
