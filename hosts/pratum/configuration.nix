{ config, pkgs, ... }:

{
  imports =
    [
      ./modules/system.nix
      ./modules/desktop.nix
      ./modules/user.nix
    ];

  home-manager.users."helianthus" = import ./modules/home.nix;
}
