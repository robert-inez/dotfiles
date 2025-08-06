{ config, pkgs, ... }:

{
  home.username = "rinez";
  home.homeDirectory = "/home/rinez";
  home.stateVersion = "25.05";

  # Install user-level packages
  home.packages = with pkgs; [
    git
    neovim
    fish
    htop
    curl
    wget
    bat
    ripgrep
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      gco = "git checkout";
    };
  };

  programs.git = {
    enable = true;
    userName = "Robert Inez";
    userEmail = "rinez_71@proton.me";
  };

  # Optional: Add nice tools
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;


}
