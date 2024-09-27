export DARWIN_USER := $(shell whoami)
export DARWIN_HOST := $(shell hostname -s)

.PHONY: all
all: help

.PHONY: help
help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: lint
lint: ## linter を実行
	@nix run nixpkgs#statix -- check ./

.PHONY: switch
switch: ## 環境をアップデート
	@echo "DARWIN_USER: $${DARWIN_USER}"
	@echo "DARWIN_HOST: $${DARWIN_HOST}"
	nix run nix-darwin -- switch --flake . --impure
	darwin-rebuild switch --flake . --impure

.PHONY: fmt
fmt: ## フォーマット
	@nix run nixpkgs#nixfmt-rfc-style -- .

.PHONY: test
test: ## テスト
	@nix flake check --show-trace
