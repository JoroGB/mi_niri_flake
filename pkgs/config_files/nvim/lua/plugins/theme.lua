-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
-- Ejecutar esto despues de instalar
-- :TransparentEnable
