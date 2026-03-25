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
    ../modules/hyprland.nix
    # ../modules/wayfire.nix
    ../modules/ly.nix
    # ../modules/sddm.nix  This does not exist yet.
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
    libreoffice
    flatpak
    librsvg
    papirus-icon-theme
    libnotify
    gammastep
    xdg-utils
    kdePackages.kdeconnect-kde
    kdePackages.kio-admin
    gimp3-with-plugins
    bibata-cursors
    cloudflare-warp
    statix
    spotify
  ];

  programs = {
    java.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
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
    tumbler.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    printing.enable = true;
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
      "audio"
      "plugdev"
    ];
    shell = pkgs.bash;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  system.stateVersion = "25.05";
}
