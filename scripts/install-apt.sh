#!/usr/bin/env bash
# install-apt.sh — system packages via apt (Ubuntu) or dnf (Fedora)
set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }

OS="${OS:-$(. /etc/os-release && echo $ID)}"

APT_PACKAGES=(
  # essentials
  git curl wget unzip make
  build-essential gcc pkg-config
  # needed for cargo crates using bindgen
  libclang-dev
  # Python build deps — asdf compiles Python from source on Ubuntu
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

DNF_PACKAGES=(
  # essentials
  git curl wget unzip make
  gcc pkg-config
  # needed for cargo crates using bindgen
  clang-devel
  # Python — Fedora ships recent Python, no need to compile via asdf
  python3 python3-pip
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

install_ubuntu() {
  log "Updating apt..."
  sudo apt update -qq

  log "Installing apt packages..."
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

  success "apt packages installed"
}

install_fedora() {
  log "Updating dnf..."
  sudo dnf update -y -q

  log "Installing dnf packages..."
  sudo dnf install -y "${DNF_PACKAGES[@]}"

  # Wayland clipboard
  sudo dnf install -y wl-clipboard

  # RPM Fusion
  log "Enabling RPM Fusion..."
  sudo dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
    2>/dev/null || log "RPM Fusion already enabled"

  success "dnf packages installed"
}

case "$OS" in
  ubuntu|debian) install_ubuntu ;;
  fedora)        install_fedora ;;
  *)             echo "Unsupported OS: $OS"; exit 1 ;;
esac
