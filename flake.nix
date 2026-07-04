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
    # overlays/colima.nix で使う pin 用の nixpkgs
    nixpkgs-colima.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      # ユーザー名とホスト名は環境変数から読む (Makefile が設定する)。
      # そのため rebuild には --impure が必要。
      username = builtins.getEnv "NIX_USER";
      hostname = builtins.getEnv "NIX_HOST";

      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs; };
    in
    {
      darwinConfigurations.${hostname} = mkSystem {
        machine = "darwin";
        system = "aarch64-darwin";
        user = username;
        host = hostname;
        darwin = true;
      };

      nixosConfigurations.nixos = mkSystem {
        machine = "wsl";
        system = "x86_64-linux";
        user = "nixos";
        host = "nixos";
        wsl = true;
      };
    };
}
