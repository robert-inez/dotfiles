#!/usr/bin/env bash
# install-fonts.sh — CaskaydiaCove Nerd Font
# Skipped on WSL2 — Windows manages fonts
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }
warn()    { echo -e "${YELLOW}  ⚠${NC} $1"; }

FONT_DIR="$HOME/.local/share/fonts"

# Skip on WSL2
if grep -qi microsoft /proc/version 2>/dev/null; then
  warn "WSL2 detected — skipping font install"
  warn "Install CaskaydiaCove Nerd Font on Windows:"
  warn "https://github.com/ryanoasis/nerd-fonts/releases/latest"
  exit 0
fi

# Check if already installed
if fc-list | grep -qi "CaskaydiaCove\|Cascadia Code NF" 2>/dev/null; then
  log "CaskaydiaCove Nerd Font already installed"
  exit 0
fi

log "Installing CaskaydiaCove Nerd Font..."
mkdir -p "$FONT_DIR"
tmpdir=$(mktemp -d)

RELEASE_URL=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
  | grep "browser_download_url.*CascadiaCode.zip" \
  | cut -d '"' -f 4)

if [ -z "$RELEASE_URL" ]; then
  warn "Could not fetch font release URL"
  warn "Download manually: https://github.com/ryanoasis/nerd-fonts/releases/latest"
  exit 1
fi

curl -fsSL "$RELEASE_URL" -o "$tmpdir/CascadiaCode.zip"
unzip -q "$tmpdir/CascadiaCode.zip" -d "$tmpdir/fonts"
cp "$tmpdir"/fonts/CaskaydiaCove*.ttf "$FONT_DIR/" 2>/dev/null || \
cp "$tmpdir"/fonts/*.ttf "$FONT_DIR/"
rm -rf "$tmpdir"

fc-cache -f "$FONT_DIR"
success "CaskaydiaCove Nerd Font installed"
