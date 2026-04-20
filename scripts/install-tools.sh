#!/usr/bin/env bash
# install-tools.sh — go, pip tools, starship, fisher
# LSP servers, formatters, treesitter parsers managed by Mason inside nvim
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }
warn()    { echo -e "${YELLOW}  ⚠${NC} $1"; }

# Source asdf and cargo
export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"
[ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"
[ -f "$HOME/.cargo/env" ]    && source "$HOME/.cargo/env"

# ── Go tools ─────────────────────────────────────────────────────────────────
# CLI tools only — LSP servers and formatters handled by Mason
if command -v go &>/dev/null; then
  log "Installing Go tools..."

  GO_TOOLS=(
    "github.com/xo/usql@latest"           # universal SQL client
    "github.com/antonmedv/fx@latest"      # interactive JSON explorer
    "github.com/charmbracelet/gum@latest" # TUI toolkit for scripts
  )

  for tool in "${GO_TOOLS[@]}"; do
    name=$(basename "${tool%@*}")
    if command -v "$name" &>/dev/null; then
      log "$name already installed, skipping"
    else
      log "Installing $name..."
      go install "$tool"
    fi
  done

  # zk — build from source
  if command -v zk &>/dev/null; then
    log "zk already installed, skipping"
  else
    log "Installing zk from source..."
    tmpdir=$(mktemp -d)
    git clone https://github.com/zk-org/zk.git "$tmpdir/zk"
    cd "$tmpdir/zk" && make build
    mkdir -p "$HOME/.local/bin"
    mv zk "$HOME/.local/bin/zk"
    cd - > /dev/null
    rm -rf "$tmpdir"
    success "zk installed"
  fi

  success "Go tools installed"
else
  warn "Go not found — skipping Go tools. Run install-asdf.sh first."
fi

# ── pip tools ────────────────────────────────────────────────────────────────
# Terminal database clients only — formatters handled by Mason
PIP=$(command -v pip3 2>/dev/null || command -v pip 2>/dev/null || echo "")

if [ -n "$PIP" ]; then
  log "Installing pip tools..."

  PIP_TOOLS=(
    pgcli    # Postgres interactive client
    litecli  # SQLite interactive client
  )

  for tool in "${PIP_TOOLS[@]}"; do
    if command -v "$tool" &>/dev/null; then
      log "$tool already installed, skipping"
    else
      log "Installing $tool..."
      $PIP install --user "$tool"
    fi
  done

  success "pip tools installed"
else
  warn "pip not found — skipping pip tools"
fi

# ── Starship ─────────────────────────────────────────────────────────────────
if command -v starship &>/dev/null; then
  log "starship already installed, skipping"
else
  log "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  success "starship installed"
fi

# ── Fisher ────────────────────────────────────────────────────────────────────
if command -v fish &>/dev/null; then
  log "Installing fisher binary..."
  curl -sL --max-time 30 \
    https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
    -o ~/.config/fish/functions/fisher.fish || true
  success "fisher installed — open fish to install plugins"
else
  warn "fish not found — skipping"
fi
