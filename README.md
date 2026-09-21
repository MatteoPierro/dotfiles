# Dotfiles

Personal configuration files protected by Betterleaks secret scanning.

## Setup

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
