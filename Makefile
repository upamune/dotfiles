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
	@echo "nix-darwin switch を実行中..."
	sudo -E NIX_CONFIG="experimental-features = nix-command flakes" nix run nix-darwin -- switch --flake . --impure
	@echo "nix-darwin switch が完了しました。"
else
	@echo "NixOS rebuild を実行中..."
	sudo -E nixos-rebuild switch --flake .#nixos --impure
	@echo "NixOS rebuild が完了しました。"
endif
	@$(MAKE) link-config

.PHONY: darwin-rebuild
darwin-rebuild: ## darwin-rebuild を直接使用してアップデート (macOS)
	@echo "NIX_USER: $${NIX_USER}"
	@echo "NIX_HOST: $${NIX_HOST}"
ifeq ($(PLATFORM),macos)
	@echo "darwin-rebuild switch を実行中..."
	sudo -E NIX_CONFIG="experimental-features = nix-command flakes" darwin-rebuild switch --flake . --impure
	@echo "darwin-rebuild switch が完了しました。"
else
	@echo "このコマンドはmacOSでのみ使用できます。"
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

.PHONY: link-config
link-config: ## 設定ファイルのsymlinkを作成
	@echo "設定ファイルのsymlinkを作成中..."
	@mkdir -p ~/.config/mise
	@ln -sf $(PWD)/_mise.toml ~/.config/mise/config.toml
	@echo "mise設定のsymlinkを作成しました: ~/.config/mise/config.toml -> $(PWD)/_mise.toml"
	@ln -sf $(PWD)/config/starship.toml ~/.config/starship.toml
	@echo "starship設定のsymlinkを作成しました: ~/.config/starship.toml -> $(PWD)/config/starship.toml"
	@mkdir -p ~/.config/bash
	@ln -sf $(PWD)/bashrc ~/.config/bash/dotfiles.bash
	@touch ~/.bashrc
	@if ! grep -Fq "source ~/.config/bash/dotfiles.bash" ~/.bashrc; then \
		printf '\n# dotfiles\nsource ~/.config/bash/dotfiles.bash\n' >> ~/.bashrc; \
		echo "~/.bashrc に dotfiles の設定を追加しました。"; \
	else \
		echo "~/.bashrc は既に dotfiles の設定を読み込んでいます。"; \
	fi
	@echo "設定ファイルのsymlinkの作成が完了しました。"

.PHONY: bootstrap
bootstrap: ## Nix を使わないホスト向けの初期設定 (mise + 各種config)
	@if [ ! -x "$$HOME/.local/bin/mise" ]; then \
		echo "mise が見つかりません。setup-mise.sh を実行します..."; \
		./setup-mise.sh; \
	else \
		echo "mise は既にインストールされています: $$HOME/.local/bin/mise"; \
	fi
	@$(MAKE) link-config

.PHONY: omarchy
omarchy: bootstrap ## omarchy 用セットアップ (bash)
