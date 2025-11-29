{ config, lib, pkgs, inputs, ... }:  # ← Agregar inputs aquí
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NVIDIA drivers para Wayland
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # ← AGREGA ESTOS PAQUETES:
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  boot.kernelParams = [
     "nvidia-drm.modeset=1"
     "nvidia-drm.fbdev=1"

   ];
  # Configuración de Niri
  programs.niri = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  # Habilitar Wayland y sesión de login
  services.xserver = {
    enable = true;
  };
  services.udisks2 ={
    enable = true;
  };

  # Necesario para display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };


  # XDG Portals para ambos compositores
   # xdg.portal = {
   #   enable = true;
   #   extraPortals = with pkgs; [
   #    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland # Para Hyprland
   #     xdg-desktop-portal-gnome     # Para Niri
   #     xdg-desktop-portal-gtk       # Fallback
   #   ];
   #   config = {
   #     # Configuración para Hyprland
   #     hyprland = {
   #       default = [ "hyprland" "gtk" ];
   #       "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
   #       "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
   #     };
   #     # Configuración para Niri
   #     niri = {
   #       default = [ "gnome" "gtk" ];
   #       "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
   #       "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
   #     };
   #     # Fallback común
   #     common = {
   #       default = [ "gtk" ];
   #     };
   #   };
   # };

   # xdg.portal = {
   #   enable = true;

   #   extraPortals = with pkgs; [
   #     inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
   #     xdg-desktop-portal-gtk  # Para apps GTK
   #   ];

   #   config = {
   #     common = {
   #       default = [ "gtk" ];
   #     };
   #     hyprland = {
   #       default = [ "hyprland" "gtk" ];
   #     };
   #   };

   #   # Deshabilitar portales problemáticos
   #   wlr.enable = false;
   #   xdgOpenUsePortal = false;
   # };

    # Servicios necesarios
    services.dbus.enable = true;
    services.gnome.gnome-keyring.enable = true;
    # security.polkit.enable = true;



  # Variables de entorno para NVIDIA + Wayland
  environment.sessionVariables = {
    # Wayland general
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    # NVIDIA específico
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";

    # Para reducir problemas con video
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";

    # Cursores
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];




  services.flatpak.enable = true;

  users.users.joronix = {
    password = "fungy2005";  #  CAMBIAR ESTO - no pongas passwords en plain text
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      tree
      nushell
      neovim
      zellij
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

  programs.firefox.enable = true;
  programs.xwayland.enable = true;

  # Terminal para Wayland en lugar de gnome-terminal
  # Kitty ya está en environment.systemPackages y funciona con Wayland

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    (callPackage ./pear_desktop.nix{})
    gcc
    vim
    wget
    git
    curl
    nodejs
    unzip
    lldb
    nixos-shell
    direnv
    cron
    python3

    # Terminal
    kitty
    alacritty

    # Clipboard
    xclip
    wl-clipboard

    # Wayland utils
    wayland-utils
    xwayland-satellite
    xkeyboard_config
    xorg.xkbcomp

    # Cursores
    bibata-cursors

    # tool niri
    fuzzel      # Launcher para Niri
    mako        # Notificaciones

    # tool hp
    hyprpaper    # Wallpapers
    hyprlock     # Lockscreen
    hypridle     # Idle management
    hyprpicker   # Color picker
    wofi         # Launcher alternativo
    rofi          # Launcher con más features
    waybar       # Status bar
    dunst        # Notificaciones alternativas
    swaylock     # Lockscreen alternativo
    swayidle     # Idle alternativo
    grim         # Screenshots
    slurp        # Screen area selector

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
    zed-editor
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

  system.stateVersion = "25.05";  # pkgs version
}
