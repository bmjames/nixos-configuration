# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.checkJournalingFS = false;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "ef8a0bc1";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  environment.loginShellInit = "export PATH=$PATH:~/.cabal/bin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    emacs
    ack
    git
    vim
    wget

    # haskell stuff
    haskellPackages.alex
    haskellPackages.cabal2nix
    haskellPackages.cabalInstall
    haskellPackages.ghc
    haskellPackages.ghcMod
    haskellPackages.happy
    haskellPackages.hasktags
    haskellPackages.hlint
  ];

  programs.zsh.enable = true;

  # List services that you want to enable:

  services.virtualboxGuest.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ben = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

}
