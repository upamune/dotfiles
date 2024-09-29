{
  description = "Cross-platform system flake for Darwin and WSL NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nixos-wsl,
    }:
    let
      username = builtins.getEnv "NIX_USER";
      hostname = builtins.getEnv "NIX_HOST";

      mkDarwinSystem =
        {
          system,
          host,
          user,
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              networking.hostName = host;
              users.users.${user}.home = "/Users/${user}";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} =
                { pkgs, lib, ... }:
                import ./home.nix {
                  inherit pkgs lib;
                  username = user;
                };
            }
          ];
          specialArgs = {
            inherit (nixpkgs) lib;
            inherit user;
          };
        };
      mkNixosSystem =
        {
          system,
          host,
          user,
          wsl ? false,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              (import ./nixos-configuration.nix)
              home-manager.nixosModules.home-manager
              {
                networking.hostName = host;
                users.users.${user} = {
                  isNormalUser = true;
                  home = "/home/${user}";
                  extraGroups = [ "wheel" ];
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} =
                  { pkgs, lib, ... }:
                  import ./home.nix {
                    inherit pkgs lib;
                    username = user;
                  };
              }
            ]
            ++ (
              if wsl then
                [
                  nixos-wsl.nixosModules.wsl
                  (import ./nixos-wsl-configuration.nix)
                ]
              else
                [ ]
            );

          specialArgs = {
            inherit (nixpkgs) lib;
            inherit user;
          };
        };

    in
    {
      darwinConfigurations.${hostname} = mkDarwinSystem {
        system = "aarch64-darwin";
        host = hostname;
        user = username;
      };

      nixosConfigurations.wsl = mkNixosSystem {
        system = "x86_64-linux";
        host = "nixos";
        user = "nixos";
        wsl = true;
      };

      nixosConfigurations.nixos = mkNixosSystem {
        system = "x86_64-linux";
        host = "nixos";
        user = "upamune";
      };
    };
}
