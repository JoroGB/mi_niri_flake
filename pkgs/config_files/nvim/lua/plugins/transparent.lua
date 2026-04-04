-- ~/.config/nvim/lua/plugins/transparent.lua
return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "NeoTreeEndOfBuffer",
          "NeoTreeWinSeparator",
          "NormalFloat",
          "FloatBorder",
        },
        exclude_groups = {
          "NeoTreeCursorLine", -- excluye este del limpiado

          "LspReferenceText",
          "LspReferenceRead",
          "LspReferenceWrite",
          -- Por si Everforest los redefine con prefijo
          "IlluminatedWordText",
          "IlluminatedWordRead",
          "IlluminatedWordWrite",
        },
      })
      require("transparent").clear_prefix("NeoTree")
    end,
  },
}
