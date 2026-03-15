{pkgs, ...}: {
  config = {
    virtualisation.libvirtd.enable = true;
    users.users.joronix.extraGroups = ["libvirtd" "kvm"];
    environment.systemPackages = [
      pkgs.gnome-boxes
    ];
  };
}
