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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "nainteeth";

      # Helper function to create system configurations
      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };

        modules = [
          # System configuration
          ./hosts/${hostname}/configuration.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home;
              backupFileExtension = "backup";

              # Pass extra arguments to home-manager
              extraSpecialArgs = {
                inherit inputs hostname username;
              };
            };

            # Set hostname
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
