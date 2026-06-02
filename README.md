# dotfiles

Personal macOS (Apple Silicon) dotfiles and setup.

## Setup

```sh
git clone https://github.com/mugdha-adhav/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

## Adding dotfiles

Place the file in `~/.dotfiles/`, then:

```sh
stow .
git add . && git commit && git push
```

> Only run `stow .` when adding new files. Edits to existing files are live immediately since `~HOME` entries are symlinks.

## macOS settings

Preferences worth setting on a fresh machine:

- **Dock** — auto-hide on, remove recent apps, minimize windows into app icon, icon size 44px
- **Trackpad** — enable tap to click
- **Appearance** — set to Auto (switches dark/light with system)

## Manual installs

- **SSH key** — generate and add to GitHub for git over SSH and commit signing
  ```sh
  ssh-keygen -t ed25519
  cat ~/.ssh/id_ed25519.pub
  # Add to https://github.com/settings/keys
  ```
- **Tailscale** — install via DMG from https://tailscale.com/download (the cask doesn't handle the system extension reliably)
