{
  config,
  pkgs,
  ...
}:
# ← Agregar inputs aquí
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia-settings.nix
    ./modules/portals-conf.nix
    ./modules/sddm-themes.nix
    ./modules/portals-conf.nix
    ./modules/postgres-conf.nix
    ./modules/mongodb-conf.nix
    ./modules/virt-conf.nix
  ];
  services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";
  networking = {
    firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager.enable = true;
    hostName = "nixos";

    # wireless = {
    #
    #   enable = false;
    #   networks = {
    #   DOMA = {
    #   ssid = "DOMA";
    #   pskRaw = "8ac2623ddfaabbe16e42dbb624a803fd9fcd36dd510b7dacc126758cf9cc4c92";
    #   };
    #   };
    # };
  };
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Módulo del kernel para cámara virtual de OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Cargar el módulo al inicio
  boot.kernelModules = ["v4l2loopback"];

  # Configuración del módulo v4l2loopback
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  programs.niri = {
    enable = true;
  };

  # Habilitar Wayland y sesión de login
  # Si hay problemas con aplicaciones con xserver
  # Revisar si se esta ejecutando alguana instancia si no, es problema de variable de entorno
  # pgrep -a Xwayland // este comando revisa si hay instancias de xwayland
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

  # Necesario para display manager  / Screen Lock
  # services.displayManager.sddm = {
  #   enable = true;
  #   package = pkgs.kdePackages.sddm;
  # };
  # environment.etc."sddm.conf.d/theme.conf".text = ''
  #   [Theme]
  #   Current=sugar-dark
  #   CursorTheme=Bibata-Modern-Classic
  #   CursorSize=24
  # '';

  # Servicios necesarios

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

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  programs = {
    kdeconnect.enable = true;
    xwayland.enable = true;
    firefox.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
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
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # (callPackage ./pear_desktop.nix {})
    pear-desktop
    openssl
    openssl.dev
    gcc
    vim
    wget
    git
    curl
    nodejs
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
    localsend
    vlc
    mpv
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

    # Cursores
    bibata-cursors

    # tool niri
    fuzzel # Launcher para Niri
    rofi # Launcher con más features

    # apps
    discord-ptb
    warp-terminal
    pomodoro
    brave
    google-chrome
    vivaldi
    vscode
    postgresql_17_jit
    jetbrains-toolbox
    # zed-editor
    playerctl
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05"; # pkgs version
}
