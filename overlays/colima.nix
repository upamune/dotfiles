# colima を既存 VM (lima 0.22.0) と互換の 0.7.6 に pin する
{ inputs }:
final: prev: {
  inherit (import inputs.nixpkgs-colima { inherit (final.stdenv.hostPlatform) system; }) colima;
}
