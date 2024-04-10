return {
  "akinsho/bufferline.nvim",
  lazy = false,
  keys = {
    {
      -- '<C-,>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, })
      "<S-tab>",
      "<cmd>BufferLineCyclePrev<CR>",
      { noremap = true, silent = true },
    },
    {
      -- '<C-.>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, })
      "<tab>",
      "<cmd>BufferLineCycleNext<CR>",
      { noremap = true, silent = true },
    },
    {
      "<S-h>",
      "<cmd>BufferLineMovePrev<CR>",
      { noremap = true, silent = true },
    },
    {
      "<S-l>",
      "<cmd>BufferLineMoveNext<CR>",
      { noremap = true, silent = true },
    },
    {

      "<leader>bch",
      "<cmd>BufferLineCloseLeft<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>bcx",
      "<cmd>bd %<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>bcl",
      "<cmd>BufferLineCloseRight<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>be",
      "<cmd>BufferLineSortByExtension<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>bd",
      "<cmd>BufferLineSortByDirectory<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>bb",
      "<cmd>lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>",
      { noremap = true, silent = true },
    },
    { "<C-1>", "<cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true } },
    { "<C-2>", "<cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true } },
    { "<C-3>", "<cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true } },
    { "<C-4>", "<cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true } },
    { "<C-5>", "<cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true } },
    { "<C-6>", "<cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true } },
    { "<C-7>", "<cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true } },
    { "<C-8>", "<cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true } },
    { "<C-9>", "<cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true } },
  },
  config = function()
    local ok, bufferline = pcall(require, "bufferline")
    if not ok then
      return
    end

    bufferline.setup({
      options = {
        mode = "buffers",
        themable = true,
        numbers = "both", -- | "ordinal" | "buffer_id" |
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        -- diagnostics_indicator = function(_, _, diagnostics_dict)
        --   local ret = (diagnostics_dict.error and "" .. diagnostics_dict.error .. " " or "")(
        --     diagnostics_dict.warning and "" .. diagnostics_dict.warning or ""
        --   )
        --   return vim.trim(ret)
        -- end,
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
            return true
          end
          -- filter out by buffer name
          if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            return true
          end
          -- filter out based on arbitrary rules
          -- e.g. filter out vim wiki buffer from tabline in your work repo
          if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            return true
          end
          -- filter out by it's index number in list (don't show first buffer)
          if buf_numbers[1] ~= buf_number then
            return true
          end
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "Outline",
            text = "Symbols Outline",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "alpha",
            text = "Dashboard",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        -- show_buffer_default_icon = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", -- | "slant" | "thick" | "slope" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_at_end", -- |'insert_after_current' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      },
    })
  end,
}
