.PHONY: help
help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: update
update: ## 環境をアップデート
	nix run nix-darwin -- switch --flake . --impure
	darwin-rebuild switch --flake . --impure
