{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "nord";
      simplified_ui = true; # este ajuste muestra los atajos en el el button bar
      default_layout = "compact";
      default_shell = "nu";
    };
  };

  home.file."zellij/config.kdl".source = ./config_files/zellij/config.kdl;
  # Layout compacto con barra inferior únicamente
  xdg.configFile."zellij/layouts/compact.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }

      tab name="dev" {
        pane split_direction="horizontal" {
          pane size="50%"
            pane size="50%"
        }
      }

      tab name="nvim" focus=true {
        pane
      }
      tab name="logs" {
        pane
      }





    }
  '';

  # Layout minimalista ultra-compacto
  xdg.configFile."zellij/layouts/minimal.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }

      tab name="work" focus=true {
        pane split_direction="vertical" {
          pane size="65%"
          pane size="35%"
        }
      }
    }
  '';

  # xdg.configFile.".config/zellij.config.kdl".force = true;
}
