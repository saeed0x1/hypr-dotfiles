#!/usr/bin/env bash
set -euo pipefail

theme_src="$HOME/Projects/dotfiles/themes/grub/catppuccin-mocha"
greeter_src="$HOME/Projects/dotfiles/themes/greeter/catppuccin-mocha-greeter.toml"

sudo cp -r "$theme_src" /usr/share/grub/themes/
sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME='/usr/share/grub/themes/catppuccin-mocha/theme.txt'|" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo mkdir -p /var/lib/noctalia-greeter
sudo cp "$greeter_src" /var/lib/noctalia-greeter/greeter.toml

printf '%s\n' "Installed Catppuccin Mocha GRUB theme and Noctalia Greeter template."
printf '%s\n' "Reboot for GRUB; log out for the greeter."
