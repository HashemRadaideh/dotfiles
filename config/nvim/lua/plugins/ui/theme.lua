---@diagnostic disable: redefined-local

vim.opt.guifont = "CaskaydiaCove Nerd Font:h10"
-- vim.opt.guifont = "FiraCode Nerd Font:h11"
-- vim.opt.guicursor = "a:blinkon0-blinkoff0"

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.cmd [[let &scrolloff=999-&scrolloff]]
vim.cmd [[let &colorcolumn="80,".join(range(120,999),",")]]

-- vim.cmd [[
--   if !exists("g:neovide")
--     au ColorScheme * hi Normal guibg=none ctermbg=none
--     au ColorScheme * hi LineNr guibg=none ctermbg=none
--     au ColorScheme * hi Folded guibg=none ctermbg=none
--     au ColorScheme * hi NonText guibg=none ctermbg=none
--     au ColorScheme * hi SpecialKey guibg=none ctermbg=none
--     au ColorScheme * hi VertSplit guibg=none ctermbg=none
--     au ColorScheme * hi SignColumn guibg=none ctermbg=none
--     au ColorScheme * hi EndOfBuffer guibg=none ctermbg=none
--   endif
-- ]]

vim.cmd [[
let g:transparency = 0
function Transparency()
  if !exists("g:neovide")
    if !g:transparency
      hi Normal guibg=none ctermbg=none
      hi LineNr guibg=none ctermbg=none
      hi Folded guibg=none ctermbg=none
      hi NonText guibg=none ctermbg=none
      hi SpecialKey guibg=none ctermbg=none
      hi VertSplit guibg=none ctermbg=none
      hi SignColumn guibg=none ctermbg=none
      hi EndOfBuffer guibg=none ctermbg=none
      let g:transparency = 1
    else
      execute 'colorscheme ' . g:colors_name
      let g:transparency = 0
    endif
  endif
endfunction
" au VimEnter * call Transparency()
nnoremap <silent> <F10> :call Transparency()<CR>
]]

local ok, github_theme = pcall(require, "github-theme")

if ok then
  github_theme.setup({
    hide_end_of_buffer = true,
    theme_style = "dark",
    comment_style = "none",
    keyword_style = "none",
    function_style = "none",
    variable_style = "none",
    sidebars = { "qf", "vista_kind", "terminal", "packer", "Neotree" },
    dark_float = true,
    dark_sidebar = true,
    colors = { hint = "orange", error = "#ff0000" },
    overrides = function(c)
      return {
        htmlTag = {
          fg = c.red,
          bg = "#282c34",
          sp = c.hint,
          style = "underline"
        },
        DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
        TSField = {},
      }
    end
  })
  return
end

local ok, onedark = pcall(require, "onedark")

if ok then
  onedark.setup {
    style = "dark",
    transparent = false,
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,

    toggle_style_key = "<leader>ts",
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
      "light"
    },

    code_style = {
      comments = "none",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none"
    },

    colors = {

    },

    highlights = {
      -- Comment = { fg = "#7c7c7c", },
      -- Identifier = { fg = "#ff00ff", },
    },

    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  }

  onedark.load()
  return
end

local ok, catppuccin = pcall(require, "catppuccin")

if ok then
  catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = false,
      mini = false,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  })

  -- setup must be called before loading
  vim.cmd.colorscheme "catppuccin"
  return
end

local ok, nightfox = pcall(require, "nightfox")

if ok then
  -- Default options
  nightfox.setup({
    options = {
      -- Compiled file"s destination location
      compile_path = vim.fn.stdpath("cache") .. "/nightfox",
      compile_file_suffix = "_compiled", -- Compiled file suffix
      transparent = false, -- Disable setting background
      terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = false, -- Non focused panes set to alternative background
      module_default = true, -- Default enable value for modules
      styles = {
        -- Style to be applied to different syntax groups
        comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "NONE",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
      inverse = {
        -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
      modules = { -- List of various plugins and additional options
        -- ...
      },
    },
    palettes = {},
    specs = {},
    groups = {},
  })

  -- setup must be called before loading
  vim.cmd [[colorscheme nightfox]]
  vim.cmd [[colorscheme dayfox]]
  vim.cmd [[colorscheme dawnfox]]
  vim.cmd [[colorscheme duskfox]]
  vim.cmd [[colorscheme nordfox]]
  vim.cmd [[colorscheme terafox]]
  vim.cmd [[colorscheme carbonfox]]
  return
end

local ok, _ = pcall(require, "wal")

if ok then
  vim.cmd [[colorscheme wal]]
end

local ok, _ = pcall(require, "gruvbox")

if ok then
  vim.cmd [[colorscheme gruvbox]]
end

local ok, _ = pcall(require, "tokyonight")

if ok then
  vim.cmd [[colorscheme tokyonight]]
  -- vim.cmd [[colorscheme tokyonight-night]]
  -- vim.cmd [[colorscheme tokyonight-storm]]
  -- vim.cmd [[colorscheme tokyonight-day]]
  -- vim.cmd [[colorscheme tokyonight-moon]]
end

local ok, _ = pcall(require, "edge")

if ok then
  vim.cmd [[colorscheme edge]]
  vim.g.edge_disable_italic_comment = 1
end

local ok, nord = pcall(require, "nord")

if ok then
  nord.set()

  vim.g.nord_contrast = false
  vim.g.nord_borders = false
  vim.g.nord_disable_background = false
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_enable_sidebar_background = false
  vim.g.nord_italic = false
end

local ok, ayu = pcall(require, "ayu")

if ok then
  local colors = require("ayu.colors")
  colors.generate() -- Pass `true` to enable mirage
  ayu.setup({
    mirage = true,
    overrides = function()
      if vim.o.background == "dark" then
        return {
          NormalNC = { bg = "#0f151e", fg = "#808080" },
          IncSearch = { fg = colors.fg }
        }
      else
        return {
          NormalNC = { bg = "#f0f0f0", fg = "#808080" },
          IncSearch = { fg = colors.fg }
        }
      end
    end
  })
  vim.cmd([[colorscheme ayu]])
end
