# Host: nixos-pb -- ASUS TUF A15, AMD Ryzen + Radeon 680M (+ an unused RTX 3070 Ti).
#
# Everything in this directory is specific to THIS machine. Everything in
# ../../modules is portable and should work unchanged on any new host.

{ ... }:

{
  imports = [
    # Machine-specific
    ./hardware-configuration.nix
    ./disks.nix
    ./quirks.nix

    # Portable
    ../../modules/base.nix
    ../../modules/networking.nix
    ../../modules/desktop.nix
    ../../modules/users.nix

    # Optional -- not needed for a working first install. Uncomment as wanted.
    # ../../modules/optional/ollama.nix
    # ../../modules/optional/apps.nix
  ];

  networking.hostName = "nixos-pb";

  # The NixOS version this machine was FIRST installed with. Do not bump it on
  # an existing machine. A brand-new install should use that install's version.
  system.stateVersion = "26.05";
}
