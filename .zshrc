# =============================================================================
# .zshrc — Managed by GNU Stow from ~/.dotfiles/
# =============================================================================

# -- Deduplicate PATH ---------------------------------------------------------
typeset -U path

# -- Word style ---------------------------------------------------------------
# Treat "git commit" as two words for Ctrl-W/Alt-Backspace
autoload -U select-word-style
select-word-style bash

# -- PATH ---------------------------------------------------------------------
path=(
    $HOME/.local/bin
    /opt/homebrew/opt/coreutils/libexec/gnubin
    $path
)
export PATH

# -- Oh My Zsh config (must be set BEFORE sourcing) --------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode disabled
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting  # must be last
)

source "$ZSH/oh-my-zsh.sh"

# -- History ------------------------------------------------------------------
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# -- Shell integrations (after OMZ so keybindings win) ------------------------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# -- Aliases ------------------------------------------------------------------
alias cat='bat --style=header,snip,changes'
alias lc='eza --git --color=always --group-directories-first --icons=always'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"
