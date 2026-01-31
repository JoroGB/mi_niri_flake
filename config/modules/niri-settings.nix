# Configuración de Niri
{config, pkgs, ...}:{

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

  environment.sessionVariables = {
    # Wayland general
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };


  environment.systemPackages = with pkgs; [

    # Wayland utils
    wayland-utils
    xwayland-satellite
    xkeyboard_config
    xorg.xkbcomp


  ];


}
