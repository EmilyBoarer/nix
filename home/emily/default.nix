# Config for `emily` user, assuming GUI

{ config, pkgs, ... }:{
  imports = [
    ../gui
    ./git.nix
  ];
}
