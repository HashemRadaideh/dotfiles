local ok, alpha = pcall(require, "alpha")
if not ok then
  return
end

local _, _, path = string.find(debug.getinfo(1).short_src, "(.*nvim)")

local function get_greeting()
  local tableTime = os.date("*t")
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "  It's bedtime",
    [2] = "  Good morning",
    [3] = "  Good afternoon",
    [4] = "  Good evening",
    [5] = "望 Good night",
  }
  local greetingIndex = 0
  if (hour == 23 or hour < 7) then
    greetingIndex = 1
  elseif (hour < 12) then
    greetingIndex = 2
  elseif (hour >= 12 and hour < 18) then
    greetingIndex = 3
  elseif (hour >= 18 and hour < 21) then
    greetingIndex = 4
  elseif (hour >= 21) then
    greetingIndex = 5
  end
  return greetingsTable[greetingIndex] .. ", " .. os.getenv("USER") .. "."
end

local function get_info()
  ---@diagnostic disable-next-line: undefined-global
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  local datetime = os.date " %d-%m-%Y   %H:%M:%S"
  local platform = vim.fn.has "win32" == 1 and "" or ""
  return (" %d   v%d.%d.%d %s  %s"):format(plugins + 2, v.major, v.minor, v.patch, platform, datetime)
end

local function button(sc, txt, keybind, keybind_opts)
  local b = require "alpha.themes.dashboard".button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "Function"
  b.opts.hl_shortcut = "Number"
  b.opts.cursor = 26
  return b
end

alpha.setup({
  layout = {
    { type = "padding", val = 3 },
    {
      type = "text",
      val = {
        -- http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
        -- NScript
        [[                                                                            ]],
        [[                                                     gg                     ]],
        [[                                                     ""                     ]],
        [[  ,ggg,,ggg,    ,ggg,     ,ggggg,       ggg    gg    gg    ,ggg,,ggg,,ggg,  ]],
        [[ ,8" "8P" "8,  i8" "8i   dP"  "Y8ggg   d8"Yb   88bg  88   ,8" "8P" "8P" "8, ]],
        [[      8I   8I  I8, ,8I  i8"    ,8I    dP  I8   8I    88   I8   8I   8I   8I ]],
        [[      8I   Yb, `YbadP" ,d8,   ,d8"        I8, ,8I  _,88,_,dP   8I   8I   Yb,]],
        [[      8I   `Y8888P"Y888P"Y8888P"           "Y8P"   8P""Y88P"   8I   8I   `Y8]],
        [[                                                                            ]],
      },
      opts = {
        position = "center",
        hl = "Keyword",
      },
    },
    { type = "padding", val = 2 },
    {
      type = "text",
      ---@diagnostic disable-next-line: undefined-global
      val = get_greeting(),
      opts = {
        position = "center",
        hl = "String"
      },
    },
    {
      type = "text",
      val = get_info(),
      opts = {
        position = "center",
        hl = "String",
      },
    },
    { type = "padding", val = 2 },
    {
      type = "group",
      val = {
        button("SPC s s", "  Open session"),
        button("SPC s p", "  Scratch pad"),
        button("SPC i", "  Create new file"),
        button("SPC f f", "  Find file"),
        button("SPC f o", "  Recent files"),
        button("SPC f g", "  Find word"),
        button("SPC e", "  File browser"),
        button("x", "  Find repo", ":lua require('gfold').pick_repo()<CR>"),
        button("p", "  Sync/Update", ":PackerSync<CR>"),
        ---@diagnostic disable-next-line: undefined-global
        button("c", "  Config", (":cd %s | e init.lua <CR>"):format(path)),
        button("q", "  Quit", ":qa!<CR>"),
      },
      opts = {
        position = "center",
        spacing = 1,
      },
    },
    {
      type = "text",
      val = require "alpha.fortune" (),
      opts = {
        position = "center",
        hl = "Comment",
      },
    },
  },
  opts = {
    margin = 44,
  },
})

-- vim.api.nvim_create_augrsup("alpha_tabline", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--   group = "alpha_tabline",
--   pattern = "alpha",
--   command = "setlocal showtabline=0 laststatus=0 noruler nofoldenable",
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   group = "alpha_tabline",
--   pattern = "alpha",
--   callback = function()
--     vim.api.nvim_create_autocmd("BufUnload", {
--       group = "alpha_tabline",
--       buffer = 0,
--       command = "setlocal showtabline=2 laststatus=3 ruler nofoldenable",
--     })
--   end,
-- })
