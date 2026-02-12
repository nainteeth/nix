{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/doom.nix
    ../../modules/defaultPackages.nix
    ../../modules/hyprland.nix
  ];

  # Desktop specific packages
  environment.systemPackages = with pkgs; [
    mullvad-vpn
    polychromatic # Frontend für open razer
    input-remapper
    polkit_gnome
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraProfile = ''
        export GDK_SCALE=1
        export GDK_DPI_SCALE=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_SCALE_FACTOR=1
      '';
      extraArgs = "-forcedesktopscaling 1.0 -no-force-device-scale-factor";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.polkit.enable = true;
  services.dbus.enable = true;

  # Razer mouse
  hardware.openrazer.enable = true;
  hardware.openrazer.users =  ["nainteeth"];
  services.input-remapper.enable = true;

  # OSU! starter pack
  hardware.opentabletdriver.enable = true;
  hardware.wooting.enable = true;
  services.udev.extraRules = ''
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
  '';

  networking.networkmanager.enable = true;

  # Trying to play hypixel skyblock in eu
  services.cloudflare-warp.enable = true;
  networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
  services.mullvad-vpn.enable = true;

  services.displayManager.ly = {
    enable = true;
  };

  # This is needed for UxPlay to work
  services.avahi = {
    enable = true;
    nssmdns4 = true;  # Enable mDNS resolution for NSS
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 7000 7001 7100 ];
    allowedUDPPorts = [ 5353 6000 6001 7011 ];
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
      "plugdev"
    ];
  shell = pkgs.bash;
  };

  services.flatpak.enable = true;

  programs.ssh.startAgent = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
	Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
      };
    };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;

  console.keyMap = "de";
  system.stateVersion = "25.05";
}
