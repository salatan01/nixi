{
  description = "My PC flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-pinned.url = "github:nixos/nixpkgs/e576e3c9cf9bad747afcddd9e34f51d18c855b4e";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.11";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    silentSDDM = {
      url = "github:salatan01/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    parallex.url = "github:nightkatt/parallex";
    parallex.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-pinned,
      nixpkgs-old,
      home-manager,
      nvf,
      silentSDDM,
      parallex,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pinned = import nixpkgs-pinned {
        inherit system;
        config.allowUnfree = true;
      };
      old = import nixpkgs-old {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            inputs
            unstable
            pinned
            old
            ;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # --- THE FIX ---
            # This handles the "Existing file would be clobbered" error
            home-manager.backupFileExtension = "hm-bak";
            # ---------------

            home-manager.users.nightkat01 = import ./home.nix;

            home-manager.extraSpecialArgs = {
              inherit
                inputs
                unstable
                pinned
                old
                ;
            };
          }
        ];
      };
    };
}

