{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ]; # auto-generated during install

  # ── Boot ───────────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Networking ─────────────────────────────────────────────────────────────
  networking.hostName              = "gaia";
  networking.networkmanager.enable = true;

  # ── Locale & timezone ──────────────────────────────────────────────────────
  time.timeZone      = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  # ── Display: GNOME + GDM + Wayland ─────────────────────────────────────────
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable  = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  # ── Audio: PipeWire ────────────────────────────────────────────────────────
  hardware.pulseaudio.enable = false; # conflicts with PipeWire
  security.rtkit.enable      = true;  # real-time scheduling for PipeWire
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # ── Laptop power management ────────────────────────────────────────────────
  # power-profiles-daemon integrates with GNOME power settings UI.
  # Do not enable TLP or auto-cpufreq alongside this — they conflict.
  services.power-profiles-daemon.enable = true;
  powerManagement.enable                = true;

  # Firmware updates (fwupdmgr)
  services.fwupd.enable = true;

  # ── Bluetooth ──────────────────────────────────────────────────────────────
  hardware.bluetooth.enable      = true;
  hardware.bluetooth.powerOnBoot = true;

  # ── Swap ───────────────────────────────────────────────────────────────────
  # 2GB swapfile as a safety net — not needed with 32GB RAM but cheap insurance.
  # Lives inside the root partition, no dedicated swap partition required.
  swapDevices = [{
    device = "/var/lib/swapfile";
    size   = 2048;
  }];

  # ── Shell ──────────────────────────────────────────────────────────────────
  # Registers fish as a valid login shell in /etc/shells.
  # Required even though home-manager also enables fish.
  programs.fish.enable = true;

  # ── User ───────────────────────────────────────────────────────────────────
  users.users.rinez = {
    isNormalUser = true;
    shell        = pkgs.fish;
    extraGroups  = [ "wheel" "networkmanager" ];
  };

  # ── System packages ────────────────────────────────────────────────────────
  # Keep minimal — user packages live in home.nix.
  environment.systemPackages = with pkgs; [
    vim   # fallback editor for root sessions before home-manager is active
    git   # needed by nixos-rebuild --flake
    curl
  ];

  # ── Nix settings ───────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store   = true;
  };

  # Weekly garbage collection — keeps the store from growing unbounded
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  # ── State version ──────────────────────────────────────────────────────────
  # Set to the NixOS release you install with. Do not change after that.
  system.stateVersion = "25.11";
}
