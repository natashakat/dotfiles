{ config, pkgs, ... }:

{
  imports = [ ../hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
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

  fileSystems."/mnt/mireo-data" = {
    device = "mireo:/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "_netdev"
      "nofail"
    ];
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
    lazygit
    gh
    gitui
    rustc
    cargo
    rust-analyzer
    nil
    nix-index
    nixfmt
    jetbrains-mono
    wl-clipboard
    typescript
    prettier
    eslint
    pnpm
  ];
}
