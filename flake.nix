{
  description = "NixOS Hyprland Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, nix-flatpak, ... }@inputs:
    let
      username = "nainteeth";

      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username nix-flatpak; };

        modules = [
          ./system/hosts/${hostname}/configuration.nix
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home/hosts/${hostname}/${hostname}.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit inputs hostname username zen-browser nix-flatpak;
              };
            };

            networking.hostName = hostname;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem "laptop";
        desktop = mkSystem "desktop";
      };
    };
}
