{ inputs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = inputs.nixpkgs-stable.qemu_kvm;

      };
    };
    podman.enable = true;
  };

  programs = {
    virt-manager.enable = true;
  };
}
