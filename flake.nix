{
  description = "Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nix-darwin, home-manager }: 
    let
      darwinUser = builtins.getEnv "DARWIN_USER";
      darwinHost = builtins.getEnv "DARWIN_HOST";
      
      mkDarwinSystem = { hostname, username }: nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            networking.hostName = hostname;
            users.users.${username}.home = "/Users/${username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = { pkgs, lib, ... }: 
              import ./home.nix { inherit pkgs lib username; };
          }
        ];
        specialArgs = { 
          inherit (nixpkgs) lib; 
          inherit username; 
        };
      };
    in {
      darwinConfigurations.${darwinHost} = mkDarwinSystem {
        hostname = darwinHost;
        username = darwinUser;
      };
    };
}
