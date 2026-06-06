return {

  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = false,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      npairs.remove_rule('"')
      npairs.remove_rule("'")
      npairs.remove_rule("`")
    end,
  },
}
