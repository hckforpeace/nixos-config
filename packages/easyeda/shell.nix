# Standalone entry point, so the package can be tried without a rebuild:
#     nix-shell packages/easyeda/shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [ (import ./default.nix { inherit pkgs; }) ];
}
