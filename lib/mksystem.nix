# NixOS / nix-darwin のシステムを組み立てる共通関数。
# マシンを追加するときは machines/ に設定ファイルを置き、
# flake.nix からこの関数を呼び出すだけでよい。
{ nixpkgs, inputs }:

{
  # machines/<machine>.nix を読み込む
  machine,
  # "aarch64-darwin" / "x86_64-linux" など
  system,
  # ログインユーザー名 (home-manager の対象)
  user,
  # networking.hostName に設定するホスト名
  host,
  darwin ? false,
  wsl ? false,
}:

let
  inherit (nixpkgs) lib;

  machineConfig = ../machines/${machine}.nix;

  systemFunc = if darwin then inputs.nix-darwin.lib.darwinSystem else lib.nixosSystem;

  homeManagerModule =
    if darwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
systemFunc {
  inherit system;

  modules =
    lib.optionals wsl [
      inputs.nixos-wsl.nixosModules.default
      { wsl.defaultUser = user; }
    ]
    ++ lib.optionals darwin [
      { users.users.${user}.home = "/Users/${user}"; }
    ]
    ++ [
      { nixpkgs.overlays = import ../overlays { inherit inputs; }; }
      machineConfig
      { networking.hostName = host; }
      homeManagerModule
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            username = user;
          };
          users.${user} = ../users/upamune/home.nix;
        };
      }
    ];

  specialArgs = {
    inherit user inputs;
  };
}
