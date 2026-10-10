{inputs, ...}: {
  imports = [inputs.qylock.nixosModules.default];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; # estás en Niri/Wayland
  services.displayManager.sddm.settings = {
    Theme.PrimaryScreen = "DP-2"; # el nombre de tu output central
  };
  programs.qylock = {
    enable = true;
    theme = "field";
    sddm.enable = true;
    quickshell.enable = true;
  };
}
