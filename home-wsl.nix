{ config, pkgs, lib, ... }:

{
  imports = [ ./home.nix ];

  # ── Extra WSL2 packages ────────────────────────────────────────────────────
  # wslu provides wslopen, wslview etc for opening Windows apps from terminal
  home.packages = lib.mkMerge [
    (import ./home.nix { inherit config pkgs lib; }).home.packages or []
    (with pkgs; [
      wslu
    ])
  ];

  # ── Clipboard ──────────────────────────────────────────────────────────────
  # WSL2 bridges clipboard to Windows — no wl-clipboard needed
  programs.fish.shellAliases = lib.mkForce {
    ls       = "eza -la --icons";
    gs       = "git status";
    pbcopy   = "clip.exe";
    pbpaste  = "powershell.exe -command 'Get-Clipboard'";
    t        = "tmux";
    ta       = "t a -t";
    tls      = "t ls";
    tn       = "t new-session -s";
    killnvim = "pkill -f nvim";
  };

  # ── No GNOME in WSL2 ───────────────────────────────────────────────────────
  # Disable dconf settings — no GNOME desktop
  dconf.settings = lib.mkForce {};

  # ── Fonts ──────────────────────────────────────────────────────────────────
  # Windows manages fonts — disable fontconfig on WSL2
  fonts.fontconfig.enable = lib.mkForce false;

  # ── Config symlinks ────────────────────────────────────────────────────────
  # No alacritty — Windows Terminal is the emulator
  # nvim, fish functions and plugins still symlinked from dotfiles
  xdg.configFile = lib.mkForce {
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/projects/git/dotfiles/nvim";

    "fish/functions".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/projects/git/dotfiles/fish/functions";

    "fish/fish_plugins".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/projects/git/dotfiles/fish/fish_plugins";

    "fish/conf.d/reviewers.fish".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/projects/git/dotfiles/fish/conf.d/reviewers.fish";

    "starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/projects/git/dotfiles/starship/starship.toml";
  };
}
