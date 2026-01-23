{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/doom.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # OSU! starter pack
  hardware.opentabletdriver.enable = true;
  hardware.wooting.enable = true;
  services.udev.extraRules = ''
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  '';

  # AMD GPU drivers | Do I even need to configure these? Idk
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  networking.networkmanager.enable = true;
  services.displayManager.ly = {
    enable = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.enableAllFirmware = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "nainteeth";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    vim
    networkmanager
    networkmanagerapplet
    wget
    curl
    git
    jq
    libreoffice
    flatpak
    thunar
    thunar-volman
    thunar-archive-plugin
    libnotify
    gammastep
    xdg-utils
    kdePackages.kdeconnect-kde
    kdePackages.kio-admin
    gimp3-with-plugins
    bibata-cursors
    libwacom
    libinput
    wootility
  ];

  services.flatpak.enable = true;

  programs.ssh.startAgent = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;

  console.keyMap = "de";
  system.stateVersion = "25.05";
}
