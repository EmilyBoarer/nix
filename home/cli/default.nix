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
    #neovim: added and managed below
    wget
    htop
    btop
    neofetch
    git
    tree
    mosh
  ];

  # Configure Tools: (no .config files etc..)
  # inputs.nixvim.homeModules.nixvim = TODO;
  # programs.nixvim = {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # extraPlugins = with pkgs.vimPlugins; [
    #   # TODO ??
    # ];
    extraConfig = ''
      luafile ${./nvim/init.lua}
    '';
    # plugins.dashboard-nvim.enable = true;
  };

  xdg.configFile."nvim/lua/core/mappings.lua".source = nvim/lua/core/mappings.lua;

  programs.zsh = {
    enable = true;
    history.size = 10000000;
    shellAliases = {
      amend = "git commit --amend";
      lg = "git log --oneline -n 15";
      l = "ls -l";
      la = "ls -al";
      al = "ls -al";
      grepr = "grep -r";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

}
