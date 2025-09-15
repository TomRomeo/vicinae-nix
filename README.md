> [!WARNING]
> This repository is deprecated as the flake has been merged upstream. Please use the official flake in the [vicinae](https://github.com/vicinaehq/vicinae) repository.
> Take a look at the [migration](#migration) section to see if properties have to be adapted.

# Migration
1. adapt the flake input url for vicinae to `github:vicinaehq/vicinae`
2. The `enable` property for the vicinae module is now deactivated by default. Set `services.vicinae.enable = true` to have vicinae enabled.
All other properties stayed the same.


---

> [!WARNING]
> As described above, this repository is deprecated, therefore the remainder of the README might not be up-to-date.

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
