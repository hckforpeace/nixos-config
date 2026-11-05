# Core system settings and the CLI tools expected on every machine.

{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  # Provides a runtime linker + common libraries so unpatched upstream
  # binaries (downloaded tarballs, language-specific installers) can run.
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    lazygit
    gh
    gcc
    tree
    tmux
    btop
    ripgrep
  ];
}
