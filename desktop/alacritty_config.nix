{ pkgs, inputs, ... }:
{
programs.alacritty = {
  enable = true;
  settings = {
    window = {
      opacity = 0.9;
      padding = {
        x = 10;
        y = 10;
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
        foreground = "#c0caf5";
      };
    };
  };
};

}
