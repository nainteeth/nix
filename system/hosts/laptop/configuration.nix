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
  ];

  # Laptop specific packages
  environment.systemPackages = with pkgs; [

  ];
  programs = {
    ssh.startAgent = true;
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    enableAllFirmware = true;
  };

  services = {
    flatpak.enable = true;
    printing.enable = true;
    displayManager.ly = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
    libinput.enable = true;
  };

  security = {
    rtkit.enable = true;
  };

  networking = {
    networkmanager.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

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
  console.keyMap = "de";
  system.stateVersion = "25.05";
}
