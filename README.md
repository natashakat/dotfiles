# Dotfiles

NixOS configuration managed declaratively with Nix Flakes and Home Manager.

## Quick Start

```bash
./rebuild.sh /home/helianthus/Documents/dotfiles
```

## Structure

- `flake.nix` - Nix Flake configuration with home-manager input
- `hosts/pratum/` - Host configuration for "pratum"
  - `configuration.nix` - Main NixOS configuration
  - `hardware-configuration.nix` - Hardware settings (ZFS, drives, microcode)
  - `modules/` - Modular NixOS and home-manager modules
    - `system.nix` - System settings (boot, networking, services)
    - `desktop.nix` - KDE Plasma desktop configuration
    - `user.nix` - User accounts and packages
    - `home.nix` - Home-manager configuration
    - `shell.nix` - Bash + oh-my-bash
    - `kde.nix` - KDE/Plasma configs (plasmarc, kwinrc, kdeglobals)
    - `gtk.nix` - GTK theme configuration
    - `apps.nix` - Application configurations (VLC, Kate, etc.)
- `vault/` - Obsidian vault

## Features

- **ZFS** - Encrypted pools (merry-g, vault) with auto-import, pool roots user-writable
- **NFS** - `mireo:/data` automounted at `/mnt/mireo-data`
- **run0** - sudo replacement with OpenASAR + Vencord Discord
- **Intel microcode** - CPU microcode updates
- **KDE Plasma** - WhiteSur-dark theme
- **Home Manager** - Declarative user configuration
- **ZFS encryption** - Boot-time key prompt via systemd-ask-password
- **Programs**: Steam, LibreOffice, Firefox, Git, VSCode, Obsidian, JetBrains IDEs, Rust/Node.js toolchain, dev tools

## Rebuild

```bash
./rebuild.sh /home/helianthus/Documents/dotfiles
# or
nixos-rebuild switch --flake .#pratum
```

## Modules

Each module in `hosts/pratum/modules/` is a self-contained NixOS/Home Manager module. Import them from `configuration.nix` or `home.nix` to compose the full config.
