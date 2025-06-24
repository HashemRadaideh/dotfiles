return {
  "rcarriga/nvim-notify",
  event = { "VimEnter" },
  opts = {
    background_colour = "#000000",
    render = "wrapped-compact",
    stages = "fade",
    top_down = true,
    timeout = 1000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.25)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  config = function()
    --   vim.notify = require("notify").setup({
    --     background_colour = "#000000",
    --     fps = 60,
    --     render = "wrapped-compact",
    --     stages = "fade",
    --     timeout = 1000,
    --     top_down = false
    --   })
    local original_notify = vim.notify
    vim.notify = function(msg, level, opts)
      -- Forward other messages to the original handler
      original_notify(msg, level, opts)
    end
  end,
}
