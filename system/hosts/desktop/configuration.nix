{
  pkgs,
  username,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  environment.systemPackages = with pkgs; [
    polychromatic
    input-remapper
    polkit_gnome
  ];

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

  services.ollama = {
    enable = true;
    # run this command to install the llm:
    # ollama pull qwen2.5-coder:14b
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    openrazer = {
      enable = true;
      users = [ username ];
    };
    opentabletdriver.enable = true;
    wooting.enable = true;
  };

  services = {
    input-remapper.enable = true;
    cloudflare-warp.enable = true;
    mullvad-vpn.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
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
    udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE="0666", GROUP="input"
    '';
  };

  security = {
    polkit.enable = true;
    sudo.extraRules = [
      {
        users = [ username ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  networking = {
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

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
}
