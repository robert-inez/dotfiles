{ config, pkgs, ... }:
{
  imports = [ ./home.nix ];

  # Clipboard — WSL2 bridges to Windows
  programs.fish.shellAliases = {
    pbcopy  = "clip.exe";
    pbpaste = "powershell.exe -command 'Get-Clipboard'";
  };

  # No font management — Windows owns this
  fonts.fontconfig.enable = false;

  # No Alacritty — Windows Terminal is the emulator
  xdg.configFile = {
    "alacritty" = pkgs.lib.mkForce null;
  };
}
