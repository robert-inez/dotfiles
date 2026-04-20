#!/usr/bin/env bash
# link-dotfiles.sh — symlink dotfiles to ~/.config
# Safe to run multiple times — checks before linking
# Dotfiles cloned via HTTPS (public repo) — no SSH needed for clone
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }
warn()    { echo -e "${YELLOW}  ⚠${NC} $1"; }

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/projects/git/dotfiles}"
GITHUB_USER="${GITHUB_USER:-rinez}"
DOTFILES_REPO="${DOTFILES_REPO:-dotfiles}"

IS_WSL=false
grep -qi microsoft /proc/version 2>/dev/null && IS_WSL=true

# ── Clone dotfiles if not present ────────────────────────────────────────────
if [ ! -d "$DOTFILES_DIR" ]; then
  log "Dotfiles not found at $DOTFILES_DIR"
  log "Cloning via HTTPS (public repo)..."
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "https://github.com/$GITHUB_USER/$DOTFILES_REPO" "$DOTFILES_DIR" || \
    { echo "ERROR: Could not clone dotfiles from https://github.com/$GITHUB_USER/$DOTFILES_REPO"; exit 1; }
fi

# ── Helper ───────────────────────────────────────────────────────────────────
link() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    warn "Source not found: $src — skipping"
    return
  fi

  # Remove broken symlink or file that would block mkdir
  if [ -L "$dst" ] && [ ! -e "$dst" ]; then
    rm "$dst"
  fi

  if [ -L "$dst" ]; then
    ln -sf "$src" "$dst"
    log "Updated: $dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "${dst}.backup.$(date +%Y%m%d%H%M%S)"
    warn "Backed up existing: $dst"
    ln -sf "$src" "$dst"
    log "Linked: $dst"
  else
    ln -sf "$src" "$dst"
    log "Linked: $dst"
  fi
}

# ── Create directories ───────────────────────────────────────────────────────
mkdir -p ~/.config
mkdir -p ~/.config/tmux
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/fish/conf.d
mkdir -p ~/.config/zk
mkdir -p ~/.ssh
chmod 700 ~/.ssh

log "Symlinking configs from $DOTFILES_DIR..."

# ── Config symlinks ───────────────────────────────────────────────────────────
link "$DOTFILES_DIR/nvim"                        ~/.config/nvim
link "$DOTFILES_DIR/tmux/tmux.conf"              ~/.config/tmux/tmux.conf
link "$DOTFILES_DIR/starship/starship.toml"      ~/.config/starship.toml
link "$DOTFILES_DIR/fish/functions"              ~/.config/fish/functions
link "$DOTFILES_DIR/fish/fish_plugins"           ~/.config/fish/fish_plugins
link "$DOTFILES_DIR/fish/conf.d/reviewers.fish"  ~/.config/fish/conf.d/reviewers.fish
link "$DOTFILES_DIR/zk/config.toml"              ~/.config/zk/config.toml

# ── Alacritty — personal machine only ────────────────────────────────────────
if [ "$IS_WSL" = false ]; then
  mkdir -p ~/.config/alacritty
  link "$DOTFILES_DIR/alacritty" ~/.config/alacritty
else
  log "WSL2 detected — skipping alacritty (Windows Terminal handles it)"
fi

# ── SSH config ───────────────────────────────────────────────────────────────
if [ -f "$DOTFILES_DIR/ssh/config" ]; then
  link "$DOTFILES_DIR/ssh/config" ~/.ssh/config
  chmod 600 ~/.ssh/config
else
  warn "ssh/config not found in dotfiles — skipping"
  warn "Create $DOTFILES_DIR/ssh/config with your GitHub host aliases"
fi

success "Dotfiles linked"

# ── Write config.fish ────────────────────────────────────────────────────────
FISH_CONFIG="$HOME/.config/fish/config.fish"

if [ -f "$FISH_CONFIG" ]; then
  log "config.fish already exists — skipping"
  exit 0
fi

log "Writing config.fish..."

# Detect clipboard tool
if [ "$IS_WSL" = true ]; then
  PBCOPY="clip.exe"
  PBPASTE="powershell.exe -command 'Get-Clipboard'"
elif command -v wl-copy &>/dev/null; then
  PBCOPY="wl-copy"
  PBPASTE="wl-paste"
else
  PBCOPY="xclip -selection clipboard"
  PBPASTE="xclip -selection clipboard -o"
fi

cat > "$FISH_CONFIG" << EOF
set fish_greeting ""

# ── PATH ──────────────────────────────────────────────────────────────────
fish_add_path \$HOME/.local/bin
fish_add_path \$HOME/.cargo/bin
fish_add_path \$HOME/.local/share/bob/nvim-bin
fish_add_path \$HOME/.asdf/bin
fish_add_path \$HOME/.asdf/shims
fish_add_path (go env GOPATH 2>/dev/null)/bin

# ── asdf ──────────────────────────────────────────────────────────────────
source \$HOME/.asdf/asdf.fish 2>/dev/null; or true

# ── Aliases ───────────────────────────────────────────────────────────────
alias ls="eza -la --icons"
alias gs="git status"
alias pbcopy="$PBCOPY"
alias pbpaste="$PBPASTE"
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new-session -s"
alias killnvim="pkill -f nvim"

# ── Environment ───────────────────────────────────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx ZK_NOTEBOOK_DIR \$HOME/notes/work

# ── Init ──────────────────────────────────────────────────────────────────
starship init fish | source
direnv hook fish | source
zoxide init fish | source

# ── Theme ─────────────────────────────────────────────────────────────────
# Fisher and plugins installed by bootstrap — just set theme here
fish_config theme choose catppuccin-mocha
EOF

success "config.fish written"
