return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost" },
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      -- pre_hook = function(ctx)
      --   local U = require("Comment.utils")

      --   local location = nil
      --   if ctx.ctype == U.ctype.block then
      --     location = require("ts_context_commentstring.utils").get_cursor_location()
      --   else
      --     location = require("ts_context_commentstring.utils").get_visual_start_location()
      --   end

      --   return require("ts_context_commentstring.internal").calculate_commentstring {
      --     key = ctx.ctype == U.ctype.line and '__default' or "__multiline",
      --     location = location,
      --   }
      -- end,
      post_hook = nil,
    })
  end,
}
