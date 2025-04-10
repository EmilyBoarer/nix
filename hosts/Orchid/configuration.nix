# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../nixos # Include general NixOS config
    ];

  # This needs to be enabled here (despite it being enabled by home-manager) since it should be system-wide. we just use home-manager to customise our user's zsh
  programs.zsh.enable = true;

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub = {
    minegrub-world-sel = {
      enable = true;
      customIcons = [{
        name = "nixos";
        lineTop = "Orchid - NixOS";
        lineBottom = "Spectator Mode, Cheats";
        customImg = builtins.path {
          path = ./nixos-logo.png;
          name = "nixos-img";
        };
      }];
    };
  };



  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spotify
    google-chrome
    gimp
    rawtherapee

    waybar
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    dunst
    libnotify
    kitty
    swww # wallpapers
    rofi-wayland # TODO what is this one too?

    steam
    nvtop
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.xone.enable = true; # support for the xbox controller USB dongle

  # Configure Hardware settings to actually give decent performance when playing games.
  # TODO move this config into hardware-configuration.nix?
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true; # Fixes tearing
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vaapiIntel
    vaapiVdpau
    vulkan-tools
    vulkan-validation-layers
  ];


  # hardware.opengl.driSupport = true; # No longer has any effect
  hardware.pulseaudio.support32Bit = true;
  boot.kernelParams = ["nvidia_drm.modeset=1"];

}
