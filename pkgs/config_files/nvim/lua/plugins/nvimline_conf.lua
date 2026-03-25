-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local p = require("tokyodark.palette")
      return {
        options = {
          theme = {
            -- Modo normal — verdes oscuros tuyos
            normal = {
              a = { bg = p.green, fg = "#001003", gui = "bold" },
              b = { bg = "#001200", fg = p.green },
              c = { bg = "#001200", fg = "#4a8f4a" },
            },
            -- Modo insert — colores originales de tokyodark
            insert = {
              a = { bg = p.blue, fg = p.bg1, gui = "bold" },
              b = { bg = "#001200", fg = p.blue },
              c = { bg = "#001200", fg = "#4a8f4a" },
            },
            -- Modo visual — colores originales de tokyodark
            visual = {
              a = { bg = p.purple, fg = p.bg1, gui = "bold" },
              b = { bg = "#001200", fg = p.purple },
              c = { bg = "#001200", fg = "#4a8f4a" },
            },
            replace = {
              a = { bg = p.red, fg = p.bg1, gui = "bold" },
              b = { bg = "#001200", fg = p.red },
              c = { bg = "#001200", fg = "#4a8f4a" },
            },
            command = {
              a = { bg = p.yellow, fg = p.bg1, gui = "bold" },
              b = { bg = "#001200", fg = p.yellow },
              c = { bg = "#001200", fg = "#4a8f4a" },
            },
            inactive = {
              a = { bg = "#001200", fg = "#2a5f2a" },
              b = { bg = "#001200", fg = "#2a5f2a" },
              c = { bg = "#001200", fg = "#2a5f2a" },
            },
          },
        },
      }
    end,
  },
}
