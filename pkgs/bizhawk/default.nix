{
  stdenv,
  #fetchFromGitHub,
  fetchurl,
}:
stdenv.mkDerivation {
  pname = "bizhawk";
  version = "2.10";
  #src = fetchFromGitHub {
  #  owner = "TASEmulators";
  #  repo = "BizHawk";
  #  rev = "dd232820493c05296c304b64bf09c57ff1e4812f";
  #  sha256 = "sha256:cdaf9650d880bae660d63a388430f630b8d8a96b1ba59ebf0e0195a645c3bab8";
  #};
  src = fetchurl {
    url = "https://github.com/TASEmulators/BizHawk/releases/download/2.10/BizHawk-2.10-linux-x64.tar.gz";
    sha265 = "";
  };

  dontBuild = true;
  dontConfigure = true;
  dontInstall = true;
  unpackPhase = ''
    mkdir -p $out
    tar -xzf $src -C $out
  '';

  #installPhase = ''
  #  install -Dm 0755
  #'';

}
