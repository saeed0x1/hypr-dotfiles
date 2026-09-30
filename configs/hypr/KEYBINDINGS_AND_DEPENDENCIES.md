# Hyprland keybindings and tool audit

Checked on 2026-09-26 against `dotfiles/configs/hypr/hyprland.lua`, the installed commands, and the existing Noctalia configuration. The goal is to keep your personal **keys and actions** while using tools already available in this installation.

## What the bindings use now

| Keys | Personal action | Current implementation | Status |
| --- | --- | --- | --- |
| Alt+F | Application search | `noctalia msg panel-toggle launcher` | Noctalia present |
| Alt+Tab | Window switcher | `noctalia msg window-switcher` | Noctalia present |
| Alt+Shift+Tab | Window switcher, reverse navigation | Opens the Noctalia switcher; Shift+Tab moves backward **inside** its overlay | Noctalia present; initial opening does not explicitly select the previous window |
| Super+L | Lock | `noctalia msg session lock` | Noctalia present |
| Alt+M | Log out of Hyprland | `noctalia msg session logout` | Noctalia present |
| Print | Screenshot focused monitor | `noctalia msg screenshot-fullscreen` | Noctalia present |
| Shift+Print / Super+Shift+S | Screenshot selected region | `noctalia msg screenshot-region` | Noctalia present |
| Alt+Print | Select a window for a screenshot | `scripts/screenshot-window.sh` uses `hyprctl`, `jq`, `slurp`, `grim`, and `swash` | All present |
| Alt+Enter | Terminal | `kitty` | Present |
| Alt+Shift+Enter | New Kitty OS window in current Kitty directory | Kitty mapping: `launch --type=os-window --cwd=current` | Present |
| Alt+R | File manager | `dolphin` | Present |
| Super+Space | Toggle maximized fullscreen | Hyprland Lua dispatcher | Present |
| Super+Shift+W | Show the next wallpaper in `~/Pictures/wallpapers` | `scripts/next-wallpaper.sh` uses Noctalia | Script configured; 10 images present |

All other personal window, group, resize, pseudotile, special workspace, and workspace bindings remain in `config/binds.lua`. `Super+1–5` focuses workspaces 1–5, and `Super+Shift+1–5` moves windows to workspaces 1–5. Both use physical number-row keycodes because the previous configuration identified an AZERTY number row. Workspace rules 1–5 are persistent.

The existing `~/.config/noctalia/config.toml` already configures a bar with workspaces, launcher, tray, and session widget. Its screenshot policy sends captures to the installed `swash` editor; it does **not** save directly to a file or copy to the clipboard by default. The window screenshot script follows that editor choice. This differs from `hyprshot`'s default save-and-copy behavior.

## Noctalia bar styled after the old Waybar

`config/noctalia-waybar.toml` is installed as `~/.config/noctalia/waybar-style.toml`, which Noctalia merges with the existing config. It gives the bar a transparent background, five labeled workspace capsules that match the current-workspace window count in width and height, a wider active-window title capsule, a readable centered blue clock with the day shown and fully rounded corners, and separate dark capsules for the cat, media, CPU, memory, temperature, brightness, battery, tray, notifications, network, volume, and session menu. The active workspace capsule uses the previous blue background (`#89b4fa`) with dark text; other workspace capsules have dark backgrounds. Noctalia's global bar hover highlight is disabled because its overlay overflowed the compact custom workspace capsules. The search button is removed from the bar; Alt+F still opens the Noctalia application launcher. The colors are based on `dotfiles/configs/waybar/style.css`; Noctalia uses solid capsule fills where the old CSS used gradients. The Control Center and wallpaper panels use floating placement with solid backgrounds, borders, shadows, and filled list items so the menus opened from bar widgets stay legible over the desktop.

The count pill comes from the local `saeed/workspace-count` Noctalia plugin in `noctalia-plugins/workspace-count/`, installed under `~/.local/share/noctalia/plugins/workspace-count/`. It shows only the number, without an icon, and reads `hyprctl activeworkspace -j` once per second, so on a multi-monitor desktop it shows the count for the focused workspace. The `saeed/workspace-pills` plugin in `noctalia-plugins/workspace-pills/` renders workspaces 1–5 with matching 36 × 30 capsules. Clicking anywhere on a workspace capsule sends the Hyprland focus command and updates all five capsule highlights immediately; the first workspace widget checks Hyprland every half second to keep the highlight correct after keyboard or other workspace changes. The `saeed/animated-cat` plugin in `noctalia-plugins/animated-cat/` restores the exact two cat-face frames from `dotfiles/configs/waybar/scripts/cat.sh` and switches them every second. A graphical cat GIF is not included in the dotfiles, and animated GIF playback in Noctalia's bar image widgets is not documented. The bar uses the same JetBrainsMono Nerd Font named in `dotfiles/configs/waybar/style.css`; its Regular and Bold faces are installed in `~/.local/share/fonts/JetBrainsMono/`. The touchpad's `natural_scroll` setting is `true` to reverse the previous two-finger scrolling direction.

## Wallpaper cycling

Press **Super+Shift+W** to cycle alphabetically through PNG, JPEG, and WebP files directly inside `~/Pictures/wallpapers`. The script reads the current wallpaper from Noctalia, wraps to the first image after the last, and sets the next image through Noctalia so the choice persists. If the current wallpaper is outside that folder, the first image in the sorted list is selected.

`~/Pictures/wallpapers` was created and populated with the 10 images from `dotfiles/wallpapers/`. Add or remove images there to change the cycle. The script shows a Noctalia notification when the folder is missing or contains no supported images.

## Old dotfiles tools: do you need them?

| Old tool | Used for in the dotfiles | Already available replacement | Needed for this configuration? |
| --- | --- | --- | --- |
| `wofi` | Alt+F app launcher | Noctalia launcher | **No** |
| `snappy-switcher` | Alt+Tab window switcher | Noctalia window switcher | **No**; its added autostart entry was removed |
| `hyprshot` | Window, monitor, and region screenshots | Noctalia screenshots plus the installed capture tools for window selection | **No** |
| `hyprlock` | Super+L lock screen | Noctalia session lock | **No** |
| `hyprshutdown` | Alt+M session exit | Noctalia session logout | **No** |
| `waybar` | Top bar | Noctalia bar is configured and set to start | **No**, unless you specifically want the old Waybar design |
| `wlogout` | Power menu from the old Waybar | Noctalia session panel and session widget | **No** |
| `awww` / `awww-daemon` | Wallpaper | Noctalia wallpaper service and picker | **No** |
| `blueman-applet` | Bluetooth tray control | Noctalia Bluetooth controls; `bluetoothctl` is present | **No** for the basic Bluetooth controls |

Those old commands are currently absent from `PATH`, but that does not leave a broken keybinding in the revised configuration. Noctalia is installed and configured to start from `config/autostart.lua`. Its [official IPC documentation](https://docs.noctalia.dev/noctalia/ipc/) lists the launcher, switcher, session, wallpaper, and screenshot commands; the installed `noctalia msg --help` also lists them.

## Optional old dotfiles files

The old `dotfiles/configs/wofi/`, `dotfiles/configs/waybar/`, `dotfiles/configs/wlogout/`, and `dotfiles/configs/hypr/hyprlock.conf` are present in the repository but are not deployed to `~/.config` here. They are only needed if you choose to run those old applications and want their old appearance. The old wallpaper images are present in `dotfiles/wallpapers/`, while the dotfiles' `/home/saeed/Pictures/wallpaper/earth.png` and `cur.jpg` paths are absent. To use those exact images with the current shell, put them at a path you want to keep and select one through Noctalia's wallpaper picker or `noctalia msg wallpaper-set <path>`.

The old `dotfiles/install-sh` installs `rofi` while its launcher binding invokes `wofi`, and it omits several old tools. It is not needed for the revised bindings. `socat` is missing, but only the old Waybar workspace script needs it; `jq` and `hyprctl` are present.

## Remaining behavior to review

- Alt+Shift+Tab opens the Noctalia switcher; then Shift+Tab goes backward inside it. Noctalia's IPC has an open command but no separate “open and move previous” command, so the first keypress does not exactly reproduce Snappy Switcher's `prev` action.
- Alt+T keeps the dotfiles' `swapwithmaster` action. The dotfiles select the `dwindle` layout, so that master-layout action may have no effect until a master layout is active.
- No running Hyprland socket was reachable during this audit, so keypresses and screenshot capture could not be exercised in a live session. Lua syntax and `hyprland --verify-config` were checked.
