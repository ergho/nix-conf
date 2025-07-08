{
  description = "Beginner NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    hardware.url = "github:nixos/nixos-hardware";
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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      disko,
      firefox-addons,
      nixpkgs,
      home-manager,
      nix-flatpak,
      nvf,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      username = "ergho";
      system = "x86_64-linux";

    in
    {
      overlays = import ./overlays { inherit inputs outputs; };
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop
            inputs.disko.nixosModules.disko
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            host = "desktop";
            inherit
              self
              inputs
              outputs
              username
              ;
          };
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            host = "laptop";
            inherit
              self
              inputs
              outputs
              username
              ;
          };
        };
      };
      packages."x86_64-linux".neovim-config =
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./pkgs/neovim.nix ];
        }).neovim;
    };
}
