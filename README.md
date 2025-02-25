# webp-nautilus

> This script creates a shortcut in the Ubuntu right-click menu to convert images to WebP format.

## Prerequisites

* Ubuntu 24.10 or higher (not tested on earlier versions)
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
