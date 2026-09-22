{ config, pkgs, ... }:

{
  users.users."helianthus" = {
    isNormalUser = true;
    description = "helianthus maximus";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
      prismlauncher
      git
      keepassxc
      thunderbird
      vlc
      gimp
      rawtherapee
      abcde
      strawberry
      easyeffects
      quota
      ungoogled-chromium
      freetube
      xenia-canary
      motrix
      opencode
      nodejs
      pkgs.jetbrains.clion
      pkgs.jetbrains.idea
      pkgs.jetbrains.webstorm
      pkgs.jetbrains.phpstorm
      pkgs.jetbrains.pycharm
      pkgs.jetbrains.ruby-mine
      pkgs.jetbrains.goland
      pkgs.jetbrains.datagrip
      telegram-desktop
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      signal-desktop
      slack
      element-desktop
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
}
