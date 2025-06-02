# Config to be used by all systems: the CLI setup
# Basically, all the terminal tools & their configs

# home-manager CLI config:
{ config, pkgs, lib, ... }:{
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  
  programs.nixvim = import ./nixvim.nix { inherit pkgs lib; };

  home.packages = with pkgs; [
    # Terminal Tools:
    zsh
    nano
    wget
    htop
    btop
    neofetch
    git
    tree
    mosh
    tmux
    bat
  ];

  # Configure Tools: (no .config files etc..)
  programs.zsh = {
    enable = true;
    history.size = 10000000;
    shellAliases = {
      amend = "git commit --amend";
      lg = "git log --oneline -n 15 | cat";
      gl = "lg";
      l = "ls -l";
      la = "ls -al";
      al = "la";
      grepr = "grep -r";
      gg = "git grep";
      #cat = "bat";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

}
