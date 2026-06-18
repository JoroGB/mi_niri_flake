{pkgs, ...}: {
  # systemd.user.services.niri-cgroup-cleanup = {
  #   Unit.Description = "Clean stale niri cgroup directories";
  #   Service.Type = "oneshot";
  #   Service.ExecStart = "${pkgs.bash}/bin/bash -c '
  #     find /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/ \
  #       -maxdepth 1 -type d -empty -name 'app-niri-*' \
  #       -exec rmdir {} + 2>/dev/null || true
  #   '";
  # };
  #
  # systemd.user.timers.niri-cgroup-cleanup = {
  #   Unit.Description = "Periodic cleanup of stale niri cgroups";
  #   Timer.OnCalendar = "minutely";
  #   Timer.Persistent = true;
  #   Install.WantedBy = ["timers.target"];
  # };
}
