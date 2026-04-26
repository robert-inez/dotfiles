#!/usr/bin/env bash
# install-packages.sh — system packages via apt (Ubuntu/WSL2), zypper (Tumbleweed), or dnf (Fedora)
set -euo pipefail
GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}  ->${NC} $1"; }
success() { echo -e "${GREEN}  ✓${NC} $1"; }
OS="${OS:-$(. /etc/os-release && echo $ID)}"

# ── Package lists ─────────────────────────────────────────────────────────────
APT_PACKAGES=(
  git curl wget unzip make
  build-essential gcc pkg-config
  libclang-dev
  libssl-dev zlib1g-dev libbz2-dev
  libreadline-dev libsqlite3-dev
  libncursesw5-dev xz-utils tk-dev
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  python3 python3-pip python3-venv
  fish tmux
  ripgrep fd-find fzf
  jq direnv htop fontconfig
  podman
  gh
  alacritty
  gimp inkscape
  firefox
)

ZYPPER_PACKAGES=(
  git curl wget unzip make
  gcc pkg-config
  llvm-devel libclang13
  python3 python3-pip python3-venv
  fish tmux
  ripgrep fd fzf
  jq direnv htop fontconfig
  podman
  gh
  alacritty
  gimp inkscape
  firefox
)

DNF_PACKAGES=(
  git curl wget unzip make
  gcc pkg-config
  clang-devel
  python3 python3-pip
  fish tmux
  ripgrep fd-find fzf
  jq direnv htop fontconfig
  podman
  gh
  alacritty
  gimp inkscape
  firefox
)

# ── Install functions ─────────────────────────────────────────────────────────
install_ubuntu() {
  log "Updating apt..."
  sudo apt update -qq
  log "Installing packages..."
  sudo apt install -y "${APT_PACKAGES[@]}"

  if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
    log "Created fd symlink for fdfind"
  fi

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
  sudo zypper refresh -y
  log "Updating system..."
  sudo zypper update -y
  log "Installing packages..."
  sudo zypper install -y "${ZYPPER_PACKAGES[@]}"

  if [ -n "${WAYLAND_DISPLAY:-}" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
    sudo zypper install -y wl-clipboard
    log "Installed wl-clipboard (Wayland)"
  else
    sudo zypper install -y xclip
    log "Installed xclip (X11)"
  fi

  log "Enabling Packman repository..."
  sudo zypper addrepo -cfp 90 \
    https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ \
    packman 2>/dev/null || log "Packman repo already enabled"
  sudo zypper refresh -y
  sudo zypper dist-upgrade --from packman --allow-vendor-change -y 2>/dev/null || true

  success "Packages installed"
}

install_fedora() {
  log "Updating dnf..."
  sudo dnf upgrade -y --refresh

  log "Installing packages..."
  sudo dnf install -y "${DNF_PACKAGES[@]}"

  if command -v fd-find &>/dev/null && ! command -v fd &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf "$(which fd-find)" ~/.local/bin/fd
    log "Created fd symlink for fd-find"
  fi

  if [ -n "${WAYLAND_DISPLAY:-}" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
    sudo dnf install -y wl-clipboard
    log "Installed wl-clipboard (Wayland)"
  else
    sudo dnf install -y xclip
    log "Installed xclip (X11)"
  fi

  log "Enabling RPM Fusion repositories..."
  sudo dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
    2>/dev/null || log "RPM Fusion repos already enabled"

  success "Packages installed"
}

# ── Dispatch ──────────────────────────────────────────────────────────────────
case "$OS" in
  ubuntu|debian)                 install_ubuntu ;;
  opensuse-tumbleweed|opensuse*) install_tumbleweed ;;
  fedora)                        install_fedora ;;
  *) echo "Unsupported OS: $OS — supported: ubuntu, opensuse-tumbleweed, fedora"; exit 1 ;;
esac
