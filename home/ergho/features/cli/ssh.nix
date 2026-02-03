{
  pkgs,
  lib,
  config,
  ...
}:
{
  #programs.ssh = {
  #  enable = true;
  #};
  systemd.user.services = {
    waypipe-server = {
      Unit.Description = "Runs waypipe on startup to support SSH forwarding";
      Service = {
        Type = "simple";
        ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} %h/.waypipe -p";
        ExecStart = "${lib.getExe (config.lib.nixGL.wrap pkgs.waypipe)} --socket %h/.waypipe/server.sock --title-prefix '[%H] ' --login-shell --display wayland-waypipe server -- ${lib.getExe' pkgs.coreutils "sleep"} infinity";
        ExecStopPost = "${lib.getExe' pkgs.coreutils "rm"} -f %h/.waypipe/server.sock %t/wayland-waypipe";
      };
      Install.WantedBy = [ "default.target" ];

    };
  };
}
