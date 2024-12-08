return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      { noremap = true, silent = true, desc = "Open all folds" },
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      { noremap = true, silent = true, desc = "Close all folds" },
    },
    {
      "zK",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      { noremap = true, silent = true, desc = "Peek Fold" },
    },
  },
}
