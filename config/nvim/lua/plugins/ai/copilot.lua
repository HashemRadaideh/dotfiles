return {
  -- {
  --   "github/copilot.vim",
  --   event = "InsertEnter",
  --   cmd = "Copilot",
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      copilot_model = "claude-3.5-sonnet", -- gpt-35-turbo | gpt-4o-copilot
      suggestion = {
        enabled = false,
        auto_trigger = false,
        hide_during_completion = true,
        keymap = {
          accept_word = false,
          accept_line = false,
          accept = false,
          next = false,
          prev = false,
          dismiss = false,
          -- accept = "<tab>",
          -- next = "<M-]>",
          -- prev = "<M-[>",
          -- dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "right", -- bottom | top | left | right | horizontal | vertical
          ratio = 0.5,
        },
      },
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
    },
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   opts = {},
  -- },
}
