#!/usr/bin/env bash
# install-cargo.sh — Rust via rustup and cargo tools
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }

CARGO_TOOLS=(
  xh        # curl-compatible HTTP client
  eza       # modern ls replacement
  bat       # cat with syntax highlighting
  zoxide    # frecency-based cd
  git-delta # better git diff
  bob-nvim  # neovim version manager
)

# ── Install Rust via rustup ─────────────────────────────────────────────────
if command -v rustup &>/dev/null; then
  log "Rust already installed, updating..."
  rustup update stable -q
else
  log "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --no-modify-path
fi

source "$HOME/.cargo/env"
success "Rust $(rustc --version)"

# ── Install cargo tools ─────────────────────────────────────────────────────
log "Installing cargo tools..."

for tool in "${CARGO_TOOLS[@]}"; do
  case "$tool" in
    bob-nvim)  binary="bob" ;;
    git-delta) binary="delta" ;;
    *)         binary="$tool" ;;
  esac

  if command -v "$binary" &>/dev/null; then
    log "$binary already installed, skipping"
  else
    log "Installing $tool..."
    cargo install "$tool"
  fi
done

success "Cargo tools installed"
