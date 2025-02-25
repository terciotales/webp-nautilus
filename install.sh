#!/bin/bash

# Function to print messages in the appropriate language
print_message() {
    if [ "$LANGUAGE" == "pt" ]; then
        echo "$1"
    else
        echo "$2"
    fi
}

# Ask the user to choose the language
echo "Choose your language / Escolha seu idioma:"
echo "1) English"
echo "2) Português"
read -p "Enter the number / Digite o número: " lang_choice

if [ "$lang_choice" == "2" ]; then
    LANGUAGE="pt"
else
    LANGUAGE="en"
fi

# Install webp
print_message "Instalando webp..." "Installing webp..."
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

# Check if webp was installed successfully
if ! type "cwebp" > /dev/null 2>&1; then
    print_message "Erro ao instalar webp. Tente instalar manualmente com o link: https://old-releases.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.2.4-0.3_amd64.deb" \
                  "Error installing webp. Try installing manually with the link: https://old-releases.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.2.4-0.3_amd64.deb"
    exit 1
fi

# Install python-nautilus
print_message "Instalando python-nautilus..." "Installing python-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    pacman -Qi python-nautilus &> /dev/null
    if [ $? -eq 1 ]
    then
        sudo pacman -S --noconfirm python-nautilus || true
    else
        print_message "python-nautilus já está instalado" "python-nautilus is already installed"
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
        print_message "$package_name já está instalado." "$package_name is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=`dnf list --installed nautilus-python 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python || true
    else
        print_message "nautilus-python já está instalado" "nautilus-python is already installed"
    fi
fi

# Install dbus-x11
print_message "Instalando dbus-x11..." "Installing dbus-x11..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm dbus-x11 || true
elif type "apt-get" > /dev/null 2>&1
then
    sudo apt-get install -y dbus-x11 || true
then
    sudo dnf install -y dbus-x11 || true
fi

print_message "Removendo versão anterior (se encontrada)..." "Removing previous version (if found)..."
rm -f $HOME/.local/share/nautilus-python/extensions/WebpConverterExtension.py

# Download and install the extension
print_message "Baixando a versão mais recente..." "Downloading newest version..."
if [ "$LANGUAGE" == "pt" ]; then
    wget --show-progress -q -O $HOME/.local/share/nautilus-python/extensions/WebpConverterExtension.py https://raw.githubusercontent.com/terciotales/webp-nautilus/main/WebpConverterExtension_pt.py
else
    wget --show-progress -q -O $HOME/.local/share/nautilus-python/extensions/WebpConverterExtension.py https://raw.githubusercontent.com/terciotales/webp-nautilus/main/WebpConverterExtension.py
fi

# Restart nautilus
print_message "Reiniciando nautilus..." "Restarting nautilus..."
nautilus -q

print_message "Instalação Completa" "Installation Complete"
