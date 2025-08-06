{ pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs-stable; [ citrix_workspace ];
}
