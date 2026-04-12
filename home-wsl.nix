{ config, pkgs, lib, ... }:

{
  imports = [ ./home.nix ];

  # ── Clipboard ──────────────────────────────────────────────────────────────
  # WSL2 bridges clipboard to Windows — no wl-clipboard needed.
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

  # ── Fonts ──────────────────────────────────────────────────────────────────
  # Windows manages fonts — disable fontconfig on WSL2.
  fonts.fontconfig.enable = lib.mkForce false;

  # ── No Alacritty on WSL2 ───────────────────────────────────────────────────
  # Windows Terminal is the emulator — no alacritty config needed.
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
  };
}
