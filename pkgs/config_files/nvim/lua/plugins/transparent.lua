-- ~/.config/nvim/lua/plugins/transparent.lua
return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = {
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeWinSeparator",
        "NormalFloat",
        "FloatBorder",
      },
    },
    config = function(_, opts)
      require("transparent").setup(opts)
      -- Limpia todos los highlights de neotree automáticamente
      require("transparent").clear_prefix("NeoTree")
    end,
  },
}
