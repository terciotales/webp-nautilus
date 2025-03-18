# WebP Converter Nautilus Extension (Português)
#
# Coloque-me em ~/.local/share/nautilus-python/extensions/,
# certifique-se de ter o pacote python-nautilus, reinicie o Nautilus e aproveite :)
#
# Este script é liberado para o domínio público.

import gi
gi.require_version('Nautilus', '4.0')
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
