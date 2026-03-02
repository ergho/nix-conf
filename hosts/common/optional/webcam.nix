{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    with gst_all_1;
    [
      gstreamer
      gst-plugins-base
      gst-plugins-good
    ];
  services.pipewire.wireplumber.extraConfig = {
    "v4l2-prefer-mjpeg" = {
      "monitor.v4l2.rules" = [
        {
          matches = [
            {
              "device.api" = "v4l2";
              "device.driver" = "v4l2loopback";
            }
          ];
          actions = {
            update-props = {
              "video.format" = "MJPG";
              "media.subtype" = "image";
            };
          };
        }
      ];
    };
  };

}
