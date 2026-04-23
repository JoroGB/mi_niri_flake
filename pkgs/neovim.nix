{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
    withRuby = true;
    withPython3 = true;

    extraPackages = [
    ];
  };
  home.packages = with pkgs; [
    #nix
    alejandra
    nil
    #other
    lua-language-server
    pyright
    tree-sitter
    ripgrep
    fd
    lazygit
  ];

  # agregado por error con con miniapp
  xdg.configFile."nvim/init.lua".force = false;

  # home.file = {
  #   ".config/nvim" = {
  #     source = ./pkgs/config_files/nvim;
  #     recursive = true;
  #   };
  # };

  # ruta de configuracion de nvim
  # home.file.".config/nvim" = {
  #
  # ruta donde home-manager configurara los archivos de configuracion de nvim
  # o mejor dicho de donde va a agarrar los archivos y remplazara en la ruta de configuracion
  # de nvim
  # source = ./nvim;
  # recursive = true;
  # };
}
