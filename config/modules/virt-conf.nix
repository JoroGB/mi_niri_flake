{pkgs, ...}: {
  config = {
    virtualisation.libvirtd.enable = true;
    users.users.joronix.extraGroups = ["libvirtd" "kvm"];
    programs.virt-manager.enable = true;
    environment.systemPackages = [
      pkgs.gnome-boxes
    ];
  };
}
