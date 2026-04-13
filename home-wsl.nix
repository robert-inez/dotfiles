{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./home.nix];

  # ── Extra WSL2 packages ────────────────────────────────────────────────────
  home.packages = with pkgs; [wslu hyperfine];

  # ── No GNOME in WSL2 ───────────────────────────────────────────────────────
  dconf.settings = lib.mkForce {};

  # ── Fonts ──────────────────────────────────────────────────────────────────
  fonts.fontconfig.enable = lib.mkForce false;

  # ── Config files ───────────────────────────────────────────────────────────
  xdg.configFile = lib.mkForce {
    # Write fish config directly — system fish conflicts with programs.fish module
    "fish/config.fish".text = ''
      set fish_greeting ""
      source ~/.nix-profile/etc/profile.d/hm-session-vars.fish

      alias ls="eza -la --icons"
      alias gs="git status"
      alias pbcopy="clip.exe"
      alias pbpaste="powershell.exe -command 'Get-Clipboard'"
      alias t="tmux"
      alias ta="t a -t"
      alias tls="t ls"
      alias tn="t new-session -s"
      alias killnvim="pkill -f nvim"

      starship init fish | source
      direnv hook fish | source
      zoxide init fish | source
    '';

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
