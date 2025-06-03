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
    bat
    #mosh # >=1.4 required for truecolor
    # TODO fix SSH!!! etc.. overlay nixpkgs
    (mosh.overrideAttrs(old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ makeWrapper ];
      # Work around "No user exists for uid <numbers>" by prepending sssd to
      # LD_LIBRARY_PATH This is a hack because it hijacks the
      # "postFixup", that incidentally is not set for mosh, but it could be in the future
      postPatch = ''
        substituteInPlace scripts/mosh.pl \
          --subst-var-by ssh "/usr/bin/ssh" \
          --subst-var-by mosh-client "$out/bin/mosh-client"
      '';
#        wrapProgram $out/bin/mosh --prefix LD_LIBRARY_PATH : "${sssd}/lib"
    }))
    tmux
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
    # TODO standardise this, guard this? and otherwise sort out this problem!
    envExtra = ". /home/emiboa01/.nix-profile/etc/profile.d/nix.sh; export LANG=\"en_GB.UTF-8\"; ";
  };
}
