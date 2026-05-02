# This is a shared system configuration for all hosts.
# Things here are not intended to be (swapped out)/toggled.
# For swappable configs (compositors, display manager...) use a module instead.
{
  pkgs,
  username,
  lib,
  ...
}:
{
  imports = [
    ## Display-Manager:
    # ../modules/sddm.nix
    ../modules/ly.nix

    ## Compositor:
    ../modules/hyprland.nix
    # ../modules/wayfire.nix
    # ../modules/cosmic.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    mullvad-vpn
    networkmanager
    networkmanagerapplet
    wget
    nvtopPackages.amd
    curl
    easyeffects
    git
    jq
    # libreoffice
    flatpak
    librsvg
    papirus-icon-theme
    libnotify
    gammastep
    xdg-utils
    kdePackages.kio-admin
    gimp3-with-plugins
    bibata-cursors
    cloudflare-warp
    statix
    spotify
  ];

  programs = {
    nix-ld.enable = true; # needed because microsoft is incapable of making working installer
    java.enable = true;
    dconf.enable = true;
    # ssh.startAgent = true; # this needs to be commented if you are using cosmic
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
  };

  services = {
    libinput.enable = true;
    tumbler.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    udev.packages = [ pkgs.game-devices-udev-rules ];
    xserver.enable = true;
    xserver.xkb = {
      layout = "de";
      variant = "";
    };
    pipewire = {
      enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    enableAllFirmware = true;
    uinput.enable = true; # controller

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "plugdev"
      "input"
      "uinput"
    ];
    shell = pkgs.bash;
  };

  nix.settings = {
    max-jobs = "auto";
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +20";
  };

  nix.optimise.automatic = true;

  boot.loader.systemd-boot.configurationLimit = 10;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  system.stateVersion = "25.05";

  # Stupid check doesnt allow me to rebuild. Remove me eventually:
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
