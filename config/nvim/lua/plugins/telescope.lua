local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

local notify_present, _ = pcall(require, "notify")
if notify_present then
  telescope.load_extension "notify"
end

-- local trouble = require("trouble.providers.telescope")

telescope.setup({
  defaults = {
    sorting_strategy = "ascending", -- display results top->bottom
    layout_config = {
      -- vertical = { width = 0.5 },
      prompt_position = 'top',
      -- center = {
      --   anchor = 'N'
      -- }
    },
    prompt_prefix = " > ",
    selection_caret = " ",
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      hidden = true
    },
    live_grep = {
      -- theme = 'cursor'
    },
    lsp_references = {
      -- theme = 'cursor'
    },
    diagnostics = {
      -- theme = "ivy",
    },
    current_buffer_fuzzy_find = {
      -- theme = 'dropdown'
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_ivy {},
    }
  },
  mappings = {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-c>"] = actions.close,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,
      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,
      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.complete_tag,
    },
    n = {
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,
      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,
      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,
      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
    },
  },
})

-- telescope.load_extension("toggletasks")
-- telescope.load_extension("fzf")
telescope.load_extension("lazygit")
telescope.load_extension("ui-select")
telescope.load_extension "file_browser"
