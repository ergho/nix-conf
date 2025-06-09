{
  description = "A very basic flake";

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
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    # Export variables
    desktop = "test later"; #todo fix later
    laptop = "laptop"; # just testing things for now
    username = "ergho";
    stateVersion = "25.05";
    system = "x86_64-linux";

  in
  {
  nixosConfigurations = {
    ${laptop} = nixpkgs.lib.nixosSystem {
      specialArgs = let
        hostname = "${laptop}";
      in {
        inherit
          hostname
          inputs
          self
          stateVersion
          system
          username
          ;
      };
      modules = [./nixos/${laptop}/configuration.nix];
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
