{
  inputs,
}:

{
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
        packages = (flake.packages or { }).${final.system} or { };
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };
  #cmake-compat =
  #  final: prev:
  #  let
  #    brokenPkgs = {
  #      #inherit (prev) intel-graphics-compiler;
  #    };
  #  in
  #  lib.mapAttrs (
  #    _: pkg:
  #    pkg.overrideAttrs (old: {
  #      cmakeFlags = (old.cmakeFlags or [ ]) ++ [
  #        "-DCMAKE_POLICY_VERSION_MINIMUM=3.10"
  #      ];
  #    })
  #  ) brokenPkgs;

  citrix-fix =
    final: _:
    let
      # Import the pinned nixpkgs snapshot
      compatPkgs =
        import
          (builtins.fetchTarball {
            url = "https://github.com/NixOS/nixpkgs/archive/29b6e7097f50955f49a81d2665fb21c94c43df19.tar.gz";
            sha256 = "0zrkfxj130gbgixgk8yaxk5d9s5ppj667x38n4vys4zxw5r60bjz";
          })
          {
            inherit (final) system;
            config = {
              allowUnfree = true;
              allowInsecure = true;
              permittedInsecurePackages = [
                "libsoup-2.74.3"
              ];
            };
          };
    in
    {
      # Override citrix-workspace with the one from compatPkgs
      inherit (compatPkgs) citrix_workspace;
    };
}
