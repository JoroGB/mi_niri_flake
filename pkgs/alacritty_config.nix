# home.nix or imported alacritty.nix
{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.90;
        padding = {
          x = 1;
          y = 0;
        };
        # decorations = "";
        dynamic_padding = true;
        dimensions = {
          columns = 0;
        };
      };
      font = {
        size = 11.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
      };

      colors = {
        primary = {
          background = "#1a1b26";
        };
      };
      keyboard = {

      };

    };
  };
}
