{...}: {
  programs.zellij = {
    enable = true;
    #
    # settings = {
    #   theme = "nord";
    #   simplified_ui = true; # este ajuste muestra los atajos en el el button bar
    #   default_layout = "compact";
    #   default_shell = "nu";
    # };
  };

  xdg.configFile."zellij/config.kdl" = {
    source = ./config_files/zellij/config.kdl;
    force = true;
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


      tab name="nvim" focus=true {
        pane
      }
      tab name="dev" {
        pane split_direction="horizontal" {
          pane size="33%"
          pane size="33%"
          pane size="33%"

        }
      }
      tab name="vimdev"  {
          pane split_direction="horizontal"{
              pane size="15%"
              pane size="70%"
              pane size="15%"
            }
        }

      tab name="main" {
        pane split_direction="vertical" {
          pane size="50%"
          pane split_direction="horizontal"{
            pane
            pane
          }
        }
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
