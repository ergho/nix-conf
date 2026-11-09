{
  lib,
  ...
}:

let
  certDir = ../../../certs;
  dirContents = builtins.readDir certDir;
  certFiles = map (name: certDir + "/${name}") (
    lib.filter (
      name: (lib.hasSuffix ".crt" name || lib.hasSuffix ".pem" name) && dirContents.${name} == "regular"
    ) (builtins.attrNames dirContents)
  );

in
{

  security.pki.certificateFiles = certFiles;
}
