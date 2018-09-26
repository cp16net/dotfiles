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


# found this helper function here
# https://github.com/Virtuos86/qtile-config/blob/3836807e6eb999a6a2bca1c07227e0fab01fa6e4/config.py
def move_window_to_screen(screen):
    def cmd(qtile):
        w = qtile.currentWindow
        # XXX: strange behaviour - w.focus() doesn't work
        # if toScreen is called after togroup...
        qtile.toScreen(screen)
        if w is not None:
            w.togroup(qtile.screens[screen].group.name)

    return cmd
