{ config, pkgs, ... }:

let
  # Absolute path to this repo — required by mkOutOfStoreSymlink.
  # Update this if you clone the repo to a different location.
  dotfiles = "${config.home.homeDirectory}/projects/git/dotfiles";
in
{
  home.username    = "rinez";
  home.homeDirectory = "/home/rinez";

  # Don't change after initial setup — tracks home-manager state.
  home.stateVersion = "24.11";

  # ── Packages ───────────────────────────────────────────────────────────────
  # fish, tmux, git, and delta are installed by their programs.* modules below.
  home.packages = with pkgs; [
    # Shell utilities
    eza
    fzf
    starship

    # Search & navigation
    ripgrep
    fd

    # Editor
    neovim

    # Dev tools
    gcc
    gnumake
    unzip
    gh
    gum

    # HTTP / API
    xh               # curl-compatible, friendlier syntax
    fx               # interactive JSON explorer

    # Database clients
    pgcli            # Postgres
    litecli          # SQLite
    usql             # universal fallback

    # Cloud
    awscli2
    google-cloud-sdk
    podman

    # Terminal UX
    bat              # cat with syntax highlighting
    zoxide           # frecency-based cd

    # Notes / zettelkasten
    zk               # CLI-first note manager with neovim LSP

    # Utilities
    jq
    wl-clipboard
    curl
    wget

    # Fonts
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];

  # ── Environment ────────────────────────────────────────────────────────────
  # Declared here so all programs see them, not just fish.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  # ── Git ────────────────────────────────────────────────────────────────────
  programs.git = {
    enable    = true;
    userName  = "rinez";
    userEmail = "rinez_71@proton.me";
    delta = {
      enable  = true;
      options = {
        navigate     = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
    extraConfig = {
      merge.conflictstyle = "diff3";
      diff.colorMoved     = "default";
      pull.rebase         = true;
      init.defaultBranch  = "main";
    };
  };

  # ── SSH ────────────────────────────────────────────────────────────────────
  # Hosts used by fish/functions/wt-init.fish and wt-add.fish.
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github-work" = {
        hostname     = "github.com";
        user         = "git";
        identityFile = "~/.ssh/id_ed25519_work";
      };
      "github-personal" = {
        hostname     = "github.com";
        user         = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
    };
  };

  # ── Direnv ─────────────────────────────────────────────────────────────────
  # nix-direnv caches nix shells so they don't rebuild on every cd.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ── Fish ───────────────────────────────────────────────────────────────────
  # programs.fish manages ~/.config/fish/config.fish — the file in the repo
  # (fish/config.fish) is no longer active. Functions, plugins, and work conf.d
  # are still sourced from the repo via xdg.configFile below.
  programs.fish = {
    enable = true;
    shellAliases = {
      ls       = "eza -la --icons";
      gs       = "git status";
      pbcopy   = "wl-copy";
      t        = "tmux";
      ta       = "t a -t";
      tls      = "t ls";
      tn       = "t new-session -s";
      killnvim = "pkill -f nvim";
    };
    interactiveShellInit = ''
      set fish_greeting ""
      starship init fish | source
      direnv hook fish | source
      zoxide init fish | source
    '';
  };

  # ── Tmux ───────────────────────────────────────────────────────────────────
  # Replaces TPM — plugins are nix-managed, no `prefix + I` step on a new machine.
  # tmux-ukiyo (a catppuccin wrapper) replaced by tmuxPlugins.catppuccin directly.
  programs.tmux = {
    enable       = true;
    shortcut     = "a";        # sets prefix to C-a
    baseIndex    = 1;
    mouse        = true;
    historyLimit = 10001;
    keyMode      = "vi";
    terminal     = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin      = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin      = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin      = catppuccin;
        extraConfig = "set -g @catppuccin_flavor 'mocha'";
      }
    ];

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Vim-style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf

      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Alt-arrow pane switching (no prefix)
      bind -n M-Left  select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up    select-pane -U
      bind -n M-Down  select-pane -D

      # Shift-arrow window switching
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift-Alt vim keys for window switching
      bind -n M-H previous-window
      bind -n M-L next-window

      # Pane resizing
      bind -r j resize-pane -D 6
      bind -r k resize-pane -U 6
      bind -r l resize-pane -R 6
      bind -r h resize-pane -L 6

      # Copy mode
      bind-key -T copy-mode-vi v   send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y   send-keys -X copy-selection-and-cancel

      # Splits (maintain current path)
      bind '\' split-window -h -c "#{pane_current_path}"
      bind '-'  split-window -v -c "#{pane_current_path}"
    '';
  };

  # ── Fonts ──────────────────────────────────────────────────────────────────
  fonts.fontconfig.enable = true;

  # ── Config symlinks ────────────────────────────────────────────────────────
  # fish and tmux are managed by programs.* above — no symlinks needed for those.
  # nvim and alacritty are symlinked from the live repo so edits are immediate.
  # Fish subdirectories (functions, plugins, work conf.d) are linked individually.
  #
  # Before first `home-manager switch` on a new machine, remove any pre-existing
  # config directories to avoid conflicts:
  #   rm -rf ~/.config/nvim ~/.config/alacritty
  xdg.configFile = {
    "nvim".source      = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
    "alacritty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/alacritty";

    # Custom fish functions (worktree helpers, ghpr, pom, etc.)
    "fish/functions".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/functions";

    # Fisher plugin list — run `fisher update` on first fish launch to install themes
    "fish/fish_plugins".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/fish_plugins";

    # Work-specific reviewer handles used by ghpr.fish
    "fish/conf.d/reviewers.fish".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/conf.d/reviewers.fish";
  };

  programs.home-manager.enable = true;
}
