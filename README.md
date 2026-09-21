# Dotfiles

Personal configuration files protected by Betterleaks secret scanning.

## Nix configuration

The flake defines separate personal and work MacBooks while sharing package
modules between them. Portable packages live under `nix/modules/home`, role
specific packages under `nix/modules/profiles`, and macOS-only applications
under `nix/modules/darwin`. New hosts should be small compositions in
`nix/hosts`; the Home Manager modules can also be reused by a future Linux host.

Install Nix, then bootstrap the selected machine with nix-darwin:

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#personal-macbook
# or
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#work-macbook
```

After the first switch, apply later changes with:

```bash
darwin-rebuild switch --flake .#personal-macbook
nix flake check
```

The host names and username in `nix/hosts` are intentionally the only
machine-specific values. Change them to match the actual machines before the
first switch. Nix installs and manages Homebrew, which is retained only for
Darwin applications or tapped tools without a dependable nixpkgs package.
Dock, keyboard, and other macOS defaults are deliberately deferred to
`nix/modules/darwin/system-preferences.nix`.

The repository uses [`.chezmoiroot`](.chezmoiroot), so managed source state lives
under [`chezmoi/`](chezmoi) while repository tooling stays at the top level.
The generated chezmoi configuration uses symlink mode and VS Code as its editor.
Managed files link to the repository, so edits from either location immediately
affect the same file.

## Dotfiles setup

Install chezmoi and apply the dotfiles from GitHub:

```bash
brew install chezmoi
chezmoi init --apply MatteoPierro
```

Preview future changes without applying them:

```bash
chezmoi diff
```

To capture later changes made directly to a managed file:

```bash
chezmoi add ~/.config/wezterm/wezterm.lua
```

## Pre-commit setup

Run the setup script after cloning the repository:

```bash
./scripts/setup-pre-commit.sh
```

The script installs `pre-commit` with Homebrew when necessary, validates
[`.pre-commit-config.yaml`](.pre-commit-config.yaml), installs the hook environment,
and configures this repository to use [`.githooks`](.githooks). If a global
pre-commit hook is configured, the repository hook runs it before Betterleaks.
The first setup may take a few minutes while `pre-commit` builds Betterleaks.

Betterleaks scans only staged changes before each commit. Findings are redacted,
and a detected secret blocks the commit.

Run the check manually with:

```bash
pre-commit run betterleaks
```

Update Betterleaks to its latest release with:

```bash
pre-commit autoupdate --repo https://github.com/betterleaks/betterleaks
```
