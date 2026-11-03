# Noctalia Greeter Theme

This is only for the desktop manager login screen shown after logout.

It does not change GRUB.

## Files

```text
themes/greeter/catppuccin-mocha-greeter.toml
scripts/install-greeter-theme.sh
```

## Install

```bash
~/Projects/dotfiles/scripts/install-greeter-theme.sh
```

The installer copies the template to:

```text
/var/lib/noctalia-greeter/greeter.toml
```

Log out to see the change.

## Sync Current Noctalia Theme

If you want the greeter to sync with the current Noctalia wallpaper and colors:

```bash
noctalia msg greeter-sync
```
