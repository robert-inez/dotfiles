{
  config,
  pkgs,
  ...
}: let
  # Absolute path to this repo — required by mkOutOfStoreSymlink.
  # Update this if you clone the repo to a different location.
  dotfiles = "${config.home.homeDirectory}/projects/git/dotfiles";
in {
  home.username = "rinez";
  home.homeDirectory = "/home/rinez";

  # Don't change after initial setup — tracks home-manager state.
  home.stateVersion = "25.11";

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

    # Dev tools
    alacritty
    gcc
    gnumake
    unzip
    gh
    gum
    yarn

    # HTTP / API
    xh # curl-compatible, friendlier syntax for local use
    jq # JSON shaping
    fx # interactive JSON explorer

    # Database clients
    pgcli # Postgres
    litecli # SQLite
    usql # universal fallback

    # Toolchains
    go
    nodejs

    # Git
    tig # terminal git browser

    # Cloud
    awscli2
    google-cloud-sdk
    podman

    # Terminal UX
    bat # cat with syntax highlighting
    zoxide # frecency-based cd

    # Clipboard — Wayland native
    wl-clipboard # provides wl-copy and wl-paste

    # Notes
    zk # CLI-first note manager with neovim LSP

    # Utilities
    curl
    wget
    tree-sitter

    # LSP
    typescript-language-server
    eslint
    vscode-langservers-extracted
    gopls
    lua-language-server
    nil # nix LSP

    # Formatters
    stylua
    prettierd
    gofumpt
    gotools
    golines
    ruff
    eslint_d
    tree-sitter
    alejandra # nix formatter

    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.javascript
      p.tsx
      p.markdown
      p.markdown_inline
      p.typescript
      p.fish
      p.json
      p.css
      p.html
      p.yaml
      p.vim
      p.go
      p.templ
    ]))

    # Fonts
    nerd-fonts.caskaydia-cove
  ];

  # ── Environment ────────────────────────────────────────────────────────────
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q" "<Alt>F4"];
    };
  };

  # ── Git ────────────────────────────────────────────────────────────────────
  programs.git = {
    enable = true;
    # renamed from userName/userEmail
    settings = {
      user = {
        name = "rinez";
        email = "rinez_71@proton.me";
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };

  # ── Delta ──────────────────────────────────────────────────────────────────
  # renamed from programs.git.delta
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
    };
  };

  # ── SSH ────────────────────────────────────────────────────────────────────
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github-work" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_work";
      };
      "github-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
    };
  };

  # ── Direnv ─────────────────────────────────────────────────────────────────
  # nix-direnv caches nix shells so they don't rebuild on every cd
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ── Fish ───────────────────────────────────────────────────────────────────
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -la --icons";
      gs = "git status";
      pbcopy = "wl-copy"; # Wayland clipboard
      pbpaste = "wl-paste"; # Wayland clipboard
      t = "tmux";
      ta = "t a -t";
      tls = "t ls";
      tn = "t new-session -s";
      killnvim = "pkill -f nvim";
    };
    interactiveShellInit = ''
      set fish_greeting ""
      starship init fish | source
      direnv hook fish | source
      zoxide init fish | source
    '';
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false; # add this
  };

  # ── Tmux ───────────────────────────────────────────────────────────────────
  # Replaces TPM — plugins are nix-managed, no `prefix + I` on a new machine.
  programs.tmux = {
    enable = true;
    shortcut = "a"; # prefix = C-a
    baseIndex = 1;
    mouse = true;
    historyLimit = 10001;
    keyMode = "vi";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = catppuccin;
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
  # nvim and alacritty symlinked from live repo — edits reflect immediately.
  # fish and tmux managed by programs.* above — no symlinks needed for those.
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
    "alacritty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/alacritty";

    # Custom fish functions
    "fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/functions";

    # Fisher plugin list
    "fish/fish_plugins".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/fish_plugins";

    # Work-specific reviewer handles
    "fish/conf.d/reviewers.fish".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish/conf.d/reviewers.fish";

    "starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/starship/starship.toml";
  };

  programs.home-manager.enable = true;
}
