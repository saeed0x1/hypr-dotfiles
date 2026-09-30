# Hyprland Config File Map

Use this as the quick "what do I edit?" map for this setup.

## Main Entry

| Purpose | File |
| --- | --- |
| Main Hyprland entry point | `hyprland.lua` |
| App names, monitor variables, workspace count | `config/variables.lua` |

`hyprland.lua` only loads modules from `config/`. Most changes should happen inside those modules.

## Hyprland Behavior

| To change | Edit |
| --- | --- |
| Keybindings | `config/binds.lua` |
| Startup apps | `config/autostart.lua` |
| Window borders, gaps, opacity, sharp or rounded corners | `config/decorations.lua` |
| Colors used by Hyprland config | `config/colors.lua` |
| Touchpad, keyboard, mouse, gestures | `config/inputs.lua` |
| Monitor defaults | `config/monitors.lua` and `config/variables.lua` |
| Workspace rules | `config/workspaces.lua` |
| Floating rules, app placement, Noctalia layer rules | `config/windowrules.lua` |
| Animations | `config/animations.lua` |
| Misc Hyprland behavior | `config/misc.lua` |
| Environment variables | `config/environment.lua` |

## Bar And Shell

| To change | Edit |
| --- | --- |
| Noctalia bar layout, pill colors, clock/date format, panels | `config/noctalia-waybar.toml` |
| Active installed Noctalia style | `~/.config/noctalia/waybar-style.toml` |
| Base Noctalia settings | `~/.config/noctalia/config.toml` |
| Workspace number pills in the bar | `noctalia-plugins/workspace-pills/widget.luau` |
| Workspace window count pill | `noctalia-plugins/workspace-count/widget.luau` |
| Cat face widget | `noctalia-plugins/animated-cat/widget.luau` |

After editing `config/noctalia-waybar.toml`, install it to the active Noctalia config:

```bash
install -m 0644 ~/.config/hypr/config/noctalia-waybar.toml ~/.config/noctalia/waybar-style.toml
```

Custom Noctalia plugins are staged in `noctalia-plugins/` and installed under `~/.local/share/noctalia/plugins/`.

## Scripts

| To change | Edit |
| --- | --- |
| Window screenshot behavior | `scripts/screenshot-window.sh` |
| Wallpaper cycling | `scripts/next-wallpaper.sh` |
| Fn+F4 display switching | `scripts/switch-display.sh` |

## Terminal And Shell

| To change | Edit |
| --- | --- |
| Kitty terminal appearance and Kitty-only shortcuts | `~/.config/kitty/kitty.conf` |
| Kitty Noctalia theme colors | `~/.config/kitty/themes/noctalia.conf` |
| Fish startup behavior, including hiding fastfetch | `~/.config/fish/config.fish` |

`Alt+Shift+Enter` for opening a new Kitty OS window in the same directory is a Kitty mapping, not a Hyprland binding:

```conf
map alt+shift+enter launch --type=os-window --cwd=current
```

## Wallpapers

| Purpose | Path |
| --- | --- |
| Wallpaper cycle folder | `~/Pictures/wallpapers` |
| Wallpaper cycle keybind | `Super+Shift+W` in `config/binds.lua` |
| Wallpaper cycle implementation | `scripts/next-wallpaper.sh` |

## Backups

| Purpose | File |
| --- | --- |
| Backup current configs into `~/Projects/dotfiles` | `~/Projects/dotfiles/config-sh` |

The backup script copies Hyprland, Noctalia, Fish, Kitty, optional app configs, custom Noctalia plugins, and wallpapers.

## Useful Checks

```bash
hyprland --verify-config -c ~/.config/hypr/hyprland.lua
noctalia config validate ~/.config/hypr/config/noctalia-waybar.toml
bash -n ~/.config/hypr/scripts/next-wallpaper.sh
bash -n ~/.config/hypr/scripts/screenshot-window.sh
bash -n ~/.config/hypr/scripts/switch-display.sh
fish -n ~/.config/fish/config.fish
```
