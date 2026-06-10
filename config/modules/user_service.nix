{pkgs, ...}: {
  systemd.user.services = {
    "obsidian-sync" = {
      description = "Obsidian vault auto-commit";
      script = ''
        export GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh"
        cd /home/joronix/Obsidian_Vault
        ${pkgs.git}/bin/git add -A
        if ! ${pkgs.git}/bin/git diff --cached --quiet; then
          ${pkgs.git}/bin/git commit -m "sync: $(date '+%Y-%m-%d %H:%M')"
          ${pkgs.git}/bin/git push
          ${pkgs.libnotify}/bin/notify-send "Obsidian" "Sync in GitHub"
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        Environment = [
          "HOME=/home/joronix"
          "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
          "SSH_AUTH_SOCK=%t/keyring/ssh"
        ];
      };
    };

    "shutdown-timer" = {
      description = "shutdown-pc in 2 hours time";
      script = ''
        TIMEINMINUTES=100;

        ${pkgs.libnotify}/bin/notify-send "Power off set"  "in ''${TIMEINMINUTES} minutes"
        ${pkgs.swayidle}/bin/swayidle -w timeout $TIMEINMINUTES systemctl poweroff;
      '';
    };
  };

  systemd.user.timers = {
    "obsidian-sync" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "*-*-* 16:00:00";
        Persistent = true;
      };
    };
  };
}
