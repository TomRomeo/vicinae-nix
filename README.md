# Introduction
This is a nix flake for the [Vicinae launcher](https://github.com/vicinaehq/vicinae).
It exports a regular nix package but can also be integrated into a home-manager configuration.

## How to add
Simply add the repository to your home-manager flake.nix as an input and add it to the modules array. The flake will create a user systemd service and autostart it by default. These settings can be changed as described below.
```nix
{
    description = "...";
    inputs = {
        vicinae.url = "github:tomromeo/vicinae-nix";
        ...
    };
    outputs = {
        nixpkgs,
        home-manager,
        vicinae,
    }: let
    system = "...";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
        homeConfigurations."..." = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
                vicinae.homeManagerModules.default
                ...
            ];
        }
    }
}
```

## Home-manager options
```nix
{pkgs}:{
    services.vicinae = {
        enable = true; # default: true
        autoStart = true; #default: true
        package = # specify package to use here. Can be left omitted.
    };
}
```
