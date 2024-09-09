{ config, pkgs, lib, ... }:

let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ unstable.zed-editor ];
    runScript = "zed";
  };
in {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    <catppuccin/modules/nixos>
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (fetchTarball
          "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
            config.allowUnfree = true;
          };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    unstable.bun
    unstable.osu-lazer-bin
    wget
    ibus
    htop
    wine
    unzip
    kitty
    biome
    steam
    cargo
    rustup
    nodejs
    neovim
    lutris
    zed-fhs
    xonotic
    openssl
    blanket
    killall
    blueman
    firefox
    vesktop
    python3
    shotcut
    obsidian
    minetest
    monaspace
    musescore
    wf-recorder
    pop-launcher
    google-chrome
    nixfmt-classic
    onlyoffice-bin
    wireguard-tools
    telegram-desktop
    ibus-with-plugins
    libsForQt5.kdenlive
    ibus-engines.libpinyin

    gnome.gnome-tweaks
    gnomeExtensions.zen
    gnomeExtensions.super-key
    gnomeExtensions.pop-shell
    gnomeExtensions.kimpanel
    gnomeExtensions.appindicator
    gnomeExtensions.ibus-tweaker
    gnomeExtensions.just-perfection
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "Monaspace" "GeistMono" ];
    })

  ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  time.timeZone = lib.mkForce null; # allow TZ to be set by desktop user

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = { enable = true; };
  services.printing.enable = true;
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  environment.interactiveShellInit = ''
    alias ga='git add .';
    alias gp='git push';
    alias gs='git status';
    alias nx='sudo nixos-rebuild switch';
    alias nxe='sudo nvim /etc/nixos/configuration.nix';
    alias hpe='sudo nvim /etc/nixos/config/hypr/hyprland.conf';

    alias bnuuy='bun i'
    alias lgtm='function _lgtm(){ git add . && git commit -m "$1" && git push; }; _lgtm'

  '';

  environment.variables = { EDITOR = "zed"; };

  programs.neovim = {
    vimAlias = true;
    configure = {
      customRC = ''
        inoremap jk <Esc>
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ vim-lastplace vim-nix ];
        opt = [ ];
      };
    };
  };

  programs.steam.enable = true;

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
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;

    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.58.02";
      sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
      openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      persistencedSha256 =
        "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
    };
    #package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  system.autoUpgrade = {
    enable = true;
    flags = [ "--update-input" "nixpkgs" "-L" ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
    firewall.enable = true;

    hostName = "kult";
  };

  users.users.ku = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.users.ku = { config, pkgs, ... }: {
    imports = [ <catppuccin/modules/home-manager> ];
    programs.bash = { enable = true; };
    programs.starship = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        add_newline = false;
        format =
          "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
        shlvl = {
          disabled = false;
          symbol = "";
          style = "bright-red bold";
        };
        shell = {
          disabled = false;
          format = "$indicator";
          fish_indicator = "";
          bash_indicator = "(bright-white) ";
          zsh_indicator = "(bright-white) ";
        };
        username = {
          style_user = "bright-white bold";
          style_root = "bright-red bold";
        };

      };

    };

    catppuccin.flavor = "mocha";

    home.packages = with pkgs; [
      tofi
      swaylock-fancy
      swaynotificationcenter
      swaybg
      slurp
      grim
    ];

    gtk = {
      enable = true;

      theme = {
        name = "Rosé Pine";
        package = pkgs.rose-pine-gtk-theme;
      };

      cursorTheme = {
        name = "breeze_cursors";
        package = pkgs.numix-cursor-theme;
      };
    };

    home.homeDirectory = "/home/ku";

    nixpkgs.config.allowUnfree = true;
    programs.git = {
      enable = true;
      userName = "kualta";
      userEmail = "contact@kualta.dev";
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
      settings = {
        "org/gnome/desktop/datetime" = { automatic-timezone = true; };
        "org/gnome/system/location" = { enabled = true; };
        "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" "<Alt>F4" ];
          minimize = [ "<Super>comma" ];
          toggle-maximized = [ "<Super>m" ];
          move-to-monitor-left = [ ];
          move-to-monitor-right = [ ];
          move-to-monitor-up = [ ];
          move-to-monitor-down = [ ];
          move-to-workspace-down = [ ];
          move-to-workspace-up = [ ];
          switch-to-workspace-down = [ "<Primary><Super>Down" ];
          switch-to-workspace-up = [ "<Primary><Super>Up" ];
          switch-to-workspace-left = [ ];
          switch-to-workspace-right = [ ];
          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          move-to-workspace-6 = [ "<Shift><Super>6" ];
          move-to-workspace-7 = [ "<Shift><Super>7" ];
          move-to-workspace-8 = [ "<Shift><Super>8" ];
          move-to-workspace-9 = [ "<Shift><Super>9" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];
          maximize = [ ];
          unmaximize = [ ];
        };
        "org/gnome/mutter" = { dynamic-workspaces = false; };
        "org/gnome/desktop/wm/preferences" = { num-workspaces = 9; };

        "org/gnome/shell/keybindings" = {
          open-application-menu = [ ];
          toggle-message-tray = [ "<Super>n" ];
          toggle-overview = [ ];
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ ];
          toggle-tiled-right = [ ];
        };

        "org/gnome/mutter/wayland/keybindings" = { restore-shortcuts = [ ]; };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          screensaver = [ "<Super>Escape <Super>." ];
          home = [ "<Super>e" ];
          www = [ "<Super>b" ];
          rotate-video-lock-static = [ ];
        };

        "org/gnome/shell/extensions/pop-shell" = {
          toggle-tiling = [ "<Super>y" ];
          toggle-floating = [ "<Super>g" ];
          tile-enter = [ "<Super>t" ];
          tile-accept = [ "Return" ];
          tile-reject = [ "Escape" ];
          toggle-stacking-global = [ "<Super>s" ];
          pop-workspace-down = [ "<Shift><Super>Down" "<Shift><Super>j" ];
          pop-workspace-up = [ "<Shift><Super>Up" "<Shift><Super>k" ];
          pop-monitor-left = [ "<Shift><Super>Left" "<Shift><Super>h" ];
          pop-monitor-right = [ "<Shift><Super>Right" "<Shift><Super>l" ];
          pop-monitor-down = [ ];
          pop-monitor-up = [ ];
          focus-left = [ "<Super>Left" "<Super>h" ];
          focus-down = [ "<Super>Down" "<Super>j" ];
          focus-up = [ "<Super>Up" "<Super>k" ];
          focus-right = [ "<Super>Right" "<Super>l" ];
        };
      };
    };

    home.stateVersion = "24.05";
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

  system.stateVersion = "24.05";
}
