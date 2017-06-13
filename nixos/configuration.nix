# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/74e809e2-7861-4cf1-a1ee-2ebfd715216a";
        preLVM = true;
        allowDiscards = true;
      }
    ];
  };

  networking = {
    hostName = "Monoid";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget
     zsh
     firefox
     termite
     vim
     pavucontrol
     tmux
     git
     gcc
     autoconf
     gnumake
     binutils
     automake
     nix
     emacs
     haskellPackages.xmobar
   ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "gb";
      xkbOptions = "compose:menu";
      displayManager.slim = {
        enable = true;
        defaultUser = "chris";
      };
      windowManager = {
        default = "xmonad";
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
    };
  };

  users.extraUsers.chris = {
    isNormalUser = true;
    description = "NextHendrix";
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    createHome = true;
    shell = "/run/current-system/sw/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
