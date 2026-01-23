{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/doom.nix
    ../../modules/defaultPackages.nix
    ../../modules/hyprland.nix
  ];

  # Laptop specific packages
  environment.systemPackages = with pkgs; [

  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
  services.libinput.enable = true;
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

  programs.ssh.startAgent = true;
  services.flatpak.enable = true;
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

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;

  console.keyMap = "de";
  system.stateVersion = "25.05";
}
