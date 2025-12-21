return {
  -- 1. Instalar el plugin de Tokyo Dark
  {
    "tiagovla/tokyodark.nvim",
    priority = 1000, -- Muy importante: asegura que el tema cargue antes que lo demás
    opts = {
      -- Aquí puedes personalizarlo (descomenta lo que quieras):
      -- transparent_background = true, -- Fondo transparente
      -- gamma = 1.00,                 -- Ajustar brillo
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
