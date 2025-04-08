# Config to be used by all systems
# Basically, terminal tools
# NB: this file is called during home-manager config, not during system config

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
    syntaxHighlighting.enable = true;
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

  programs.git = {
    enable = true;
    # TODO config
  };

  ## TEMPORARY: TODO move this to another place, since this is waybar specific!
  programs.waybar = {                                  
      enable = true;                                                 
      # style = TODO?                                                
      settings = [{                                                  
        layer = "top";                                               
        position = "top";                                            
        mod = "dock";                                                
        exclusive = true;                                            
        passthrough = false;                                         
        gtk-layer-shell = true;                                      
        height = 0;                                                  
        modules-left = [                                             
          "hyprland/workspaces"                                      
        ];                                                           
        modules-center = [                                           
          "hyprland/window"                                          
        ];                                                           
        modules-right = [                                            
          "tray"                                                     
          "network"                                                  
          "clock"                                                    
        ];                                                           
        "hyprland/window" = { format = "{}"; };                      
        "wlr/workspaces" = {                                         
          on-scroll-up = "hyprctl dispatch workspace e+1";           
          on-scroll-down = "hyprctl dispatch workspace e-1";         
          all-outputs = true;                                        
          on-click = "activate";                                     
        };                                                           
        tray = {                                                     
          icon-size = 13;                                            
          tooltip = false;                                           
          spacing = 10;                                              
        };                                                           
        clock = {                                                    
          format = " {:%I:%M %p   %m/%d} ";                        
          tooltip-format = ''                                        
            <big>{:%Y %B}</big>                                      
            <tt><small>{calendar}</small></tt>'';                    
        };                                                           
      }];                                                            
    };
}
