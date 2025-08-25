{
  description = "A flake for Vicinae, a high-performance native launcher for Linux.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.callPackage ./vicinae.nix {};
      }
    ) // {
      homeManagerModules.default = import ./module.nix;
    };
}
