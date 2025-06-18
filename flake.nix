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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs =
    {
      self,
      disko,
      firefox-addons,
      nixpkgs,
      home-manager,
      nix-flatpak,
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
          modules = [
            ./hosts/laptop
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            host = "laptop";
            inherit self inputs username firefox-addons;
          };
        };
      };
    };
}
