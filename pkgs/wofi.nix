{ ... }:

{
  # Configure wofi settings using an attribute set
  programs.wofi.settings = {
    # General settings
    prompt = "Run Application:";
    width = "30%";
    height = "50%";
    normal-window = true;
    sort-mode = "alpha"; # Sort applications alphabetically

    # Dmenu mode specific options (example)
    dmenu-parse_action = true;
  };

  # Define CSS style inline
  programs.wofi.style = ''
    window {
      margin: 5px;
      background-color: #2e3440; /* Example color */
      opacity: 0.9;
      font-size: 14px;
      font-family: sans-serif;
      border-radius: 10px;
      border: 2px solid #a3acdf; /* Example border color */
    }
    input {
      background-color: #3b4252;
      color: #eceff4;
    }
    #entry:selected {
      background-color: #88c0d0;
      color: #2e3440;
    }
  '';

  # Alternatively, link an external CSS file managed by Home Manager
  # programs.wofi.style = builtins.readFile ./wofi/style.css;

  # You can also set a custom package if needed (optional)
  # programs.wofi.package = pkgs.wofi;
}
