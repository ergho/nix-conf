{

  hardware.usbAudioInterfaces = [
    {
      vendorId = "1235";
      productId = "8211";
      deviceSetup = 1;
    }
  ];

  systemd.services.rebind-scarlett = {
    description = "Rebind Focusrite Scarlett (software replug) after boot";
    after = [
      "multi-user.target"
      "sound.target"
      "graphical.target"
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.ExecStart = "/bin/sh -c ' sleep 5; for i in 0 1 2; do echo 3-1:1.$i > /sys/bus/usb/drivers/snd-usb-audio/unbind || true; done; sleep 5; for i in 0 1 2; do echo 3-1:1.$i > /sys/bus/usb/drivers/snd-usb-audio/bind || true; done'";
  };

}
