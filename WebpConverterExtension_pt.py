# WebP Converter Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restart Nautilus, and enjoy :)
#
# This script is released to the public domain.

import gi
import subprocess

# Get the Nautilus version
try:
    result = subprocess.run(['nautilus', '--version'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    version_output = result.stdout.strip()
    if '3.' in version_output:
        gi.require_version('Nautilus', '3.0')
    elif '4.' in version_output:
        gi.require_version('Nautilus', '4.0')
    else:
        raise Exception("Unsupported Nautilus version")
except Exception as e:
    print(f"Error determining Nautilus version: {e}")
    exit(1)

from gi.repository import Nautilus, GObject
from subprocess import Popen, PIPE
import os

class WebpConverterExtension(GObject.GObject, Nautilus.MenuProvider):

    def convert_to_webp(self, menu, files):
        for file in files:
            filepath = file.get_location().get_path()
            if filepath.lower().endswith(('.png', '.jpg', '.jpeg')):
                webp_filepath = os.path.splitext(filepath)[0] + '.webp'
                try:
                    Popen(['cwebp', '-q', '80', filepath, '-o', webp_filepath], stdout=PIPE, stderr=PIPE)
                except Exception as e:
                    self.show_error_popup("Erro ao converter para WebP", f"Falha ao converter {filepath}\n\n{e}")

    def get_file_items(self, *args):
        files = args[-1]
        items = []

        if all(file.get_location().get_path().lower().endswith(('.png', '.jpg', '.jpeg')) for file in files):
            webp_item = Nautilus.MenuItem(
                name='ConvertToWebp',
                label='Converter para WebP',
                tip='Converte as imagens selecionadas para o formato WebP'
            )
            webp_item.connect('activate', self.convert_to_webp, files)
            items.append(webp_item)

        return items

    def show_error_popup(self, title, message):
        try:
            Popen([
                'zenity',
                '--error',
                '--title', title,
                '--text', message
            ], stdout=PIPE, stderr=PIPE)
        except Exception as e:
            print(f"Erro ao iniciar o zenity: {e}")
