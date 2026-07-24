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
    ./modules/user_service.nix
    ./modules/pihole-conf.nix
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "pnpm-10.29.2"
  ];

  fileSystems."/home/joronix/Files" = {
    device = "/dev/disk/by-uuid/38d7f0b9-4a1b-4ce9-b869-4dd755c830e7";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/00dd8b94-737e-4e4e-ba45-eba827433d27";
    }
  ];

  boot.kernel.sysctl."vm.swappiness" = 10;

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.uinput.enable = true;
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true; # configuration.nix o módulo equivalente
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 53;
  };

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
  networking = {
    firewall = rec {
      allowedTCPPorts = [3333 3444 80 433];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = ["127.0.0.1"];
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

  # Habilitar Wayland y sesión de login
  # Si hay problemas con aplicaciones con xserver
  # Revisar si se esta ejecutando alguana instancia si no, es problema de variable de entorno
  # pgrep -a Xwayland // este comando revisa si hay instancias de xwayland
  services = {
    xserver = {
      enable = true;
    };

    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      # enable = true;
    };
  };
  services = {
    udisks2 = {
      enable = true;
    };
  };
  services = {
    caddy = {
      enable = false;
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

  age.secrets.anki-password = {
    file = ../secrets/anki-password.age;
    owner = "anki-sync-server";
    mode = "0400";
  };
  services.anki-sync-server = {
    enable = true;
    address = "0.0.0.0";
    openFirewall = true;
    users = [
      {
        username = "joro";
        passwordFile = config.age.secrets.anki-password.path;
      }
    ];
  };

  # services.caddy.virtualHosts."jorodeck.duckdns.org".extraConfig = ''
  #   reverse_proxy ${config.services.anki-sync-server.address}:${builtins.toString config.services.anki-sync-server.port}
  # '';
  #
  programs = {
    kdeconnect.enable = true;
    xwayland.enable = true;
    firefox.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [glibc];
      };
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
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
    ];
  };
  environment.sessionVariables = {
    # GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # (callPackage ./pear_desktop.nix {})
    pear-desktop
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
    qt6.qtdeclarative
    rnote
    bottom
    guvcview
    anki
    zennotes-desktop
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
    warp-terminal
    pomodoro
    scrcpy
    android-tools
    brave
    google-chrome
    vivaldi
    vscode
    postgresql_17_jit
    jetbrains-toolbox
    # zed-editor
    playerctl

    #cam
    ffmpeg
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05"; # pkgs version
}
