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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser ... }@inputs:
    let
      system = "x86_64-linux";
      username = "nainteeth";

      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };

        modules = [
          ./system/hosts/${hostname}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit inputs hostname username zen-browser;
              };
            };

            networking.hostName = hostname;
          }
        ];
      };
    in
    {
      # Your two systems
      nixosConfigurations = {
        laptop = mkSystem "laptop";
        desktop = mkSystem "desktop";
      };
    };
}
