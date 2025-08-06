{
  description = "Robert's NixOS WSL2 + Home Manager Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, nixos-wsl, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        username = "rinez";
        homeDirectory = "/home/${username}";
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ git fish neovim ];
          shellHook = ''
            echo "Welcome to your dev shell, ${username}"
          '';
        };
      }
    ) // {
      nixosConfigurations.wsl2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            system.stateVersion = "25.05";
            wsl.enable = true;
            wsl.defaultUser = "rinez";

            home-manager.users.rinez = import ./home/rinez.nix;
          }
        ];
      };
    };
}
