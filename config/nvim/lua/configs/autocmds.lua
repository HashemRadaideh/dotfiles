-- vim.cmd([[let &scrolloff=999-&scrolloff]])
-- vim.cmd([[let &colorcolumn="80,100,".join(range(120,999),",")]])
-- vim.cmd([[autocmd BufRead,BufNewFile * setlocal signcolumn=yes:2]])
-- vim.cmd([[highlight CursorColumn guibg=#ff0000]])

-- vim.cmd([[
--   let g:transparency = 0
--   function Transparency()
--     if !exists("g:neovide")
--       if !g:transparency
--         hi Normal guibg=none ctermbg=none
--         hi NormalNC guibg=none ctermbg=none
--         hi StatusLineNC guibg=none ctermbg=none
--         hi LineNr guibg=none ctermbg=none
--         hi Folded guibg=none ctermbg=none
--         hi NonText guibg=none ctermbg=none
--         hi SpecialKey guibg=none ctermbg=none
--         hi VertSplit guibg=none ctermbg=none
--         hi SignColumn guibg=none ctermbg=none
--         hi EndOfBuffer guibg=none ctermbg=none
--         hi BqfPreviewFloat guibg=none ctermbg=none
--         hi BqfPreviewBorder guibg=none ctermbg=none
--         hi BqfPreviewTitle guibg=none ctermbg=none
--         hi BqfPreviewThumb guibg=none ctermbg=none
--         hi BqfPreviewSbar guibg=none ctermbg=none
--         hi BqfPreviewCursor guibg=none ctermbg=none
--         hi BqfPreviewCursorLine guibg=none ctermbg=none
--         hi BqfPreviewRange guibg=none ctermbg=none
--         hi BqfPreviewBufLabel guibg=none ctermbg=none
--         hi BqfSign guibg=none ctermbg=none
--         " hi CursorColumn guibg=none ctermbg=none
--         " hi CursorLine guibg=none ctermbg=none
--         let g:transparency = 1
--       else
--         execute 'colorscheme ' . g:colors_name
--         let g:transparency = 0
--       endif
--     endif
--   endfunction
--   nnoremap <silent> <F10> :call Transparency()<CR>
--   " au VimEnter * call Transparency()
-- ]])

-- vim.api.nvim_create_autocmd("FocusLost", {
--   group = vim.api.nvim_create_augroup("FocusAway", { clear = true }),
--   pattern = { "*" },
--   callback = function()
--     vim.cmd(":wa")
--   end,
-- })

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

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.cmd([[
--     autocmd BufReadPost *
--     \ if line("'\"") > 0 && line("'\"") <= line("$") |
--     \   exe "normal! g`\"" |
--     \ endif
-- ]])

-- vim.cmd([[
--   augroup kitty_mp
--     au!
--     au VimLeave * :silent !kitty @ set-spacing padding=20 margin=10
--     au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0
--   augroup END
-- ]])

-- vim.cmd [[
--   augroup config_change
--     autocmd!
--     autocmd BufWritePost *.lua source <afile> | PackerCompile
--   augroup end
-- ]]

-- vim.cmd [[
--   augroup plugin_change
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

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

-- -- https://vi.stackexchange.com/questions/24898/autocmd-with-a-python-file-not-working
-- vim.cmd([[
--   augroup vimrc_python
--     au!
--     au FileType python nnoremap <buffer> <F10> :w <bar> !python3 %<CR>
--   augroup END
-- ]])

-- --  Auto start Codi
-- --  to get file type, use :set ft?
-- vim.cmd([[
--   augroup codi_autostart
--     au!
--     au FileType python,lua,javascript,typescript nnoremap <buffer> <F9> :Codi<CR>
--   augroup END
-- ]])
