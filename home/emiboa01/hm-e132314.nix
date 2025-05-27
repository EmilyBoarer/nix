{ config, pkgs, username, homedir, ... }:{
  imports = [
    ../cli
    ./git.nix
    ./work-only-tools.nix
  ];

  # TODO relocate these up the call chain:
  home.username = username;
  home.homeDirectory = homedir;

}
