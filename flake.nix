{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.pratum = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/pratum/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
