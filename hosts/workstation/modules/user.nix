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
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
}
