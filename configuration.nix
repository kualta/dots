{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix <home-manager/nixos> ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (fetchTarball
          "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
      };
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [ noto-fonts-cjk-sans noto-fonts-cjk-serif ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  environment.interactiveShellInit = ''
    alias gs='git status';
    alias gp='git push';
    alias ga='git add .';
    alias nx='sudo nixos-rebuild switch';
    alias nxe='sudo nvim /etc/nixos/configuration.nix';
    alias hpe='sudo nvim /etc/nixos/config/hyprland.conf';
  '';

  environment.systemPackages = with pkgs; [
    unstable.bun
    wget
    ibus
    htop
    kitty
    biome
    steam
    nodejs
    nixfmt
    neovim
    openssl
    killall
    blueman
    firefox
    vesktop
    obsidian
    google-chrome
    onlyoffice-bin
    wireguard-tools
    telegram-desktop
    ibus-with-plugins
    ibus-engines.libpinyin

    gnomeExtensions.zen
    gnomeExtensions.paperwm
    gnomeExtensions.kimpanel
    gnomeExtensions.appindicator
    gnomeExtensions.ibus-tweaker
    gnomeExtensions.just-perfection
  ];

  environment.variables = { EDITOR = "vim"; };

  programs.neovim = {
    vimAlias = true;
    configure = {
      customRC = ''
        imap jk <Esc>
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ vim-lastplace vim-nix ];
        opt = [ ];
      };
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.prime = {
    sync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      cheese
      gedit
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
    ]);

  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };

    firewall.checkReversePath = "loose";
    firewall.enable = true;
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 51820 59815 ];
    };

    hostName = "kult";
  };
  users.users.ku = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.ku = { config, pkgs, ... }: {
    programs.bash = { enable = true; };

    home.packages = with pkgs; [
      tofi
      swaylock-fancy
      swaynotificationcenter
      swaybg
      slurp
    ];
    home.homeDirectory = "/home/ku";

    nixpkgs.config.allowUnfree = true;
    programs.git = {
      enable = true;
      userName = "kualta";
      userEmail = "contact@kualta.dev";
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Pink-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "pink" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "macchiato";
        };
      };
    };
    
    xdg.configFile = {
      "gtk-4.0/assets".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };

    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    home.stateVersion = "23.11";
  };

  security.sudo.enable = true;
  security.sudo.extraRules = [{
    users = [ "ku" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  system.userActivationScripts.script.text = ''
    #!/bin/bash

    # Copy the desktop config files, replacing if it exists
    cp -rf /etc/nixos/config/* ~/.config/

    echo "updated desktop configs"
  '';

  system.stateVersion = "23.11";
}

