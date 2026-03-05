-- lua/plugins/lsp.lua o similar
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      nil_ls = {
        settings = {
          ["nil"] = {
            formatting = {
              command = { "alejandra" }, -- o { "nixpkgs-fmt" }, o nil para desactivar
            },
          },
        },
      },
    },
  },
}
