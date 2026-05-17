{pkgs, ...}: {
  systemd.user.services.obsidian-sync = {
    description = "Obsidian vault auto-commit";
    script = ''
      cd /home/joronix/Obsidian_Vault
      ${pkgs.git}/bin/git add -A
      ${pkgs.git}/bin/git diff --cached --quiet || \
        ${pkgs.git}/bin/git commit -m "sync: $(${pkgs.coreutils}/bin/date +%Y-%m-%d\ %H:%M)"
        ${pkgs.git}/bin/git push origin main
        ${pkgs.libnotify}/bin/notify-send "Obsidian" "Obsidan has been  pushed in Git Hub"
    '';
    serviceConfig = {
      Type = "oneshot";
      Environment = ["HOME=/home/joronix" "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"];
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
