{pkgs, ...}: let
  custom_theme = "hyprland_kath";
in {
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = [
      (pkgs.sddm-astronaut.override {embeddedTheme = custom_theme;})
    ];
    # wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Qt6 dependencies
    qt6.qtsvg
    qt6.qtdeclarative

    # Tema
    sddm-sugar-dark
    kdePackages.qtmultimedia # ← también aquí
    (sddm-astronaut.override {embeddedTheme = custom_theme;})
  ];
}
