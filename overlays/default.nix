# すべてのマシンに適用するオーバーレイの一覧。
# パッケージを pin したいときはここにファイルを追加する。
{ inputs }:
[
  (import ./colima.nix { inherit inputs; })
]
