# nixos-wsl-configuration.nix
{ user }:
{ config, pkgs, ... }:

{
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    defaultUser = user;
    startMenuLaunchers = true;
    nativeSystemd = true;
  };
}
