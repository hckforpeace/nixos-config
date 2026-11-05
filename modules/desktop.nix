# Graphical session: X11 + i3, lightdm, and the desktop utilities that go with
# that setup.
#
# Note on audio: services.xserver.enable pulls in pipewire via nixpkgs'
# graphical-desktop.nix, so it is not declared here. pavucontrol and the
# pulseaudio package (for pactl) are the control tools for it.

{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
  };

  services.displayManager.defaultSession = "none+i3";

  # brightnessctl ships udev rules that let members of the "video" group write
  # to the backlight without root. Without these the i3 brightness binds fail.
  services.udev.packages = [ pkgs.brightnessctl ];

  services.clipmenu.enable = true;

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    # i3 environment
    brightnessctl
    rofi
    picom
    nitrogen
    xclip
    autorandr
    terminator
    networkmanager_dmenu
    xwinwrap

    # Audio control
    pavucontrol
    pulseaudio

    # File manager / media
    kdePackages.dolphin
    imv
    mpv
  ];
}
