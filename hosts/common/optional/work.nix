{ pkgs, ... }:

let
  makePwa =
    {
      name,
      desktopName,
      url,
      icon,
    }:
    let
      profileDir = "$HOME/.config/pwa-profiles/${name}";
      script = pkgs.writeShellScriptBin name ''
        mkdir -p "${profileDir}";
        exec ${pkgs.chromium}/bin/chromium \
          --app="${url}" \
          --user-data-dir="${profileDir}" \
          "$@"
      '';

      desktopItem = pkgs.makeDesktopItem {
        inherit name desktopName icon;
        exec = "${name} %U";
        categories = [
          "Network"
          "Office"
          "Chat"
        ];
        terminal = false;
      };
    in
    pkgs.symlinkJoin {
      inherit name;
      paths = [
        script
        desktopItem
      ];
    };

  teams = makePwa {
    name = "teams";
    desktopName = "Teams";
    url = "https://teams.cloud.microsoft/?clientType=pwa";
    icon = "";
  };
  outlook = makePwa {
    name = "outlook";
    desktopName = "Outlook";
    url = "https://outlook.cloud.microsoft/mail/";
    icon = "mail-client";
  };

in
{
  #services.udev.extraRules = ''
  #  ACTION=="add|remove", SUBSYSTEM=="usb", ATTR{idVendor}=="0424", ATTR{idProduct}=="4216", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="dock-sync.service"
  #'';
  environment.systemPackages = [
    pkgs.citrix_workspace
    pkgs.chromium
    teams
    outlook

  ];
}
