return {
  "rickhowe/wrapwidth",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text" },
      callback = function()
        vim.cmd("Wrapwidth 120")
      end,
    })

    vim.g.wrapwidth_hl = "Comment"
    vim.g.wrapwidth_sign = "┊"
    vim.g.wrapwidth_number = true
  end,
}
