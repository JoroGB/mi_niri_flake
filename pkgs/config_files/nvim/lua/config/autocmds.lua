-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- ~/.config/nvim/lua/config/autocmds.lua
-- ~/.config/nvim/lua/config/autocmds.lua
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2d4a2d" })
      vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = "#72a65a", bold = true })
    end, 100) -- espera 100ms después de que transparent termine
  end,
})
