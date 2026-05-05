return {
  "rickhowe/wrapwidth",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        local ft = vim.bo.filetype
        local exclude = { "Avante", "AvanteInput", "neo-tree", "NvimTree", "alpha", "dashboard" }
        if not vim.tbl_contains(exclude, ft) then
          vim.cmd("Wrapwidth " .. (vim.bo.textwidth > 0 and vim.bo.textwidth or 120))
        end
      end,
    })

    vim.g.wrapwidth_hl = "Conceal"
    -- vim.g.wrapwidth_sign = "┊"
  end,
}
