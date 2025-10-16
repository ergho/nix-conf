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
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      disko,
      nixpkgs,
      home-manager,
      nixpkgs-stable,
      nix-flatpak,
      nvf,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {

        inherit system;
        config.allowUnfree = true;
      };
      username = "ergho";
      system = "x86_64-linux";

    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      overlays = import ./overlays { inherit inputs lib outputs; };
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop
            self.nixosModules.usb-audio
            inputs.disko.nixosModules.disko
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            host = "desktop";
            inherit
              self
              inputs
              outputs
              pkgs-stable
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
              pkgs-stable
              username
              ;
          };
        };
      };
      packages."x86_64-linux" = {
        intel-graphics-compiler = pkgs.intel-graphics-compiler;
        neovim-config =
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs-stable.legacyPackages."x86_64-linux";
            modules = [ ./pkgs/neovim.nix ];
          }).neovim;
      };
    };
}
