# Config for Window Manager & GUI things

{ config, pkgs, ... }:{
  imports = [
    ../cli # Include CLI config too, this is an additional extension to that
    ./waybar # Waybar Config
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
  };

}
