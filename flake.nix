{
  description = "rinez NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {

    # ── NixOS system + home-manager ──────────────────────────────────────────
    # `sudo nixos-rebuild switch --flake .#nixos` rebuilds both system and user config.
    # The hostname here must match networking.hostName in configuration.nix.
    nixosConfigurations.gaia = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs       = true;  # share system nixpkgs
          home-manager.useUserPackages     = true;  # install to /etc/profiles/per-user
          home-manager.backupFileExtension = "backup";
          home-manager.users.rinez        = import ./home.nix;
        }
      ];
    };

    # ── Standalone home-manager ───────────────────────────────────────────────
    # Useful for non-NixOS machines or quick testing.
    # `home-manager switch --flake .#rinez`
    homeConfigurations."rinez" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };

    homeConfigurations."rinez-wsl" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-wsl.nix ];
    };

  };
}
