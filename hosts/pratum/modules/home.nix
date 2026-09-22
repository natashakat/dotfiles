{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./kde.nix
    ./gtk.nix
    ./apps.nix
  ];

  home.username = "helianthus";
  home.homeDirectory = "/home/helianthus";
  home.stateVersion = "26.05";

  programs.obsidian.enable = true;
  programs.obsidian.defaultApp = "vscodium-fhs";

  programs.git.enable = true;
  programs.git.userName = "helianthus";
  programs.git.userEmail = "helianthus@pratum";

  programs.vscode.enable = true;
  programs.bash.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "\${HOME}/Desktop";
    download = "\${HOME}/Downloads";
    templates = "\${HOME}/Templates";
    publicShare = "\${HOME}/Public";
    documents = "\${HOME}/Documents";
    music = "\${HOME}/Music";
    pictures = "\${HOME}/Pictures";
    videos = "\${HOME}/Videos";
  };

  home.packages = with pkgs; [
    obsidian
  ];
}
