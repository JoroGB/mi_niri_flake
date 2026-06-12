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
          "NeoTreeCursorLine",
          "LspReferenceText",
          "LspReferenceRead",
          "LspReferenceWrite",
          "IlluminatedWordText",
          "IlluminatedWordRead",
          "IlluminatedWordWrite",

          -- DAP breakpoints
          "DapBreakpoint",
          "DapBreakpointCondition",
          "DapBreakpointRejected",
          "DapLogPoint",
          "DapStopped",
          "DapStoppedLine",

          -- signcolumn donde aparecen los íconos de breakpoint
          "SignColumn",
        },
      })
      require("transparent").clear_prefix("NeoTree")
    end,
  },
}
