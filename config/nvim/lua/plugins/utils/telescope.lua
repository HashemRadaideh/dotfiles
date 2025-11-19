return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "kdheepak/lazygit.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    -- {
    --   "<leader>tt",
    --   '<cmd>lua require("telescope").extensions.lazygit.lazygit()<CR>',
    --   { noremap = true, silent = true },
    -- },
    {
      "<leader>tu",
      "<cmd>Telescope undo<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>.",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    {
      "<leader>/",
      '<cmd>lua require("telescope.builtin").live_grep()<cr>',
      desc = "Grep (root dir)",
    },
    { "<leader>?", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    -- { "<leader>sg", Util.telescope("live_grep"),                  desc = "Grep (root dir)" },
    -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    -- {
    --   "<leader><space>",
    --   Util.telescope("files"),
    --   desc = "Find Files (root dir)",
    -- },
    -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
    {
      "<leader>ff",
      '<cmd>lua require("telescope.builtin").find_files()<cr>',
      desc = "Find Files (root dir)",
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
    -- git
    {
      "<leader>gf",
      "<cmd>Telescope git_files<cr>",
      desc = "Find Files (git-files)",
    },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    {
      "<leader>dd",
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      desc = "Document diagnostics",
    },
    {
      "<leader>dD",
      "<cmd>Telescope diagnostics<cr>",
      desc = "Workspace diagnostics",
    },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    {
      "<leader>sH",
      "<cmd>Telescope highlights<cr>",
      desc = "Search Highlight Groups",
    },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>sO", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    -- { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }),              desc = "Word (root dir)" },
    -- { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    -- {
    --   "<leader>sw",
    --   Util.telescope("grep_string"),
    --   mode = "v",
    --   desc = "Selection (root dir)",
    -- },
    -- {
    --   "<leader>sW",
    --   Util.telescope("grep_string", { cwd = false }),
    --   mode = "v",
    --   desc = "Selection (cwd)",
    -- },
    -- {
    --   "<leader>uC",
    --   Util.telescope("colorscheme", { enable_preview = true }),
    --   desc = "Colorscheme with preview",
    -- },
    -- {
    --   "<leader>ss",
    --   function()
    --     require("telescope.builtin").lsp_document_symbols({
    --       symbols = require("lazyvim.config").get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol",
    -- },
    -- {
    --   "<leader>sS",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = require("lazyvim.config").get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol (Workspace)",
    -- },
  },
  opts = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local notify_present, _ = pcall(require, "notify")
    if notify_present then
      telescope.load_extension("notify")
    end

    telescope.load_extension("ui-select")
    -- telescope.load_extension("toggletasks")
    -- telescope.load_extension("fzf")
    -- telescope.load_extension("lazygit")
    -- telescope.load_extension("persisted")
    -- telescope.load_extension("projects")

    return {
      defaults = {
        sorting_strategy = "ascending", -- display results top->bottom
        layout_config = {
          -- vertical = { width = 0.5 },
          prompt_position = "top",
          -- center = {
          --   anchor = "N",
          -- },
        },
        prompt_prefix = " > ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          n = {
            ["<C-h>"] = "which_key",
            ["<C-c>"] = actions.delete_buffer,
          },
          i = {
            ["<C-h>"] = "which_key",
            ["<C-c>"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
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
        },
        buffers = {
          theme = "ivy",
          ignore_current_buffer = true,
          sort_mru = true,
        },
      },
      extensions = {
        persisted = {
          layout_config = { width = 0.55, height = 0.55 },
        },
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          -- layout_config = {
          --   preview_height = 0.8,
          -- },
          mappings = {
            i = {
              ["<C-y>"] = require("telescope-undo.actions").yank_additions,
              ["<C-d>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-r>"] = require("telescope-undo.actions").restore,
              ["<CR>"] = require("telescope-undo.actions").restore,
            },
            n = {
              ["y"] = require("telescope-undo.actions").yank_additions,
              ["Y"] = require("telescope-undo.actions").yank_deletions,
              ["u"] = require("telescope-undo.actions").restore,
            },
          },
        },
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
          grouped = true,
          respect_gitignore = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
              -- ["<C-h>"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
              -- ["<C-h>"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
        ["ui-select"] = {
          require("telescope.themes").get_ivy({}),
          -- theme = "ivy",
        },
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          -- ["<C-c>"] = actions.close,
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
    }
  end,
}
