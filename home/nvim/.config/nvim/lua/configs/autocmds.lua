vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

vim.cmd([[let &scrolloff=999-&scrolloff]])
-- vim.cmd([[let &colorcolumn="80,100,".join(range(120,999),",")]])

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("LastPlace", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
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
