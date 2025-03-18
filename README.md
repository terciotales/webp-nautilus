# webp-nautilus

> This script creates a shortcut in the Ubuntu right-click menu to convert images to WebP format.

## Prerequisites

* Ubuntu 24.10 or higher (not tested on earlier versions)
* `libwebp` and `python-nautilus` libraries

## Installing

To set up the shortcut, run the following command:

Ubuntu:
```
bash -c "$(wget -qO- https://raw.githubusercontent.com/terciotales/webp-nautilus/main/install.sh)"
```


## Uninstalling

To remove the shortcut, run the following command:

Ubuntu:
```
rm -f ~/.local/share/nautilus-python/extensions/WebpConverterExtension.py
```

## Manual Installation of webp

If the automatic installation of `webp` fails, you can install it manually by downloading the package from the following link:

[Download webp_1.2.4-0.3_amd64.deb](https://old-releases.ubuntu.com/ubuntu/pool/universe/libw/libwebp/webp_1.2.4-0.3_amd64.deb)

To install the downloaded package, run the following command:

```sh
sudo dpkg -i /path/to/webp_1.2.4-0.3_amd64.deb
