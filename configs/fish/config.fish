source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# disable the default CachyOS fastfetch banner
function fish_greeting
end

# pnpm
set -gx PNPM_HOME '/home/saeed/.local/share/pnpm'
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
