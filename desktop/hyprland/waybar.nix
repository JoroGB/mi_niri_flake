{ ... }: {

  programs.waybar = {
     enable = true;
     systemd.enable = true;
     settings = [{
       layer = "top";
       position = "top";
       height = 30;

       modules-left = [ "hyprland/workspaces" "hyprland/window" ];
       modules-center = [ "clock" ];
       modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

       "hyprland/workspaces" = {
         format = "{name}";
         on-click = "activate";
       };

       clock = {
         format = "{:%H:%M}";
         format-alt = "{:%Y-%m-%d}";
       };


       network = {
         format-wifi = " {signalStrength}%";
         format-ethernet = " Connected";
         format-disconnected = "⚠ Disconnected";
       };

       pulseaudio = {
         format = "{icon} {volume}%";
         format-muted = " Muted";
         format-icons = {
           default = [ "" "" "" ];
         };
       };
     }];

     style = ''
       * {
         font-family: "JetBrains Mono", monospace;
         font-size: 13px;
         min-height: 0;
       }

       window#waybar {
         background: rgba(30, 30, 46, 0.9);
         color: #cdd6f4;
       }

       #workspaces button {
         padding: 0 10px;
         color: #cdd6f4;
         background: transparent;
         border: none;
       }

       #workspaces button.active {
         background: rgba(137, 180, 250, 0.3);
       }

       #clock, #cpu, #memory, #network, #pulseaudio, #tray {
         padding: 0 10px;
         margin: 0 5px;
       }
     '';
   };

}
