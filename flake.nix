{
  description = "Beginner NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    # Export variables
    username = "ergho";
    stateVersion = "25.05";
    system = "x86_64-linux";

  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/laptop ];
        specialArgs =  {
          host = "laptop";
          inherit self inputs username;
        };
      };
      # myNixos = nixpkgs.lib.nixosSystem {
      #   specialArgs = { inherit inputs system; };
      #   modules = [
      #   ./nixos/configuration.nix
      #   ];
      # };
    };
  };
}
