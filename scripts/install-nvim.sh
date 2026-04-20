#!/usr/bin/env bash
# install-nvim.sh — neovim via bob version manager
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ── Install bob ─────────────────────────────────────────────────────────────
if ! command -v bob &>/dev/null; then
  log "Installing bob (neovim version manager)..."
  cargo install bob-nvim
else
  log "bob already installed"
fi

# ── Install stable nvim ──────────────────────────────────────────────────────
log "Installing neovim stable via bob..."
bob install stable
bob use stable

BOB_BIN="$HOME/.local/share/bob/nvim-bin"
if [[ ":$PATH:" != *":$BOB_BIN:"* ]]; then
  export PATH="$BOB_BIN:$PATH"
fi

success "Neovim $(nvim --version | head -1) installed"
