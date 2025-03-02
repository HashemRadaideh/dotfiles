return {
  "utilyre/barbecue.nvim",
  event = { "BufReadPost", "BufNewFile" },
  name = "barbecue",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_navic = false,
    create_autocmd = false,
  },
  config = function()
    vim.api.nvim_create_autocmd({
      "WinScrolled",
      "WinResized",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
