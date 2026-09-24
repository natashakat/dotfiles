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
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }: {
    nixosConfigurations.pratum = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/pratum/configuration.nix
        home-manager.nixosModules.home-manager
        { home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ]; }
      ];
    };
  };
}
