{
  config,
  pkgs,
  ...
}: # ← Agregar inputs aquí
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia-settings.nix
  ];

  networking = {
    # networkmanager.enable = true;
    hostName = "nixos";

    wireless = {

      enable = false;
      networks = {
      DOMA = {
      ssid = "DOMA";
      pskRaw = "8ac2623ddfaabbe16e42dbb624a803fd9fcd36dd510b7dacc126758cf9cc4c92";
      };
      };
    };
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
  boot.kernelModules = [ "v4l2loopback" ];

  # Configuración del módulo v4l2loopback
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  programs.niri = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome # Para Niri
      xdg-desktop-portal-gtk # Fallback
    ];

    config = {

      niri = {
        default = [
          "gnome"
          "gtk"
        ];
      };
    };

    wlr.enable = false;
  };


  

  # Habilitar Wayland y sesión de login
  services = {
    xserver = {
      enable = true;
    };

    udisks2 = {
      enable = true;
    };
  };

  # Necesario para display manager  / Screen Lock
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
  };
  environment.etc."sddm.conf.d/theme.conf".text = ''
    [Theme]
    Current=sugar-dark
    CursorTheme=Bibata-Modern-Classic
    CursorSize=24
  '';



  # Servicios necesarios
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    # Wayland general
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

      # Cursores
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  services.flatpak.enable = true;

  users.users.joronix = {
    password = "fungy2005"; # CAMBIAR ESTO - no pongas passwords en plain text
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
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    (callPackage ./pear_desktop.nix { })
    sddm-sugar-dark

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

    # Terminal
    kitty
    alacritty

    # Wayland utils
    wayland-utils
    xwayland-satellite
    xkeyboard_config
    xorg.xkbcomp


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
    (writeShellScriptBin "brave-safe" ''
      ${brave}/bin/brave \
        --disable-gpu \
        --disable-gpu-compositing \
        --disable-software-rasterizer \
        "$@"
    '')

  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05"; # pkgs version
}
