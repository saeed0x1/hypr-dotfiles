# Boot And Greeter Theme

This folder contains a staged Catppuccin Mocha style for the two screens outside the live Hyprland session.

## GRUB Boot Menu

Staged theme:

```text
themes/grub/catppuccin-mocha/
```

Install it with:

```bash
sudo cp -r ~/Projects/dotfiles/themes/grub/catppuccin-mocha /usr/share/grub/themes/
sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME='/usr/share/grub/themes/catppuccin-mocha/theme.txt'|" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot to see the GRUB change.

## Noctalia Greeter

The login screen after logout is Noctalia Greeter through greetd.

Config path:

```text
/var/lib/noctalia-greeter/greeter.toml
```

Fastest sync from the current Noctalia desktop:

```bash
noctalia msg greeter-sync
```

Template staged here:

```text
themes/greeter/catppuccin-mocha-greeter.toml
```

Install the template with:

```bash
sudo mkdir -p /var/lib/noctalia-greeter
sudo cp ~/Projects/dotfiles/themes/greeter/catppuccin-mocha-greeter.toml /var/lib/noctalia-greeter/greeter.toml
```

Log out to see the greeter change.
