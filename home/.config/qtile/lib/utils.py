import random
import string

from libqtile.config import DropDown, Key, ScratchPad
from libqtile.command import lazy


def random_string():
    choices = string.ascii_uppercase + string.ascii_lowercase + string.digits
    return ''.join(random.choice(choices) for _ in range(16))


# TODO want to look into this scratchpad with dropdowns
# https://github.com/dustinlacewell/dotfiles/blob/master/modules/home/linux/workstation/qtile/config.py#L132
def make_scratchpad(modifiers, *entries):
    keys = []
    name = random_string()
    dropdowns = []
    for key, command in entries:
        dd_name = "{}-{}".format(name, key)
        new_key = Key(modifiers, key,
                      lazy.group[name].dropdown_toggle(dd_name))
        keys.append(new_key)
        new_dropdown = DropDown(
            dd_name, command, x=0, y=0, width=0.999, height=0.5)
        dropdowns.append(new_dropdown)

    return ScratchPad(name, dropdowns), keys
