{ config, pkgs, ... }:

{
  imports =
    [
      ./modules/system.nix
      ./modules/desktop.nix
      ./modules/user.nix
    ];

  # Move aside pre-existing dotfiles (created by KDE/plasma on first login)
  # so Home Manager can link its declarative versions on first activation.
  home-manager.backupFileExtension = "backup";
  home-manager.users."helianthus" = import ./modules/home.nix;
}
