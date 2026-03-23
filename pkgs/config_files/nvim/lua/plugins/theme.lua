return {
  -- 1. Instalar el plugin de Tokyo Dark
  {
    "tiagovla/tokyodark.nvim",
    priority = 1000, -- Muy importante: asegura que el tema cargue antes que lo demás
    opts = {
      -- Aquí puedes personalizarlo (descomenta lo que quieras):
      transparent_background = true, -- Fondo transparente
      custom_highlights = function(highlights, palette)
        -- Línea del cursor
        highlights.CursorLine = { bg = "#001003" }
        highlights.CursorLineNr = { fg = "#00cf41", bold = true }

        -- Barra de arriba (tabline)
        highlights.TabLine = { bg = "#002502", fg = "#4a8f4a" }
        highlights.TabLineSel = { bg = "#004503", fg = "#00ff41", bold = true }
        highlights.TabLineFill = { bg = "#001a01" }

        -- Barra de abajo (statusline)
        highlights.StatusLine = { bg = "#002502", fg = "#00ff41" }
        highlights.StatusLineNC = { bg = "#001a01", fg = "#4a8f4a" }

        -- Color del cursor
        highlights.Cursor = { fg = "#001003", bg = "#00ff41" }
        highlights.CursorIM = { fg = "#001003", bg = "#00c832" }

        return highlights
      end,
      -- gamma = 1.00,                 -- Ajustar brillo
      --
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- Carga la configuración
      vim.cmd([[colorscheme tokyodark]]) -- Activa el tema
    end,
  },

  -- 2. Asegurar que LazyVim sepa que este es el tema por defecto
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyodark",
    },
  },
}
