{pkgs, ...}: {
  systemd.user.services.obsidian-sync = {
    description = "Obsidian vault auto-commit";
    script = ''
      cd /home/joronix/Obsidian_Vault  # cambia la ruta
      ${pkgs.git}/bin/git add -A
      ${pkgs.git}/bin/git diff --cached --quiet || \
        ${pkgs.git}/bin/git commit -m "sync: $(${pkgs.coreutils}/bin/date +%Y-%m-%d\ %H:%M)"
        ${pkgs.git}/bin/git push origin main
    '';
    serviceConfig = {
      Type = "oneshot";
      Environment = "HOME=/home/joronix";
    };
  };

  systemd.user.timers.obsidian-sync = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
