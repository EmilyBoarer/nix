# flake.nix
{
  description = "Flake for Emily's systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    
    minegrub-world-sel-theme.inputs.nixpkgs.follows = "nixpkgs";  
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, minegrub-world-sel-theme, home-manager, ... }:
    let
      defineNixosSystem = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          minegrub-world-sel-theme.nixosModules.default
	  ./locale.nix
	  ./hosts/nixos
	  ({ config, pkgs, lib, ... }: {
   	    networking.hostName = lib.mkDefault hostname;
	    networking.networkmanager.enable = true;

            users.users.emily = {
	      # Set password with `passwd`
	      isNormalUser = true;
	      description = "Emily";
	      extraGroups = [ "networkmanager" "wheel" ];
	      shell = pkgs.zsh;
	      packages = with pkgs; [
                home-manager
              ];
	    };

            nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
            nix.settings.trusted-users = [ "root" "emily" ];
	    system.stateVersion = "24.05";
	  })
	  home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.emily = ./home;
	    home-manager.backupFileExtension = "backup";
          }
        ];
      };
    in {
      nixosConfigurations.Orchid = defineNixosSystem "Orchid";
  };
}
