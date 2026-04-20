return {
  "ionide/Ionide-vim",
  ft = "fsharp",
  config = function()
    -- https://www.reddit.com/r/neovim/comments/17c11qq/comment/k9ftnu9/

    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.fs,*.fsx,*.fsi",
      command = [[set filetype=fsharp]],
    })
  end,
}
