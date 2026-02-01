{pkgs, ...}:{
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
# :
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = [ pkgs.nautilus ];
  security.polkit.enable = true;

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.systemPackages = with pkgs; [
    # Para screenshots (usado por portal GNOME)
    grim
    slurp
    
    # Agente polkit (ya incluido en el servicio systemd)
    kdePackages.polkit-kde-agent-1
  ];

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
    "/share/icons"
  ];
}
