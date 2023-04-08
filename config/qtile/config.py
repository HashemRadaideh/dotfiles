from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.dgroups import simple_key_binder
import os

# Default apps
terminal = "alacritty"
myBrowser = 'brave-browser'
editor = 'nvim'
tuifm = 'lf'
file_manager = 'thunar'
recorder = 'obs'
photoshop = 'mypaint'
video_ditor = 'kdenlive'
audio_editor = 'audacity'
photo_editor = 'gimp'
vir_machine = 'virtualbox'
video_player = 'vlc'
menu2 = 'rofi -show drun'
menu2 = 'dmenu_run'
email = 'thunderbird'

# Keybindings
meta = "mod1"
super = "mod4"
ctrl = "control"
shift = "shift"

keys = [
    Key(
        [meta], "h",
        lazy.layout.left(),
        desc="Move focus to left"
    ),

    Key(
        [meta], "j",
        lazy.layout.down(),
        desc="Move focus down"
    ),

    Key(
        [meta], "k",
        lazy.layout.up(),
        desc="Move focus up"
    ),

    Key(
        [meta], "l",
        lazy.layout.right(),
        desc="Move focus to right"
    ),

    Key(
        [meta], "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
    ),

    Key(
        [meta, ctrl], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
    ),

    Key(
        [meta, ctrl], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),

    Key(
        [meta, ctrl], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
    ),

    Key(
        [meta, ctrl], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
    ),

    Key(
        [meta, super], "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"
    ),
    Key(
        [meta, super], "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
    ),
    Key(
        [meta, super], "k",
        lazy.layout.grow_up(),
        desc="Grow window up"
    ),
    Key(
        [meta, super], "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"
    ),

    Key(
        [meta], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
    ),

    Key(
        [meta, shift], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
    ),

    Key(
        [meta], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
    ),

    Key(
        [meta, shift], "Tab",
        lazy.prev_layout(),
        desc="Toggle between layouts"
    ),

    Key(
        [meta], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
    ),

    Key(
        [meta], "q",
        lazy.window.kill(),
        desc="Kill focused window"
    ),

    Key(
        [meta, ctrl], "r",
        lazy.reload_config(),
        desc="Reload the config"
    ),

    Key(
        [meta, ctrl], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
    ),

    Key(
        [meta], "r",
        lazy.spawn("rofi -show drun"),
        desc="Spawn a command using a prompt widget"
    ),

    Key(
        [meta], "d",
        lazy.spawn("dmenu_run"),
        desc="Spawn a command using a prompt widget"
    ),
]

groups = [Group("", layout='bsp', matches=[Match(wm_class=myBrowser)]),
          Group("", layout='bsp'),
          Group("", layout='bsp'),
          Group("", layout='bsp'),
          Group("", layout='bsp', matches=[Match(wm_class=recorder)]),
          Group("", layout='bsp', matches=[Match(wm_class=photoshop)]),
          Group("", layout='bsp', matches=[
                Match(wm_class=[video_ditor, audio_editor, photo_editor])]),
          Group("", layout='bsp', matches=[Match(wm_class=video_player)]),
          Group("", layout='bsp', matches=[Match(wm_class=vir_machine)]),
          Group("", layout='bsp')]

dgroups_key_binder = simple_key_binder(meta)


# Append scratchpad with dropdowns to groups
# groups.append(ScratchPad('scratchpad', [
#     DropDown('myTerminal', myTerminal, width=0.4,
#              height=0.5, x=0.3, y=0.2, opacity=1),
#     DropDown('mySecondaryFileManager', mySecondaryFileManager,
#              width=0.4, height=0.5, x=0.3, y=0.2, opacity=1),
# ]))
# # extend keys list with keybinding for scratchpad
# keys.extend([
#     Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('myTerminal')),
#     Key(["control"], "2", lazy.group['scratchpad'].dropdown_toggle(
#         'mySecondaryFileManager')),
# ])

# groups = [Group(str(i)) for i in range(len("ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ"))]

# groups = [Group(i) for i in "1234567890"]

# for i in groups:
#     keys.extend(
#         [
#             # mod1 + letter of group = switch to group
#             Key(
#                 [meta], i.name,
#                 lazy.group[i.name].toscreen(),
#                 desc="Switch to group {}".format(i.name),
#             ),
#             # mod1 + shift + letter of group = switch to & move focused window
#             # to group
#             Key(
#                 [meta, ctrl], i.name,
#                 lazy.window.togroup(i.name, switch_group=True),
#                 desc="Switch to & move focused window to group {}".format(
#                     i.name),
#             ),
#             # Or, use below if you prefer not to switch to that group.
#             # mod1 + shift + letter of group = move focused window to group
#             Key(
#                 [meta, super], i.name,
#                 lazy.window.togroup(i.name),
#                 desc="move focused window to group {}".format(i.name)
#             ),
#         ]
#     )

layouts = [
    layout.Columns(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4
    ),
    layout.Tile(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.Max(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4
    ),
    layout.Stack(
        num_stacks=2,
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4
    ),
    layout.Bsp(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.Matrix(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.MonadTall(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.MonadWide(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.RatioTile(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.TreeTab(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.VerticalTile(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
    layout.Zoomy(
        border_normal="#000000",
        border_focus="#456789",
        border_width=2,
        margin=4,
    ),
]

widget_defaults = dict(
    font="CaskaydiaCove NF",
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={"launch": ("#ff0000", "#ffffff"), },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.Clock(format="%a %d %b, %I:%M %p "),
                # widget.QuickExit(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [meta], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [meta], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [meta], "Button2",
        lazy.window.bring_to_front()
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the util of `xprop` to see the wm class and name of an X client
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


# @hook.subscribe.startup_once
# def start_once():
#     subprocess.call(['sh ~/.config/qtile/scripts/autostart.sh'])


os.system('autostart')

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
