# Large or situational desktop applications. Not imported by default, so a
# fresh install is not blocked on a texlive download.

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    discord
    texliveMedium

    # Locally packaged: EasyEDA standalone client, FHS-wrapped.
    (import ../../packages/easyeda { inherit pkgs; })
  ];
}
