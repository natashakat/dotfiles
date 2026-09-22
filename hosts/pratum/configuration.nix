{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./modules/system.nix
      ./modules/desktop.nix
      ./modules/user.nix
    ];

  home-manager.users."helianthus" = import ./modules/home.nix;
}