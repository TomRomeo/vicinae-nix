{
  description = "A flake for Vicinae, a high-performance native launcher for Linux.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  nixConfig = {
    extra-substituters = ["https://tomromeo.cachix.org"];
    extra-trusted-public-keys = ["tomromeo.cachix.org-1:RNtotxybU2sStsoulE4np6THs0bTw2SBtKFfKogBah0="];
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        vicinae = pkgs.callPackage ./vicinae.nix {};
      in
      {
        packages.default = vicinae;
      }
    ) // {
      homeManagerModules.default = import ./module.nix {inherit pkgs; vicinae};
    };
}
