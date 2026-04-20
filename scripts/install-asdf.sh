#!/usr/bin/env bash
# install-asdf.sh — asdf version manager, Go and Node runtimes
# Python handled by system package manager — Ubuntu 22.04+ and Tumbleweed
# both ship recent Python (3.11+) so asdf Python is never needed
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }

ASDF_DIR="$HOME/.asdf"

# ── Install asdf ─────────────────────────────────────────────────────────────
if [ -d "$ASDF_DIR" ]; then
  log "asdf already installed, skipping"
else
  log "Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.0
fi

# Source asdf and add to PATH for this session
export PATH="$ASDF_DIR/bin:$ASDF_DIR/shims:$PATH"
source "$ASDF_DIR/asdf.sh"

if ! command -v asdf &>/dev/null; then
  echo "ERROR: asdf failed to load"
  exit 1
fi

success "asdf $(asdf version)"

# ── Go ───────────────────────────────────────────────────────────────────────
log "Setting up Go..."
asdf plugin add golang 2>/dev/null || true
asdf install golang latest
asdf global golang latest
success "Go $(go version)"

# ── Node ─────────────────────────────────────────────────────────────────────
log "Setting up Node.js LTS..."
asdf plugin add nodejs 2>/dev/null || true
asdf install nodejs lts
asdf global nodejs lts
success "Node $(node --version)"

# ── Python ───────────────────────────────────────────────────────────────────
# System Python is sufficient on all supported distros:
# - Ubuntu 22.04+ ships Python 3.10+
# - Ubuntu 24.04 ships Python 3.12
# - Tumbleweed ships latest stable Python
# asdf Python only needed if system Python is missing entirely
if command -v python3 &>/dev/null; then
  success "Python $(python3 --version) — using system Python"
else
  log "System Python not found — installing via asdf..."
  asdf plugin add python 2>/dev/null || true
  PYTHON_VERSION=$(asdf list all python | grep "^3\.13\.[0-9]*$" | tail -1)
  log "Installing Python $PYTHON_VERSION..."
  asdf install python "$PYTHON_VERSION"
  asdf global python "$PYTHON_VERSION"
  success "Python $(python3 --version)"
fi
