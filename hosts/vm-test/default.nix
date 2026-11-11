# Host: vm-test -- a throwaway VirtualBox VM.
#
# Its only job is to answer "do the portable modules work on a machine that is
# not this laptop?". It imports everything from ../../modules and nothing from
# hosts/nixos-pb, so a module that silently depends on this laptop's hardware,
# disks or LUKS setup shows up as a VM that will not build or will not boot.
#
# Not a machine to keep: build the appliance, boot it, look, delete it.

{ modulesPath, ... }:

{
  imports = [
    # Stands in for the hardware-configuration.nix + disks.nix pair that a real
    # host needs: MBR partition table, grub on /dev/sda, an auto-resizing ext4
    # root labelled "nixos", a swap file, and VirtualBox guest additions. It
    # also adds the system.build.virtualBoxOVA target that produces the .ova.
    "${modulesPath}/virtualisation/virtualbox-image.nix"

    # The modules under test -- same list as hosts/nixos-pb.
    ../../modules/base.nix
    ../../modules/networking.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
  ];

  networking.hostName = "vm-test";

  # There is no console session to run `passwd` from on a fresh appliance, so
  # bake in a throwaway password. Fine here, never do this on a real host.
  users.users.pierre.initialPassword = "test";
  users.users.root.initialPassword = "test";

  # Appliance geometry. The defaults are a 50 GiB disk and 1.5 GiB of RAM,
  # which is slow to build and too little to run a browser in.
  virtualisation.diskSize = 16 * 1024;
  virtualbox.baseImageFreeSpace = 2 * 1024;
  virtualbox.memorySize = 4096;
  virtualbox.params.cpus = 4;

  # The default name embeds the nixpkgs revision, which makes every VBoxManage
  # command a copy-paste job and leaves a new stale VM behind on every rebuild.
  virtualbox.vmName = "nixos-vm-test";

  system.stateVersion = "26.05";
}
