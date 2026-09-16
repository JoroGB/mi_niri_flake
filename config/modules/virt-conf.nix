{pkgs, ...}: {
  config = {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    users.users.joronix.extraGroups = ["libvirtd" "kvm"];
    programs.virt-manager.enable = true;
    environment.systemPackages = [
      pkgs.gnome-boxes
    ];
  };
}
