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
        pkgs = builtins.abort "This flake is deprecated. Please use the one provided by the official package. You can find migration instructions in this repository.";
        vicinaePkg = pkgs.callPackage ./vicinae.nix {};
      in
      {
        packages.default = vicinaePkg;
      }
    ) // {
      homeManagerModules.default = {config,pkgs,lib,...}: import ./module.nix {inherit config pkgs lib self;};
    };
}
