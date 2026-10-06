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
Home Manager symlinks Nix application bundles and `mac-app-util` creates small
launchers under `~/Applications/Home Manager Trampolines` so Spotlight can find
them without copying the full applications.
Dock, keyboard, and other macOS defaults are deliberately deferred to
`nix/modules/darwin/system-preferences.nix`.

### Personal LibreWolf configuration

The personal MacBook manages LibreWolf through
[`nix/modules/profiles/librewolf.nix`](nix/modules/profiles/librewolf.nix).
It creates a new default profile named `personal`, with Qwant as the normal
and private search engine, and installs LanguageTool, Bitwarden, Ghostery,
Keepa, NoScript, and PopUpOFF. The work MacBook is unaffected.

Before the first switch, quit LibreWolf and back up
`~/Library/Application Support/LibreWolf` if you already use it. Home Manager
will refuse to overwrite an existing unmanaged `profiles.ini`. After backing
up, move that registry aside if it exists:

```bash
mv -n "$HOME/Library/Application Support/LibreWolf/profiles.ini" \
	"$HOME/Library/Application Support/LibreWolf/profiles.ini.before-home-manager"
```

This does not delete the existing profile directories, but the new registry
only lists the managed profile. The backup retains the old profile paths.
Add the new Nix module to Git's index before evaluating the Git-backed flake:

```bash
git add nix/modules/profiles/librewolf.nix
darwin-rebuild switch --flake .#personal-macbook
```

On launch, verify the active profile in `about:profiles`; select `personal`
as the default there if LibreWolf's per-installation default still selects an
older profile. Verify Qwant in search settings and the extensions in
`about:addons`. Extensions may still require their usual sign-in or setup.

To change search engines, edit `profiles.personal.search`, including the URL
template for custom engines. Search configuration is reapplied on each switch,
so search changes made only in the browser are not persistent across switches.
To change extensions, edit `profiles.personal.extensions.packages`, using names
from `pkgs.nur.repos.rycee.firefox-addons`. NUR manages their download URLs,
checksums, and versions. Update the NUR input with `nix flake update nur`, then
rebuild to apply the newer packages. Keep the generated flake lock file in Git
for reproducible versions.

PopUpOFF is not currently packaged by rycee, so its entry uses NUR's
`buildFirefoxXpiAddon` with a pinned URL and checksum. Update its version, URL,
and checksum together. Mozilla's
`https://addons.mozilla.org/api/v5/addons/addon/popupoff/` endpoint provides its
`guid` and `current_version.file` URL and checksum. Package pins do not disable
LibreWolf's own extension updates.

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
