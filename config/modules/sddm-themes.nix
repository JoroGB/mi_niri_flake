{ config, pkgs, lib, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    theme = "sugar-dark";
    package = pkgs.kdePackages.sddm;
    # wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Qt6 dependencies
    qt6.qtsvg
    qt6.qtdeclarative
    
    # Tema
    sddm-sugar-dark
  ];
}
