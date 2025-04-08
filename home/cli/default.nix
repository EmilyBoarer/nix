# Config to be used by all systems: the CLI setup
# Basically, all the terminal tools & their configs

# home-manager CLI config:
{ config, pkgs, ... }:{
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Terminal Tools:
    zsh
    nano
    neovim
    wget
    htop
    btop
    neofetch
    git
    tree
    mosh
  ];

  # Configure Tools: (no .config files etc..)
  # TODO configure neovim here
  programs.zsh = {
    enable = true;
    history.size = 10000000;
    shellAliases = {
      amend = "git commit --amend";
      l = "ls -l";
      la = "ls -al";
      grepr = "grep -r";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

}
