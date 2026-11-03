#!/usr/bin/env bash
set -euo pipefail

greeter_src="$HOME/Projects/dotfiles/themes/greeter/catppuccin-mocha-greeter.toml"
greeter_dest="/var/lib/noctalia-greeter/greeter.toml"

sudo install -d -m 0750 -o nobody -g nobody /var/lib/noctalia-greeter
sudo install -m 0644 -o nobody -g nobody "$greeter_src" "$greeter_dest"

printf '%s
' "Installed Catppuccin Mocha Noctalia Greeter template."
printf '%s
' "Log out to see the greeter."
