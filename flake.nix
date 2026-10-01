{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, nix-flatpak, ... }: {
    nixosConfigurations.pratum = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/pratum/configuration.nix
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        { home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ]; }
      ];
    };
  };
}
