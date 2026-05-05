---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Files
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>rf",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Git Files",
    },

    -- Buffers & Navigation
    {
      "<leader>,",
      function()
        Snacks.picker.buffers({
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = false,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Switch Buffer",
    },

    -- Search
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep (root dir)",
    },
    {
      "<leader>?",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep in Buffers",
    },

    -- Git
    {
      "<leader>gc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Commits",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },

    -- Pickers
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Auto Commands",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>dd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Document Diagnostics",
    },
    {
      "<leader>dD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlight Groups",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Key Maps",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Jump to Mark",
    },
    {
      "<leader>sO",
      function()
        Snacks.picker.options()
      end,
      desc = "Options",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>fu",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>tt",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },

    -- Buffer
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bD",
      function()
        Snacks.bufdelete({ force = true })
      end,
      desc = "Delete Buffer (Force)",
    },

    {
      "<leader>zz",
      function()
        Snacks.zen()
      end,
      desc = "Delete Buffer (Force)",
    },
    {
      "<leader>zm",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Delete Buffer (Force)",
    },
  },
  opts = {
    input = { enabled = true },
    picker = {
      show_delay = 100,
      limit_live = 1000,
      layout = {
        cycle = true,
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
        },
      },
    },
    notifier = { enabled = true },
    lazygit = { enabled = true },

    quickfile = { enabled = true },
    bigfile = { enabled = true },

    bufdelete = { enabled = true },

    scroll = { enabled = true },

    dim = { enabled = true },
    zen = { enabled = true },
  },
}