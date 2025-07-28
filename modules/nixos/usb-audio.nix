{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware.usbAudioInterfaces;
in
{
  options.hardware.usbAudioInterfaces = mkOption {
    type =
      with types;
      listOf (submodule {
        options = {
          vendorId = mkOption {
            type = types.str;
            description = "USB vendor ID (hex, e.g., '1234')";
          };
          productId = mkOption {
            type = types.str;
            description = "USB product ID (hex, e.g., 'abcd')";
          };
          deviceSetup = mkOption {
            type = types.int;
            default = 0;
            description = "Value for snd-usb-audio's device_setup parameter.";
          };
        };

      });
    default = [ ];
    description = "List of USB audio interfaces with quirks to configure.";
  };
  config = {

    boot.extraModprobeConfig = lib.concatMapStringsSep "\n" (
      dev:
      "options snd_usb_audio vid=0x${dev.vendorId} pid=0x${dev.productId} device_setup=${toString dev.deviceSetup}"
    ) cfg;
  };
}
