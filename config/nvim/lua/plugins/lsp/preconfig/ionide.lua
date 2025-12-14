return {
  "ionide/Ionide-vim",
  ft = "fsharp",
  config = function()
    -- https://www.reddit.com/r/neovim/comments/17c11qq/comment/k9ftnu9/

    local config = require("plugins.lsp.config")

    require("ionide").setup({
      capabilities = config.capabilities,
      flags = config.flags,
      handlers = config.handlers,
      on_attach = config.on_attach,
    })

    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.fs,*.fsx,*.fsi",
      command = [[set filetype=fsharp]],
    })
  end,
}
