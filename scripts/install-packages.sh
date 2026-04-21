#!/usr/bin/env bash
# install-packages.sh — system packages via apt (Ubuntu/WSL2) or zypper (Tumbleweed)
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }

OS="${OS:-$(. /etc/os-release && echo $ID)}"

# ── Package lists ─────────────────────────────────────────────────────────────

APT_PACKAGES=(
  # essentials
  git curl wget unzip make
  build-essential gcc pkg-config
  # needed for cargo crates using bindgen
  libclang-dev
  # Python build deps — asdf compiles Python from source on Ubuntu if needed
  libssl-dev zlib1g-dev libbz2-dev
  libreadline-dev libsqlite3-dev
  libncursesw5-dev xz-utils tk-dev
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  # Python
  python3 python3-pip python3-venv
  # shell
  fish tmux
  # search and navigation
  ripgrep fd-find fzf
  # utilities
  jq direnv htop fontconfig
  # container
  podman
  # github cli
  gh
)

ZYPPER_PACKAGES=(
  # essentials
  git curl wget unzip make
  gcc pkg-config
  # needed for cargo crates using bindgen
  llvm-devel libclang13
  # Python — Tumbleweed ships recent Python, no asdf needed
  python3 python3-pip python3-virtualenv python313-pipx
  # shell
  fish tmux
  # search and navigation
  ripgrep fd fzf
  # utilities
  jq direnv htop fontconfig
  # container
  podman
  # github cli
  gh
)

# ── Install functions ─────────────────────────────────────────────────────────

install_ubuntu() {
  log "Updating apt..."
  sudo apt update -qq

  log "Installing packages..."
  sudo apt install -y "${APT_PACKAGES[@]}"

  # fd-find installs as fdfind on Ubuntu — create symlink
  if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
    log "Created fd symlink for fdfind"
  fi

  # clipboard — xclip for WSL2/X11, wl-clipboard for Wayland
  if [ -n "${WAYLAND_DISPLAY:-}" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
    sudo apt install -y wl-clipboard
    log "Installed wl-clipboard (Wayland)"
  else
    sudo apt install -y xclip
    log "Installed xclip (X11/WSL2)"
  fi

  success "Packages installed"
}

install_tumbleweed() {
  log "Refreshing zypper repos..."
  sudo zypper refresh

  log "Updating system..."
  sudo zypper update

  log "Installing packages..."
  sudo zypper install "${ZYPPER_PACKAGES[@]}"

  # clipboard
  if [ -n "${WAYLAND_DISPLAY:-}" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
    sudo zypper install wl-clipboard
    log "Installed wl-clipboard (Wayland)"
  else
    sudo zypper install xclip
    log "Installed xclip (X11)"
  fi

  # Packman repo for multimedia codecs
  log "Enabling Packman repository..."
  sudo zypper addrepo -cfp 90 \
    https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ \
    packman 2>/dev/null || log "Packman repo already enabled"
  sudo zypper refresh
  sudo zypper dist-upgrade --from packman --allow-vendor-change 2>/dev/null || true

  success "Packages installed"
}

# ── Dispatch ──────────────────────────────────────────────────────────────────

case "$OS" in
  ubuntu|debian)               install_ubuntu ;;
  opensuse-tumbleweed|opensuse*) install_tumbleweed ;;
  *) echo "Unsupported OS: $OS — supported: ubuntu, opensuse-tumbleweed"; exit 1 ;;
esac
