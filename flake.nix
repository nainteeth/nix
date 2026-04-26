{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
      nix-flatpak,
      # noctalia,
      ...
    }@inputs:
    let
      username = "nainteeth";
      repoDir = "/home/${username}/nix";
      configDir = "${repoDir}/home/dotfiles";
      symlink = config: path: config.lib.file.mkOutOfStoreSymlink "${configDir}/${path}";

      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              username
              nix-flatpak
              # noctalia
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
                    symlink
                    nix-flatpak
                    # noctalia
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
              symlink
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
