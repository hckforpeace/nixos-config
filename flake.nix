{
  description = "pierre's NixOS configuration";

  inputs = {
    # Pinned to the nixos-26.05 stable branch. flake.lock records the exact
    # commit, so a rebuild on new hardware reproduces these package versions.
    # `nix flake update` moves forward along 26.05; change the branch here to
    # jump to a newer NixOS release.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos-pb = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/nixos-pb ];
    };
  };
}
