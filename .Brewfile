# -- macOS GNU utilities (replaces BSD tools with GNU versions) ---------------
if OS.mac?
  brew "coreutils"    # GNU File, Shell, and Text utilities
  brew "findutils"    # Collection of GNU find, xargs, and locate
  brew "gnu-sed"      # GNU implementation of the famous stream editor
  brew "gnu-tar"      # GNU version of the tar archiving utility
end

# -- Core CLI tools -----------------------------------------------------------
brew "fzf"            # Command-line fuzzy finder written in Go
brew "zoxide"         # Shell extension to navigate your filesystem faster
brew "bat"            # Clone of cat(1) with syntax highlighting and Git integration
brew "eza"            # Modern, maintained replacement for ls
brew "git-delta"      # Syntax-highlighting pager for git and diff output
brew "wget"           # Internet file retriever
brew "stow"           # Organise software neatly under a single directory tree
# -- Development tools --------------------------------------------------------
brew "gh"             # GitHub command-line tool
brew "jq"             # Lightweight and flexible command-line JSON processor

# -- Casks (macOS GUI apps) ---------------------------------------------------
if OS.mac?
  cask "docker"             # Docker Desktop — daemon + CLI
  cask "discord"            # Voice and text chat
  cask "ghostty"            # GPU-accelerated terminal emulator
  cask "zed"                # High-performance code editor
  cask "keyboardcleantool"  # Blocks all Keyboard and TouchBar input
  cask "keepingyouawake"    # Prevents macOS from going to sleep
  cask "prismlauncher"      # Open source Minecraft launcher
  cask "rectangle"          # Window management app
end
