# VirtualBox host. Opt in on machines that need to run VMs.
#
# Installing the `virtualbox` package is not enough on NixOS: the package gives
# you VBoxManage and the GUI, but the hypervisor itself lives in a kernel
# module, and only this option builds and loads it. Without it, starting a VM
# fails with "Kernel driver not installed (rc=-1908)".
#
# vboxdrv is loaded at boot, so a reboot is needed after enabling this.
#
# vboxdrv also cannot share AMD-V with KVM: on recent kernels KVM claims SVM
# root mode as soon as kvm-amd loads, and hardware-configuration.nix loads it
# at boot, so a VM would fail with VERR_SVM_IN_USE / "cannot operate in SVM
# root mode". enable_virt_at_load=0 below defers that claim until a KVM guest
# actually starts, which leaves AMD-V free for VirtualBox.
#
# The alternative is to drop the out-of-tree module for the KVM backend:
#
#     virtualisation.virtualbox.host.enableKvm = true;
#     virtualisation.virtualbox.host.addNetworkInterface = false;  # required with it
#
# That one needs no kernel module and so no reboot, but it is upstream-flagged
# as experimental and only does NAT networking.

{ ... }:

{
  virtualisation.virtualbox.host.enable = true;

  # Keep AMD-V available to vboxdrv; see the note above.
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  # Needed for USB passthrough and the host-only network interfaces.
  users.extraGroups.vboxusers.members = [ "pierre" ];
}
