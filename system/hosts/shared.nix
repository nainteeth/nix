{ config, pkgs, username, ... }:

{
  # nested imports are pretty cool
  imports = [
    ../modules/doom.nix
  ];
  networking.networkmanager.enable = true;
  
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

    environment.system.Packages = with pkgs; [
      vim
      wget
      curl
      git
    ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;

    console.keyMap = "de";
    system.stateVersion = "25.05";
}
