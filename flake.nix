{
  description = "Beginner NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      disko,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      username = "ergho";
      #stateVersion = "25.05";
      system = "x86_64-linux";

    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop
            inputs.disko.nixosModules.disko
          ];
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/laptop ];
          specialArgs = {
            host = "laptop";
            inherit self inputs username;
          };
        };
      };
    };
}
