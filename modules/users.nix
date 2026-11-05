# User accounts.
#
# Set a password after the first install with `passwd pierre`.

{ pkgs, ... }:

{
  users.users.pierre = {
    isNormalUser = true;

    # wheel -> sudo, video -> backlight via brightnessctl, input -> input devices
    extraGroups = [ "wheel" "video" "input" ];

    shell = pkgs.zsh;

    packages = with pkgs; [
      claude-code
    ];
  };
}
