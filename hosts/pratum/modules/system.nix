{ config, pkgs, ... }:

{
  imports = [ ../hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    theme = pkgs.catppuccin-grub;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "pratum";
  networking.hostId = "685d54a9";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "26.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
  };

  security.sudo.enable = false;
  security.sudo-rs.enable = false;

  programs.steam = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/helianthus/Documents/dotfiles";
  };

  systemd.services."zfs-sync-merrick-g".enable = false;
  systemd.services."zfs-sync-vault".enable = false;

  systemd.mounts = [
    {
      where = "/mnt/mireo-data";
      what = "mireo:/data";
      type = "nfs";
      options = "noauto,nofail,_netdev";
    }
  ];

  systemd.automounts = [
    {
      where = "/mnt/mireo-data";
      wantedBy = [ "remote-fs.target" ];
      automountConfig = {
        TimeoutIdleSec = 600;
        DirectoryMode = "0755";
      };
    }
  ];

  systemd.tmpfiles.rules = [
    "d /mnt/mireo-data 0755 root root -"
  ];

  systemd.services.zfs-user-permissions = {
    description = "Make ZFS pool roots user writable";
    wantedBy = [ "multi-user.target" ];
    after = [ "zfs-import.target" "zfs.target" ];
    wants = [ "zfs-import.target" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
    path = [ pkgs.util-linux ];
    script = ''
      for d in /tank /vault; do
        for i in $(seq 1 30); do
          mountpoint -q "$d" && break
          sleep 1
        done
        if mountpoint -q "$d"; then
          chown helianthus:users "$d"
          chmod 0775 "$d"
        fi
      done
    '';
  };

  environment.systemPackages = with pkgs; [
    nodejs
    zfs
    (writeShellScriptBin "zfs-unlock" ''
      # Unlock the encrypted vault pool (key pasted from the password
      # manager), mount /vault, fix pool-root ownership.
      # merrick-g (/tank, unencrypted, holds the KeePass database) is
      # already mounted at boot. Safe to re-run. Run in a terminal (Konsole).
      set -euo pipefail

      if [[ $EUID -ne 0 ]]; then
        exec sudo "$0" "$@"
      fi

      # The pool is normally already imported at boot (boot.zfs.extraPools),
      # but import it on demand if needed.
      if ! zpool list -H -o name vault >/dev/null 2>&1; then
        echo "importing ZFS pool vault..."
        zpool import -d /dev/disk/by-id -N vault
      fi

      # Load keys for locked datasets with keylocation=prompt.
      # Redirect from /dev/tty so the passphrase is read from the terminal
      # (stdin carries the dataset list from the pipe).
      zfs list -rHo name,keylocation,keystatus -t volume,filesystem vault | while IFS=$'\t' read -r ds kl ks; do
        if [[ "$kl" == "prompt" && "$ks" == "unavailable" ]]; then
          echo "loading key for $ds (paste from password manager)..."
          zfs load-key "$ds" < /dev/tty
        fi
      done

      systemctl start vault.mount
      systemctl restart zfs-user-permissions

      echo "---"
      mountpoint -q /tank && echo "/tank mounted" || echo "/tank NOT mounted"
      mountpoint -q /vault && echo "/vault mounted" || echo "/vault NOT mounted"
    '')
    vulkan-loader
    mesa
    SDL2
    gtk3
    alsa-lib
    libuuid
    lz4
    pkg-config
    ninja
    cmake
    python3
    libreoffice
    obsidian
    openscad
    freecad
    telegram-desktop
    discord
    signal-desktop
    lazydocker
    direnv
    helix
    neovim
    eza
    bat
    fd
    fzf
    zoxide
    zellij
    tmux
    btop
    fastfetch
    atuin
    starship
    ripgrep
    git
    lazygit
    gh
    rustc
    cargo
    rust-analyzer
    nil
    nix-index
    nixfmt
    jetbrains-mono
    # WhiteSur desktop theme (matches the KDE config in home.nix)
    whitesur-kde
    whitesur-icon-theme
    whitesur-gtk-theme
    whitesur-cursors
    catppuccin-sddm
    wl-clipboard
    typescript
    prettier
    eslint
    pnpm
  ];
}
