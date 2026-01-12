vim.cmd([[let &scrolloff=999-&scrolloff]])
-- vim.cmd([[let &colorcolumn="80,100,".join(range(120,999),",")]])

local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = { "*" },
  desc = "remember last cursor place",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.fn.system("xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'")
--   end,
-- })

-- vim.api.nvim_create_autocmd("VimLeave", {
--   callback = function()
--     vim.fn.system("xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'")
--   end,
-- })

-- --  Auto start Codi
-- --  to get file type, use :set ft?
-- vim.cmd([[
--   augroup codi_autostart
--     au!
--     au FileType python,lua,javascript,typescript nnoremap <buffer> <F9> :Codi<CR>
--   augroup END
-- ]])
