#!/usr/bin/env bash
# setup-zk.sh — initialize zk notebooks and symlink config
# Interactive — asks which notebooks to set up
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }
warn()    { echo -e "${YELLOW}  ⚠${NC} $1"; }

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/projects/git/dotfiles}"
ZK_TEMPLATES="$DOTFILES_DIR/zk/templates"
ZK_CONFIG="$DOTFILES_DIR/zk/config.toml"

if ! command -v zk &>/dev/null; then
  warn "zk not found — skipping notebook setup"
  warn "Build from source: git clone https://github.com/zk-org/zk && cd zk && make build"
  exit 0
fi

if [ ! -f "$ZK_CONFIG" ]; then
  warn "zk config not found at $ZK_CONFIG — skipping"
  exit 0
fi

# ── Ask which notebooks to set up ───────────────────────────────────────────
echo ""
echo "Which zk notebooks do you want to set up?"
echo "  1) Work only"
echo "  2) Personal only"
echo "  3) Both work and personal"
echo "  4) Skip"
read -rp "Choice [1-4]: " choice

# ── Setup helper ─────────────────────────────────────────────────────────────
setup_notebook() {
  local name="$1"
  local path="$2"

  log "Setting up $name notebook at $path..."
  mkdir -p "$path"

  if [ ! -d "$path/.zk" ]; then
    cd "$path" && zk init && cd - > /dev/null
    log "Initialized $name notebook"
  else
    log "$name notebook already initialized"
  fi

  # Remove non-symlink templates/config before relinking
  [ -d "$path/.zk/templates" ] && [ ! -L "$path/.zk/templates" ] && rm -rf "$path/.zk/templates"
  [ -f "$path/.zk/config.toml" ] && [ ! -L "$path/.zk/config.toml" ] && rm "$path/.zk/config.toml"

  ln -sf "$ZK_CONFIG"    "$path/.zk/config.toml"
  ln -sf "$ZK_TEMPLATES" "$path/.zk/templates"

  # Create daily subdirectory
  mkdir -p "$path/daily"

  success "$name notebook ready at $path"
}

case "$choice" in
  1)
    setup_notebook "work" "$HOME/notes/work"
    echo ""
    log "Add to your fish config: set -gx ZK_NOTEBOOK_DIR \$HOME/notes/work"
    ;;
  2)
    setup_notebook "personal" "$HOME/notes/personal"
    echo ""
    log "Add to your fish config: set -gx ZK_NOTEBOOK_DIR \$HOME/notes/personal"
    ;;
  3)
    setup_notebook "work"     "$HOME/notes/work"
    setup_notebook "personal" "$HOME/notes/personal"
    echo ""
    log "Set ZK_NOTEBOOK_DIR based on context:"
    log "  Work:     set -gx ZK_NOTEBOOK_DIR \$HOME/notes/work"
    log "  Personal: set -gx ZK_NOTEBOOK_DIR \$HOME/notes/personal"
    ;;
  4)
    log "Skipping zk setup"
    ;;
  *)
    warn "Invalid choice — skipping zk setup"
    ;;
esac
