{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "start";
      qemu.ovmf.enable = true;
      qemu.runAsRoot = false;
    };
    podman.enable = true;
  };
  programs.virt-manager.enable = true;

  systemd.services.libvirt-ensure-default-net = {
    description = "Ensure libvirt default NAT network exists";
    after = [ "libvirtd.service" ];
    wants = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      if ! ${pkgs.libvirt}/bin/virsh net-info default >/dev/null 2>&1; then
        ${pkgs.libvirt}/bin/virsh net-define ${pkgs.writeText "default-net.xml" ''
          <network>
            <name>default</name>
            <forward mode='nat'/>
            <bridge name='virbr0' stp='on' delay='0'/>
            <ip address='192.168.122.1' netmask='255.255.255.0'>
              <dhcp>
                <range start='192.168.122.2' end='192.168.122.254'/>
              </dhcp>
            </ip>
          </network>
        ''}
      fi
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
      ${pkgs.libvirt}/bin/virsh net-start default || true
    '';
  };
}
