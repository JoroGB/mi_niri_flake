{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "nord";
      simplified_ui = true;
      default_layout = "compact";
    };
  };

  # Layout compacto con barra inferior únicamente
  xdg.configFile."zellij/layouts/compact.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }

      tab name="main" focus=true {
        pane split_direction="vertical" {
          pane size="70%"
          pane split_direction="horizontal" {
            pane size="50%"
            pane size="50%"
          }
        }
      }

      tab name="dev" {
        pane split_direction="vertical" {
          pane size="60%"
          pane size="40%" split_direction="horizontal" {
            pane size="50%"
            pane size="50%"
          }
        }
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
