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
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    {
      "jvgrootveld/telescope-zoxide",
      dependencies = { "nvim-lua/popup.nvim" },
    },
  },
  keys = {
    { "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = "Find Files (root dir)" },

    { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
    { "<leader>.", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Explorere" },

    { "<leader>/", '<cmd>lua require("telescope.builtin").live_grep()<cr>', desc = "Grep (root dir)" },
    { "<leader>?", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },

    { "<leader>rf", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },

    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },

    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },

    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },

    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },

    { "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>dD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },

    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>sO", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },

    { "<leader>tt", "<cmd>Telescope lazygit<cr>", desc = "Lazygit" },
    { "<leader>fu", "<cmd>Telescope undo<CR>", desc = "Undo History" },
    { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide History" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        sorting_strategy = "ascending", -- display results top->bottom
        layout_config = {
          prompt_position = "top",
          height = 0.95,
          width = 0.95,
          mirror = true,
        },
        prompt_prefix = " > ",
        selection_caret = " ",
        path_display = { "full" },
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
        file_ignore_patterns = { "%__virtual.cs$" },
      },
      pickers = {
        -- find_files = {
        --   layout_strategy = "horizontal",
        --   layout_config = {
        --     preview_width = 0.6,
        --     mirror = false,
        --   },
        -- },
        -- live_grep = {
        --   theme = "cursor",
        -- },
        -- lsp_references = {
        --   theme = "cursor",
        -- },
        -- diagnostics = {
        --   theme = "ivy",
        -- },
        -- current_buffer_fuzzy_find = {
        --   theme = "dropdown",
        -- },
        buffers = {
          -- theme = "ivy",
          -- layout_config = {
          --   mirror = false,
          -- },
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
          layout_config = {
            preview_height = 0.7,
          },
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
          layout_config = {
            mirror = false,
          },
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
          grouped = true,
          respect_gitignore = true,
        },
        ["ui-select"] = {
          require("telescope.themes").get_ivy({}),
        },
        zoxide = {
          mappings = {
            default = {
              before_action = function(selection)
                vim.cmd.cd(selection.path)
              end,
              after_action = function() end,
              action = require("telescope._extensions.zoxide.utils").create_basic_command("e"),
            },
            ["<C-b>"] = {
              keepinsert = true,
              action = function(selection)
                require("telescope").extensions.file_browser.file_browser({ cwd = selection.path })
              end,
            },
          },
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
    })

    local notify_present, _ = pcall(require, "notify")
    if notify_present then
      telescope.load_extension("notify")
    end

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")

    telescope.load_extension("persisted")
    -- telescope.load_extension("lazygit")
  end,
}
