{
  config,
  pkgs,
  ...
}:
# ← Agregar inputs aquí
{
  imports = [
    ./hardware-configuration.nix
    ./modules/portals-conf.nix
    ./modules/sddm-themes.nix
    ./modules/portals-conf.nix
    ./modules/virt-conf.nix
    ./modules/user_service.nix
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "pnpm-10.29.2"
  ];




  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.uinput.enable = true;
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true; # configuration.nix o módulo equivalente

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 10;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;
 hardware.firmware = with pkgs; [ linux-firmware # firmware genérico (Intel iwlwifi, Realtek, Atheros)
    # broadcom-bt-firmware # descomenta si tienes WiFi Broadcom
  ];
  networking = {
    hostName = "mi-laptop";
    networkmanager.enable = true;

    firewall = rec {
      allowedTCPPorts = [3333 22 3444 80 433];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };

 

  };


  # Módulo del kernel para cámara virtual de OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Cargar el módulo al inicio
  boot.kernelModules = ["v4l2loopback" "ntsync" "uinput"];

  # Configuración del módulo v4l2loopback
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  programs.niri = {
    enable = true;
  };

  services = {
    xserver = {
      enable = true;
    };

  };
  services = {
    udisks2 = {
      enable = true;
    };
  };

  environment.sessionVariables = {
    # Wayland general
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    # Cursores
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  services.flatpak.enable = true;

  users.users.joronix = {
    hashedPassword = "$6$Bl8XVRoJbWMnNcEo$6P0diisPoz/OkrF3QOBpJ0oFOePhn8zF2qI0Nc/XS/kUKq2wSrEBp1nFDwFoHLolGYWM.COJTTbEfrgrAORT.0";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "video"
    ];
    shell = pkgs.nushell;

    packages = with pkgs; [
      tree
      nushell
      neovim
      zellij
      yazi
    ];
  };


  programs = {
    xwayland.enable = true;
    firefox.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        gcc
      ];
    };
};

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
    ];
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
    ];
  };
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs.config.allowUnfree = true;
services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    # (callPackage ./pear_desktop.nix {})
    pear-desktop
    gcc
    vim
    wget
    git
    curl
    unzip
    lldb
    vscode-extensions.vadimcn.vscode-lldb
    nixos-shell
    direnv
    cron
    glances
    python3
    pkg-config
    fastfetch
    vlc
    mpv
    qt6.qtdeclarative
    bottom
    guvcview
    anki
    zennotes-desktop
    posting
networkmanager
ethtool
    # Terminal
    kitty
    alacritty

    # Wayland utils
    wayland-utils
    xwayland-satellite
    xkeyboard_config
    xkbcomp

    # Clipboard
    xclip
    wl-clipboard
    wl-clip-persist
    cliphist

    # Cursores
    bibata-cursors

    # tool niri
    fuzzel # Launcher para Niri
    rofi # Launcher con más features

    # apps
    vesktop
    brave
    google-chrome
    vscode
    jetbrains-toolbox
    playerctl

  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05"; # pkgs version
}
