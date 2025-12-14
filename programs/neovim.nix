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
    package = pkgs.neovim-unwrapped;
    extraPackages = [
      pkgs.bash-language-server
      pkgs.clippy
      pkgs.goimports-reviser
      pkgs.golines
      pkgs.gopls
      pkgs.gosimports
      pkgs.htmx-lsp
      pkgs.lua-language-server
      pkgs.luaformatter
      pkgs.marksman
      pkgs.nil
      pkgs.nixfmt-rfc-style
      pkgs.nodePackages.dockerfile-language-server-nodejs
      pkgs.nodePackages.typescript-language-server
      pkgs.nodePackages.vscode-langservers-extracted
      # pkgs.nodePackages.vscode-html-languageserver-bin
      # pkgs.nodePackages.vscode-json-languageserver-bin
      pkgs.prettierd
      pkgs.pyright
      pkgs.rust-analyzer
      pkgs.rustfmt
      pkgs.svelte-language-server
      pkgs.tailwindcss-language-server
      pkgs.templ
      pkgs.terraform-ls
      pkgs.vim-language-server
      pkgs.yaml-language-server
    ];
  };

  plugins = with pkgs.vimPlugins; [
    # Treesitter precompilado con parsers
    (nvim-treesitter.withPlugins (p: [
      p.rust
      p.lua
      p.vim
      p.toml
      p.nix
    ]))
  ];
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
  home.file.".config/nvim" = {
    #
    # ruta donde home-manager configurara los archivos de configuracion de nvim
    # o mejor dicho de donde va a agarrar los archivos y remplazara en la ruta de configuracion
    # de nvim
    source = ./nvim;
    recursive = true;
  };

}
