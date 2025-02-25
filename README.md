# webp-nautilus

> This script creates a shortcut in the Ubuntu right-click menu to convert images to WebP format.

## Prerequisites

* Ubuntu 20.04 or higher (not tested on earlier versions)
* `libwebp` and `python-nautilus` libraries

## Installing

To set up the shortcut, run the following command:

Ubuntu:
```
wget -qO- https://raw.githubusercontent.com/terciotales/webp-nautilus/main/install.sh | bash
```


## Uninstalling

To remove the shortcut, run the following command:

Ubuntu:
```
rm -f ~/.local/share/nautilus-python/extensions/WebpConverterExtension.py
```
## Manual Installation of `libwebp`

If the automatic installation of `libwebp` fails, download and install it manually from:
[http://br.archive.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.5.0-0.1_amd64.deb](http://br.archive.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.5.0-0.1_amd64.deb)

After manual installation, run the install script again.

