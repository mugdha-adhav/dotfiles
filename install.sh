#!/bin/bash
#
# install.sh — Bootstrap dotfiles on a fresh macOS machine
#
# Usage:
#   1. Generate SSH key and add to GitHub (authentication + optionally signing)
#   2. git clone git@github.com:mugdha-adhav/dotfiles.git ~/.dotfiles
#   3. cd ~/.dotfiles && ./install.sh
#
# This script assumes macOS (Apple Silicon). It is not tested on Linux or Intel Macs.
# =============================================================================

set -euo pipefail

# -- Colours ------------------------------------------------------------------
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

print_info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
print_success() { echo -e "${GREEN}[OK]${NC}    $*"; }
print_error()   { echo -e "${RED}[FAIL]${NC}  $*"; }

# -- Helpers ------------------------------------------------------------------
command_exists() { command -v "$1" &>/dev/null; }

# -- OS check (macOS only) ----------------------------------------------------
check_os() {
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "This setup only supports macOS. Detected: $(uname)"
        exit 1
    fi
    if [[ "$(uname -m)" != "arm64" ]]; then
        print_error "This setup only supports Apple Silicon. Detected: $(uname -m)"
        exit 1
    fi
    print_success "macOS (Apple Silicon) detected"
}

# -- 1. Xcode CLI tools -------------------------------------------------------
install_xcode_cli() {
    if xcode-select -p &>/dev/null; then
        print_success "Xcode CLI tools are already installed"
    else
        print_info "Installing Xcode CLI tools..."
        xcode-select --install || true
        print_info "Waiting for Xcode CLI tools installation to complete..."
        until xcode-select -p &>/dev/null; do
            sleep 5
        done
        print_success "Xcode CLI tools installed"
    fi
}

# -- 2. Homebrew --------------------------------------------------------------
install_homebrew() {
    if command_exists brew; then
        print_success "Homebrew is already installed"
    else
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            print_error "Failed to install Homebrew"
            exit 1
        }
        print_success "Homebrew installed"
    fi
}

setup_brew_environment() {
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

# -- 3. Packages (Homebrew bundle) --------------------------------------------
install_packages() {
    print_info "Installing packages from Brewfile..."
    brew bundle --file "$(dirname "$0")/.Brewfile" || {
        print_error "Failed to install packages from Brewfile"
        exit 1
    }
    print_success "Packages installed from Brewfile"
}

# -- 4. Oh My Zsh -------------------------------------------------------------
install_omz() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_success "Oh My Zsh is already installed"
    else
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
            print_error "Failed to install Oh My Zsh"
            exit 1
        }
        print_success "Oh My Zsh installed"
    fi
}

# -- 5. Oh My Zsh custom plugins ----------------------------------------------
install_omz_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            "$zsh_custom/plugins/zsh-autosuggestions" || {
            print_error "Failed to install zsh-autosuggestions"
            exit 1
        }
        print_success "zsh-autosuggestions installed"
    else
        print_success "zsh-autosuggestions already installed"
    fi

    if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting \
            "$zsh_custom/plugins/zsh-syntax-highlighting" || {
            print_error "Failed to install zsh-syntax-highlighting"
            exit 1
        }
        print_success "zsh-syntax-highlighting installed"
    else
        print_success "zsh-syntax-highlighting already installed"
    fi
}

# -- 6. Stow dotfiles ---------------------------------------------------------
prepare_stow() {
    print_info "Removing files that stow will replace with symlinks..."

    # Remove Oh My Zsh default zshrc — it conflicts with our stowed version
    [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]] && rm "$HOME/.zshrc"
}

stow_dotfiles() {
    print_info "Stowing dotfiles..."
    stow . || {
        print_error "Failed to stow dotfiles. Check for conflicts."
        exit 1
    }
    print_success "Dotfiles stowed"
}

# -- Main ---------------------------------------------------------------------
main() {
    echo ""
    echo "========================================"
    echo "  dotfiles — macOS Setup"
    echo "========================================"
    echo ""

    check_os
    install_xcode_cli
    install_homebrew
    setup_brew_environment
    install_packages
    install_omz
    install_omz_plugins
    prepare_stow
    stow_dotfiles

    echo ""
    echo "========================================"
    echo "  Setup complete!"
    echo "========================================"
    echo ""
    print_success "Dotfiles have been stowed to \$HOME"
    echo ""
    echo "Manual steps remaining:"
    echo "  - SSH key: ssh-keygen -t ed25519, add pub key to GitHub"
    echo "  - Tailscale: install via DMG from https://tailscale.com/download"
    echo ""
}

main "$@"
