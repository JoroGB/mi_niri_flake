# {
#     programs.nixvim = {
#         enable = true;
#
#         colorschemes.catppuccin = {
#             enable = true;
#             settings = {
#                 flavour = "mocha";
#             }
#         }
#     }
# }
{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = [
    ];

  };

  home.packages = with pkgs; [
    lua-language-server
    nil
    pyright
    tree-sitter

    ripgrep
    fd
    lazygit
  ];
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
