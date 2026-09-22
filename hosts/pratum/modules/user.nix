{ config, pkgs, ... }:

{
  users.users."helianthus" = {
    isNormalUser = true;
    description = "helianthus maximus";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
      prismlauncher
      vscodium-fhs
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
      jetbrains-clion
      jetbrains-idea
      jetbrains-webstorm
      jetbrains-phpstorm
      jetbrains-pycharm
      jetbrains-rubymine
      jetbrains-goland
      jetbrains-rustrover
      jetbrains-datagrip
      jetbrains-database-client
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
