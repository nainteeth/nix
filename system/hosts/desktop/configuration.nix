{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    # ../../modules/doom.nix
    ../../modules/defaultPackages.nix
    ../../modules/hyprland.nix
    ../../modules/wayfire.nix
  ];

  # Desktop specific packages
  environment.systemPackages = with pkgs; [
    mullvad-vpn
    polychromatic # Frontend für open razer
    input-remapper
    polkit_gnome
  ];
  programs = {
    steam = {
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
    ssh.startAgent = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    openrazer.enable = true;
    openrazer.users = [ "nainteeth" ];
    opentabletdriver.enable = true;
    wooting.enable = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    enableAllFirmware = true;
  };

  services = {
    flatpak.enable = true;
    dbus.enable = true;
    input-remapper.enable = true;
    udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
    '';
    cloudflare-warp.enable = true;
    mullvad-vpn.enable = true;
    displayManager.ly = {
      enable = true;
    };
    # This is needed for UxPlay to work
    avahi = {
      enable = true;
      nssmdns4 = true; # Enable mDNS resolution for NSS
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
    pipewire = {
      enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        7000
        7001
        7100
      ];
      allowedUDPPorts = [
        5353
        6000
        6001
        7011
      ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";

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
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };
  nixpkgs.config.allowUnfree = true;
  console.keyMap = "de";
  system.stateVersion = "25.05";
}
