#!/usr/bin/env bash
# bootstrap.sh — new machine setup orchestrator
# Usage: ./bootstrap.sh [--dotfiles-dir <path>]
#
# Prerequisites:
#   1. Internet connection
#   2. SSH key generated and added to GitHub (for pushing commits later)
#      ssh-keygen -t ed25519 -C "rinez-personal" -f ~/.ssh/id_ed25519_personal
#
# Dotfiles repo is public — cloned via HTTPS, no auth needed
set -euo pipefail

# ── Colors ─────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()     { echo -e "${BLUE}==>${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }

# ── Config ──────────────────────────────────────────────────────────────────
# Standardized path across all machines
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/projects/git/dotfiles}"
GITHUB_USER="rinez"
DOTFILES_REPO="dotfiles"

# Parse args
while [[ $# -gt 0 ]]; do
  case $1 in
    --dotfiles-dir) DOTFILES_DIR="$2"; shift 2 ;;
    *) error "Unknown argument: $1" ;;
  esac
done

export DOTFILES_DIR
export GITHUB_USER
export DOTFILES_REPO

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Detect OS ───────────────────────────────────────────────────────────────
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  error "Cannot detect OS"
fi

export OS
log "Detected OS: $OS"
log "Dotfiles dir: $DOTFILES_DIR"
echo ""

# ── Run scripts in order ────────────────────────────────────────────────────
log "Step 1/8 — System packages"
bash "$SCRIPT_DIR/install-apt.sh"

log "Step 2/8 — Rust + cargo tools"
bash "$SCRIPT_DIR/install-cargo.sh"

log "Step 3/8 — Neovim via bob"
bash "$SCRIPT_DIR/install-nvim.sh"

log "Step 4/8 — asdf + language runtimes"
bash "$SCRIPT_DIR/install-asdf.sh"

log "Step 5/8 — Language tools"
bash "$SCRIPT_DIR/install-tools.sh"

log "Step 6/8 — Fonts"
bash "$SCRIPT_DIR/install-fonts.sh"

log "Step 7/8 — Dotfiles symlinks"
bash "$SCRIPT_DIR/link-dotfiles.sh"

log "Step 8/8 — zk notebooks"
bash "$SCRIPT_DIR/setup-zk.sh"

echo ""
success "Bootstrap complete!"
echo ""
warn "Remaining manual steps:"
echo "  1. Set fish as default shell:"
echo "     echo \$(which fish) | sudo tee -a /etc/shells"
echo "     chsh -s \$(which fish)"
echo "  2. Generate SSH keys if not done:"
echo "     ssh-keygen -t ed25519 -C 'rinez-personal' -f ~/.ssh/id_ed25519_personal"
echo "     ssh-keygen -t ed25519 -C 'rinez-work' -f ~/.ssh/id_ed25519_work"
echo "  3. Add public keys to GitHub accounts"
echo "  4. Update dotfiles remote to SSH:"
echo "     cd $DOTFILES_DIR && git remote set-url origin git@github-personal:$GITHUB_USER/$DOTFILES_REPO"
echo "  5. Install awscli2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
echo "  6. Install google-cloud-sdk: https://cloud.google.com/sdk/docs/install"
echo "  7. Restart terminal"
