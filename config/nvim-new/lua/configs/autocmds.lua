vim.cmd [[:command V vs .]]
vim.cmd [[:command H sp .]]

-- vim.cmd [[
--   augroup config_change
--     autocmd!
--     autocmd BufWritePost *.lua source <afile> | PackerCompile
--   augroup end
-- ]]

vim.cmd [[
  augroup plugin_change
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

vim.cmd [[
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
]]

vim.cmd [[autocmd BufRead,BufNewFile * setlocal signcolumn=yes:2]]

-- vim.cmd [[behave mswin]]

-- vim.cmd [[autocmd FileType help wincmd L]]

-- vim.cmd [[
--   au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
--   au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
-- ]]

-- vim.api.nvim_create_autocmd({
--   event = "BufEnter",
--   pattern = "*",
--   eval = "setlocal nomodifiable",
--   persistent = true,
-- })

-- vim.api.nvim_create_autocmd({
--   event = "VimEnter",
--   pattern = "*",
--   eval = "!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape",
-- })

-- vim.api.nvim_create_autocmd({
--   event = "VimLeave",
--   pattern = "*",
--   eval = "!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock",
-- })

-- https://vi.stackexchange.com/questions/24898/autocmd-with-a-python-file-not-working
vim.cmd [[
  augroup vimrc_python
    au!
    au FileType python nnoremap <buffer> <F10> :w <bar> !python3 %<CR>
  augroup END
]]

--  Auto start Codi
--  to get file type, use :set ft?
vim.cmd [[
  augroup codi_autostart
    au!
    au FileType python,lua,javascript,typescript nnoremap <buffer> <F9> :Codi<CR>
  augroup END
]]

vim.cmd [[
  augroup kitty_mp
    au!
    au VimLeave * :silent !kitty @ set-spacing padding=20 margin=10
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0
  augroup END
]]
