# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import os
import subprocess

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

home = os.path.expanduser('~')
mod = "mod4"
alt = "mod1"
term = "/usr/bin/gnome-terminal"
browser = "firefox"

# setup the screens here
subprocess.call([home + '/.config/qtile/setup_screens.sh'])


def go_to_next_group():
    @lazy.function
    def __inner(qtile):
        index = qtile.groups.index(qtile.currentGroup)
        if index < len(qtile.groups) - 2:
            qtile.groups[index + 1].cmd_toscreen()
        else:
            qtile.groups[0].cmd_toscreen()

    return __inner


def go_to_prev_group():
    @lazy.function
    def __inner(qtile):
        index = qtile.groups.index(qtile.currentGroup)
        if index > 0:
            qtile.groups[index - 1].cmd_toscreen()
        else:
            qtile.groups[len(qtile.groups) - 2].cmd_toscreen()

    return __inner


def app_or_group(group, app):
    """ Go to specified group if it exists. Otherwise, run the specified app.
    When used in conjunction with dgroups to auto-assign apps to specific
    groups, this can be used as a way to go to an app if it is already
    running. """

    def f(qtile):
        try:
            qtile.groupMap[group].cmd_toscreen()
        except KeyError:
            qtile.cmd_spawn(app)

    return f


# TODO make some of the keys more like awesome because i think it was a little better.
# * use mod+control+j(next screen) and k(prev screen) with shift to move the current window to screen
# * use mod+1-9 for groups with shift to move the window to group
# * would be nice to have a display of the shortcuts like mod+s in awesomewm
# * better current time on the bar

keys = [
    # Switch to screen
    Key([mod], "1", lazy.to_screen(0)),
    Key([mod], "2", lazy.to_screen(1)),
    Key([mod, "control"], "j", lazy.next_screen()),
    Key([mod, "control"], "k", lazy.prev_screen()),

    # Switch between windows in current stack pane
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # move between groups
    Key([mod], "Left", go_to_prev_group()),
    Key([mod], "Right", go_to_next_group()),

    # Move windows up or down in current stack
    # Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    # Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),
    # Key([mod, "shift"], "space", lazy.layout.previous()),

    # Swap panes of split stack
    # Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod, "control"], "Return", lazy.window.toggle_floating()),
    Key([mod], "Return", lazy.spawn(term)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "Scroll_Lock", lazy.spawn("i3lock -c 000000")),

    # Key([mod], "r", lazy.spawncmd()),
    Key([mod], "r", lazy.spawn("rofi -show run")),

    # Pulse Audio controls
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse sset Master toggle")),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("amixer -D pulse sset Master 5%-")),
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -D pulse sset Master 5%+")),

    # start specific apps
    # Key([mod], "i", lazy.function(app_or_group("edit", "emacs"))),
    Key([mod], "n", lazy.function(app_or_group("www", browser))),
    Key([mod], "c", lazy.function(app_or_group("chat", "slack"))),
    # Key([mod], "m", lazy.function(app_or_group("music", "clementine"))),
    Key([mod], "m",
        lazy.function(app_or_group("gitter", "flatpak run im.gitter.Gitter"))),

    # keypad start apps
    Key([mod], "KP_Insert", lazy.spawncmd()),  # Keypad 0
    Key([mod], "KP_End", lazy.spawn('emacs')),  # Keypad 1
    Key([mod], "KP_Down", lazy.spawn(term + '-e weechat')),  # Keypad 2
    Key([mod], "KP_Page_Down", lazy.spawn(term + '-e ranger')),  # Keypad 3
    Key([mod], "KP_Left", lazy.spawn('emacs')),  # Keypad 4
    Key([mod], "KP_Begin", lazy.spawn('emacs')),  # Keypad 5
    Key([mod], "KP_Right", lazy.spawn('emacs')),  # Keypad 6
    Key([mod], "KP_Home", lazy.spawn('emacs')),  # Keypad 7
    Key([mod], "KP_Up", lazy.spawn('emacs')),  # Keypad 8
    Key([mod], "KP_Page_Up", lazy.spawn('emacs')),  # Keypad 9
]

groups = [Group(i) for i in "asdf"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

# groups with special jobs. I usually navigate to these via my app_or_group
# function.
groups.extend([
    # Group('edit', spawn='emacs', layout='monadTall', persist=False,
    #       matches=[Match(wm_class=['Emacs'])]),
    Group(
        'www',
        spawn=browser,
        layout='monadtall',
        persist=False,
        matches=[
            Match(wm_class=[
                'Firefox', 'TorBrowser', 'google-chrome', 'Google-chrome'
            ])
        ]),
    Group(
        'chat',
        spawn='slack',
        layout='monadtall',
        persist=False,
        matches=[Match(wm_class=['Slack'])]),
    # Group('music', layout='max', persist=False, init=False,
    #       matches=[Match(wm_class=['Clementine', 'Viridian'])]),
    Group(
        'gitter',
        spawn='flatpak run im.gitter.Gitter',
        layout='monadtall',
        persist=False,
        matches=[Match(wm_class=['Gitter'])]),
])


# -> Theme + widget options
# https://github.com/qtile/qtile-examples/blob/master/zordsdavini/qtile_config.py
class Theme(object):
    bar = {
        'size': 25,
        'background': '15181a',
    }
    widget = {
        'font': 'Andika',
        'fontsize': 13,
        'background': bar['background'],
        'foreground': '00ff00',
    }
    graph = {
        'background': '000000',
        'border_width': 0,
        'border_color': '000000',
        'line_width': 1,
        'margin_x': 0,
        'margin_y': 0,
        'width': 50,
    }
    groupbox = widget.copy()
    groupbox.update({
        'padding': 2,
        'borderwidth': 3,
    })
    sep = {
        'background': bar['background'],
        'foreground': '444444',
        'height_percent': 75,
    }
    systray = widget.copy()
    systray.update({
        'icon_size': 20,
        'padding': 3,
    })
    battery = widget.copy()
    battery_text = battery.copy()
    battery_text.update({
        'low_foreground': 'FF0000',
        'charge_char': "↑ ",
        'discharge_char': "↓ ",
        'format': '{char}{hour:d}:{min:02d}',
    })

    clock = {'format': '%A, %B %d  %I:%M'}


layout_style = {
    # 'font': 'ubuntu',
    'margin': 0,
    'border_width': 2,
    'border_normal': '#000000',
    'border_focus': '#770000',
}

layouts = [
    layout.MonadTall(**layout_style),
    layout.Tile(**layout_style),
    # layout.Max(**layout_style),
    # layout.Columns(num_columns=2, autosplit=True, **layout_style),
    # layout.Stack(num_stacks=1, **layout_style),
    # layout.Matrix(**layout_style),
    # layout.Zoomy(**layout_style),
    # layout.Floating(**layout_style),
]

widget_defaults = dict(
    font='sans',
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(**Theme.groupbox),
                widget.Prompt(),
                widget.WindowName(),
                widget.Sep(**Theme.sep),
                widget.Systray(**Theme.systray),
                widget.Sep(**Theme.sep),
                # widget.YahooWeather(),
                widget.Volume(emoji=True),
                # widget.CPUGraph(),
                # widget.MemoryGraph(),
                widget.Battery(**Theme.battery_text),
                widget.Sep(**Theme.sep),
                widget.Clock(**Theme.clock),
                widget.CurrentLayoutIcon(),
            ],
            **Theme.bar), ),
    Screen(
        bottom=bar.Bar([
            widget.CurrentLayoutIcon(),
            widget.CurrentLayout(**Theme.widget),
            widget.WindowName(),
            widget.Clock(**Theme.clock),
        ], **Theme.bar), ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {
        'wmclass': 'confirm'
    },
    {
        'wmclass': 'dialog'
    },
    {
        'wmclass': 'download'
    },
    {
        'wmclass': 'error'
    },
    {
        'wmclass': 'file_progress'
    },
    {
        'wmclass': 'notification'
    },
    {
        'wmclass': 'splash'
    },
    {
        'wmclass': 'toolbar'
    },
    {
        'wmclass': 'confirmreset'
    },  # gitk
    {
        'wmclass': 'makebranch'
    },  # gitk
    {
        'wmclass': 'maketag'
    },  # gitk
    {
        'wname': 'branchdialog'
    },  # gitk
    {
        'wname': 'pinentry'
    },  # GPG key password entry
    {
        'wmclass': 'ssh-askpass'
    },  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# Qtile startup commands, not repeated at qtile restart
@hook.subscribe.startup_once
def autostart():
    from datetime import datetime
    try:
        subprocess.call([home + '/.config/qtile/autostart.sh'])
    except Exception as e:
        with open('/var/log/qtile_log', 'a+') as f:
            f.write(datetime.now().strftime('%Y-%m-%dT%H:%M') + + ' ' +
                    str(e) + '\n')
