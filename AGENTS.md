# Repository Guidelines

## Project Structure & Module Organization
- Root flake entrypoint in `flake.nix`; system variants live in `darwin-configuration.nix` and `nixos-wsl-configuration.nix`, with shared Home Manager config in `home.nix` and optional tweaks in `common-configuration.nix`.
- CLI tooling lives in `_mise.toml`, `zshrc`, and `config/starship.nix`; adjust shell or prompt settings there rather than inlined edits.
- Repository automation is driven by `Makefile`; format/lint settings in `statix.toml`, hooks in `lefthook.yml`, and installer helper in `setup-mise.sh`.
- Run `make help` to list available targets; prefer adding new developer commands as Make targets for consistency.

## Build, Test, and Development Commands
- `make switch` – rebuilds and applies the flake (uses `nix-darwin` on macOS or `nixos-rebuild` on WSL Linux) and refreshes symlinks via `make link-config`.
- `make darwin-rebuild` – macOS-only rebuild path using `darwin-rebuild` directly.
- `make fmt` – format Nix sources with `nixfmt-rfc-style`.
- `make lint` – static analysis with `statix`.
- `make test` – `nix flake check` with trace output; run before PRs.
- `make update` – refreshes flake inputs; commit the resulting `flake.lock` diff.

## Coding Style & Naming Conventions
- Nix: 2-space indentation, trailing commas on attributes, and stable attribute ordering when practical; format with `make fmt` instead of manual edits.
- Shell: favor `bash`/`zsh` POSIX-compatible snippets; prefer `set -euo pipefail` in new scripts.
- Keep host/user parameters thread through `NIX_USER`/`NIX_HOST` (see `Makefile`); avoid hard-coding usernames or hostnames in modules.
- Name new modules descriptively (e.g., `config/<feature>.nix`) and import them from the relevant system file rather than embedding large blocks inline.

## Testing Guidelines
- Primary check is `make test` (`nix flake check`). Extend checks there if you add new modules or options.
- Hooks: `lefthook` runs `secretlint "**/*"` on pre-commit/push; ensure credentials and tokens are ignored or injected via environment variables, not files.
- Add small example hosts or stubbed options when introducing new modules so `nix flake check` can evaluate without machine-specific secrets.

## Commit & Pull Request Guidelines
- Commit messages are short and descriptive (recent history uses concise, imperative Japanese). Include context such as tool bumps or module additions.
- For PRs, summarize the change, mention target OS (macOS/WSL), list commands executed (`make fmt`, `make lint`, `make test`), and note any host-specific assumptions.
- Include screenshots only when changing terminal prompt visuals; otherwise, prefer config diffs and command outputs.
