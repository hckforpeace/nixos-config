# Networking, VPN and bluetooth.

{ ... }:

{
  # Connections are managed interactively -- nmtui / nmcli / networkmanager_dmenu.
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  services.tailscale.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
