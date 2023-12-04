local ok, zenmode = pcall(require, "zen-mode")
if not ok then
  return
end

zenmode.setup({
  window = {
    backdrop = 0.95,
    width = 120,
    height = 1,
    options = {
      signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0",     -- disable fold column
      list = false,         -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,   -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true },
    shade = { enabled = false },
    gitsigns = { enabled = false },
    tmux = { enabled = false },
    kitty = {
      enabled = false,
      font = "+4",
    },
  },
  on_open = function()
    vim.cmd [[let g:loaded_shade = 1]]
  end,
  on_close = function()
    vim.cmd [[let g:loaded_shade = 0]]
  end,
})
