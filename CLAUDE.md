# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Cross-platform dotfiles repository using Nix, nix-darwin, and home-manager to declaratively manage macOS (Darwin) and WSL2 (NixOS) environments.

**This is a public repository. Never commit secrets, API keys, work-related information, or machine-specific private settings.** Private shell configuration belongs in `~/.zshrc.local` (untracked).

## Common Commands

- `make switch` - Apply configuration changes (macOS and WSL2)
- `make update` - Update all flake inputs
- `make lint` - Run statix checks
- `make fmt` - Format Nix files with nixfmt-rfc-style
- `make test` - Run `nix flake check`

## Architecture

- **flake.nix**: Entry point. Defines inputs and calls `mkSystem` once per machine. Reads `NIX_USER` / `NIX_HOST` from the environment (set by the Makefile), which is why rebuilds use `--impure`.
- **lib/mksystem.nix**: The core abstraction. Assembles a NixOS or nix-darwin system with home-manager wired in. Takes `machine` (file in `machines/`), `system`, `user`, `host`, and `darwin` / `wsl` flags.
- **machines/**: Per-machine system configuration (`darwin.nix`, `wsl.nix`). Both import `modules/common.nix`.
- **modules/common.nix**: System configuration shared by all machines.
- **overlays/**: Package pins and overrides. `overlays/default.nix` returns the list applied to all machines.
- **users/upamune/**: home-manager configuration, split by concern (`packages.nix`, `cli.nix`, `git.nix`, `starship.nix`, `zsh.nix`). `home.nix` is the entry point; `zshrc` is loaded via `initContent`.

## How to Extend

- Add a machine: create `machines/<name>.nix`, call `mkSystem` in `flake.nix`.
- Pin or override a package: add an overlay file in `overlays/` and register it in `overlays/default.nix`.
- Add user-level configuration: add a file under `users/upamune/` and import it from `home.nix`.

## Conventions

- Declarative settings (history, keymap, completion init) live in Nix modules; only imperative shell script stays in `zshrc`.
- State versions: NixOS/home-manager `25.05`, Darwin `4`. Do not change them casually.
- Comments in Japanese, identifiers in English. Commit messages in Japanese.
