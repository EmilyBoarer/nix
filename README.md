# Emily's systems' config

## Installation

TODO!

## Filestructure / Repo Overview

#### `flake.nix`
Toplevel config.

#### `locale.nix`
Global locale, timezone, font, etc.. config:
The most general configs that don't change between any hosts.

#### `home/`
Nix files managed by home-manager

#### `home/cli`
Config for terminal tools etc..
This config is expected to be used on all hosts.

#### `home/gui`
Config for window manager and other graphical tools.
This config is expected to be used on all graphical NixOS hosts.
This config `imports` the `home/cli` config.

#### `home/emily/git.nix`
This config sets up Git for personal use.

#### `home/emily`
`emily` user config, intended to be used on personal & graphical NixOS hosts.
This config `imports` the `home/gui` and `home/emily/git.nix` configs.

#### `home/emily_headless`
TODO: implement when the need arises.
Config for the `emily` user when on a personal & headless host.
This config WILL `imports` the `home/cli` and `home/emily/git.nix` configs.

#### `home/emiboa01/git.nix`
This config sets up Git for work use.

#### `home/emiboa01`
TODO: implement
`emiboa01` user config, intended to be used for work hosts.
This config WILL `imports` the `home/cli` and `home/emiboa01/git.nix` configs

#### `hosts`
Nix files managed by NixOS

#### `hosts/nixos`
General config for all NixOS systems,

#### `hosts/Orchid`
Config specific to Orchid.
This config `imports` from `hosts/nixos`.

# long-term TODOs:
- manage SSH and other keys
