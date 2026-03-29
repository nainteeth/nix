{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/856b01ebd1de3f53c3929ce8082d9d67d799d816"; # currently pinning to a version because the hm module for neovim is bugged: Error installing file '.config/nvim/init.lua' outside $HOME
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/a7f1db35d74faf04e5189b3a32f890186ace5c28"; # currently pinning to a version because the hm module for zen browser is bugged: showing all grey window when starting with no error log.
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      nix-flatpak,
      # noctalia,
      firefox-addons,
      ...
    }@inputs:
    let
      username = "nainteeth";

      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              username
              nix-flatpak
              # noctalia
              firefox-addons
              ;
          };
          modules = [
            ./system/hosts/${hostname}/configuration.nix
            {
              nixpkgs.hostPlatform = "x86_64-linux";
              nixpkgs.config.allowUnfree = true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./home/hosts/${hostname}/${hostname}.nix;
                backupFileExtension = "backup";

                extraSpecialArgs = {
                  inherit
                    inputs
                    hostname
                    username
                    zen-browser
                    nix-flatpak
                    # noctalia
                    firefox-addons
                    ;
                };
              };
              networking.hostName = hostname;
            }
          ];
        };

      mkHome =
        hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              inputs
              hostname
              username
              ;
          };
          modules = [ ./home/hosts/${hostname}/${hostname}.nix ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem "laptop";
        desktop = mkSystem "desktop";
      };

      homeConfigurations = {
        standalone = mkHome "standalone";
      };
    };
}
