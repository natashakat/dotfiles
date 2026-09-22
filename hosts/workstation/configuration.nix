{ config, pkgs, ... }:

{
  imports =
    [
      ./modules/system.nix
      ./modules/desktop.nix
      ./modules/user.nix
      ./modules/home.nix
    ];
}
