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

  security.sudo.enable = true;
  security.sudo-rs.enable = false;

  programs.steam = {
    enable = true;
  };
  hardware.steam-hardware.enable = true;

  # 32-Bit-Mesa für Steam/Proton/ältere Wine-Spiele. AMD braucht sonst nichts.
  hardware.graphics.enable32Bit = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/helianthus/Documents/dotfiles";
  };

  systemd.services."zfs-sync-merrick-g".enable = false;
  systemd.services."zfs-sync-vault".enable = false;

  # NFS-Client: zieht nfs-utils (mount.nfs), rpcbind, idmapd rein.
  boot.supportedFilesystems.nfs = true;

  fileSystems."/mnt/mireo-data" = {
    device = "mireo:/data";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "nofail" "_netdev" "x-systemd.idle-timeout=600" ];
  };

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
      for d in /merrick-g /vault; do
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
      # Pools bei Bedarf importieren, vault Keys laden (Keys aus
      # Passwortmanager), /vault + Kinder mounten, Rechte fixen.
      # /merrick-g (unencrypted) mountet normal schon beim Boot via
      # zfs-mount.service (`zfs mount -a`). vault bleibt bis hier
      # gesperrt (kein Boot-Prompt). Safe re-run. Im Terminal (Konsole)
      # laufen lassen.
      set -euo pipefail

      if [[ $EUID -ne 0 ]]; then
        exec sudo "$0" "$@"
      fi

      # Pools importieren falls noetig (extraPools importiert beim Boot,
      # aber hier robust fuer manuellen Lauf).
      if ! zpool list -H -o name merrick-g >/dev/null 2>&1; then
        echo "importing ZFS pool merrick-g..."
        zpool import -d /dev/disk/by-id -N merrick-g
      fi

      if ! zpool list -H -o name vault >/dev/null 2>&1; then
        echo "importing ZFS pool vault..."
        zpool import -d /dev/disk/by-id -N vault
      fi

      # Unencrypted zuerst mounten. vault folgt nach Key-Load.
      zfs mount -a || true

      # Keys laden fuer gesperrte Datasets mit keylocation=prompt.
      # Von /dev/tty lesen, da stdin die Dataset-Liste aus der Pipe traegt.
      echo "loading vault keys (paste from password manager)..."
      zfs list -rHo name,keylocation,keystatus -t filesystem,volume vault | while IFS=$'\t' read -r ds kl ks; do
        if [[ "$kl" == "prompt" && "$ks" == "unavailable" ]]; then
          echo "loading key for $ds..."
          zfs load-key "$ds" < /dev/tty
        fi
      done

      # Root via Unit mounten (noauto), Kinder nativ (Keys jetzt geladen).
      systemctl start vault.mount
      zfs mount -a || true
      systemctl restart zfs-user-permissions

      echo "---"
      mountpoint -q /merrick-g && echo "/merrick-g mounted" || echo "/merrick-g NOT mounted"
      mountpoint -q /vault && echo "/vault mounted" || echo "/vault NOT mounted"
      zfs list -rHo name,keystatus,mounted vault
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
    vesktop
    signal-desktop
    lazydocker
    direnv
    helix
    neovim
    eza
    bat
    fd
    fzf
    jq
    vivid
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
    # Toolchains für JetBrains IDEs (ohne dev-shell nutzbar)
    gcc
    gnumake
    gdb
    go
    jdk
    maven
    gradle
    ruby
    bundler
    php
    phpPackages.composer
    uv
    nil
    nix-index
    comma
    nixfmt
    jetbrains-mono
    # Catppuccin Mocha Mauve desktop theme (matches Plasma/GTK config in home.nix)
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
    })
    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    })
    (catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
    papirus-icon-theme
    catppuccin-cursors.mochaMauve
    catppuccin-sddm
    wl-clipboard
    typescript
    prettier
    eslint
    pnpm
    # MCP servers for opencode (via nix, no npx/uvx)
    mcp-nixos
    mcp-server-filesystem
    mcp-server-git
    mcp-server-fetch
    mcp-server-memory
    mcp-server-time
    mcp-server-sequential-thinking
    context7-mcp
    github-mcp-server
    playwright-mcp
    firefox-devtools-mcp
    thunderbird-mcp
    markitdown-mcp
    mcp-language-server
    mcp-searxng
    open-websearch
  ];
}
