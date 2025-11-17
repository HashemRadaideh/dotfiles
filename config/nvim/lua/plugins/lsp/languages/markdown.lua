local config = require("plugins.lsp.config")

vim.lsp.config("marksman", config)
vim.lsp.enable("marksman")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.md" },
  group = vim.api.nvim_create_augroup("MarkdownTOC", { clear = true }),
  callback = function()
    if vim.api.nvim_buf_line_count(0) == 0 then
      return
    end

    local has_doctoc = vim.fn.search([[START doctoc generated TOC]], "n") > 0

    if not has_doctoc and vim.fn.getline(1):match("^#%s+") then
      -- local lines = vim.fn.readfile(filepath)
      -- local buf = vim.api.nvim_get_current_buf()
      -- local view = vim.fn.winsaveview()

      -- vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      -- vim.fn.winrestview(view)

      -- vim.api.nvim_buf_set_option(buf, "modified", false)

      local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
      local new_lines = {
        lines[1],
        "",
        "<!--toc:start-->",
        "<!-- START doctoc generated TOC please keep comment here to allow auto update -->",
        "<!-- START doctoc generated TOC please keep comment here to allow auto update -->",
        "",
        "",
        "",
        "<!-- END doctoc generated TOC please keep comment here to allow auto update -->",
        "<!--toc:end-->",
      }

      vim.api.nvim_buf_set_lines(0, 0, 1, false, new_lines)
    end

    require("conform").format({ formatters = { "doctoc" } })
  end,
})
