{inputs, ...}: {
  imports = [inputs.qylock.nixosModules.default];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; # estás en Niri/Wayland

  programs.qylock = {
    enable = true;
    theme = "field";
    sddm.enable = true;
    quickshell.enable = true;
  };
}
