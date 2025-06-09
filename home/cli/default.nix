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
    ripgrep
  ];

  # Configure Tools:
  programs.zsh = {
    enable = true;
    history.size = 10000000;
    shellAliases = {
      amend = "git commit --amend";
      lg = "git log --oneline -n 15 --color=always | cat";
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

  # Set Locale: TODO this still needs to be set manually - why?
  home.sessionVariables = {
      LANG           = "en_GB.UTF-8";
      LOCALE_ARHCIVE = "/usr/lib/locale/locale-archive";
  };

}
