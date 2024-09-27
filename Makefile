# Detect OS
UNAME := $(shell uname)

# Set variables based on OS
ifeq ($(UNAME), Darwin)
    PLATFORM := macos
    export NIX_USER := $(shell whoami)
    export NIX_HOST := $(shell hostname -s)
else
    PLATFORM := linux
    export NIX_USER := $(shell whoami)
    export NIX_HOST := $(shell hostname)
endif

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
	@echo "NIX_USER: $${NIX_USER}"
	@echo "NIX_HOST: $${NIX_HOST}"
ifeq ($(PLATFORM),macos)
	nix run nix-darwin -- switch --flake . --impure
	@echo "nix-darwin switch が完了しました。"
	@read -p "darwin-rebuild も実行しますか？ (y/N): " answer; \
	if [ "$$answer" = "y" ] || [ "$$answer" = "Y" ]; then \
		darwin-rebuild switch --flake . --impure; \
	else \
		echo "darwin-rebuild はスキップされました。"; \
	fi
else
	#sudo -E nixos-rebuild switch --flake .#$${NIX_HOST} --impure
	sudo nixos-rebuild switch --flake .#nixos
endif

.PHONY: fmt
fmt: ## フォーマット
	@nix run nixpkgs#nixfmt-rfc-style -- .

.PHONY: test
test: ## テスト
	@nix flake check --show-trace

.PHONY: update
update: ## Flakeの入力を更新
	@nix flake update

.PHONY: clean
clean: ## キャッシュをクリーン
	@nix-collect-garbage -d

.PHONY: info
info: ## システム情報を表示
	@echo "Platform: $(PLATFORM)"
	@echo "User: $${NIX_USER}"
	@echo "Host: $${NIX_HOST}"
	@nix-shell -p nix-info --run "nix-info -m"
