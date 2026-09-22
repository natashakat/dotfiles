{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos/modules/home-manager.nix>
  ];

  home-manager.useUserModules = true;
  home-manager.users."helianthus" = { config, pkgs, ... }: {
    home.username = "helianthus";
    home.homeDirectory = "/home/helianthus";
    home.stateVersion = "26.05";

    programs.obsidian.enable = true;
    programs.obsidian.defaultApp = "vscodium-fhs";

    programs.git.enable = true;
    programs.git.userName = "helianthus";
    programs.git.userEmail = "helianthus@pratum";

    programs.vscode.enable = true;

    home.packages = with pkgs; [
      obsidian
    ];
  };
}
