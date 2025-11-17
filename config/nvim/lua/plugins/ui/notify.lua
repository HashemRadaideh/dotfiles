return {
  "rcarriga/nvim-notify",
  event = { "VimEnter" },
  opts = {
    render = "wrapped-compact",
    stages = "fade",
    top_down = false,
    fps = 60,
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
}
