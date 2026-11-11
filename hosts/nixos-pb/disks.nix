# Boot loader and disk encryption.
#
# MACHINE-SPECIFIC: the UUID below belongs to this laptop's LUKS container and
# is wrong on any other machine. On a new install, find the right one with:
#
#     lsblk -f          # or: blkid /dev/nvme0n1p2
#
# The partition layout assumed here is: ESP on /boot, and a LUKS container
# named "cryptlvm" holding an LVM volume group vg0 with root/home/swap.
# The volumes themselves are declared in hardware-configuration.nix.

{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 20;

  boot.initrd.luks.devices."cryptlvm" = {
    device = "/dev/disk/by-uuid/16c1cdf1-619e-412e-9786-97259c795992";
    allowDiscards = true;
  };
}
